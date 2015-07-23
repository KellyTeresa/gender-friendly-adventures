require "rails_helper"

feature "admin views users" do
  let(:admin) { FactoryGirl.create(:user, admin: true) }
  before(:each) do
    visit root_path
    sign_in_as(admin)
  end

  scenario "view all users" do
    users = []
    2.times do
      users << FactoryGirl.create(:user)
    end
    visit admin_dashboard_path
    click_link "Manage Users"
    expect(page).to have_content "#{users[0].display_name} #{users[0].email} No"
    expect(page).to have_content "#{users[1].display_name} #{users[1].email} No"
    expect(page).to have_content "#{admin.display_name} #{admin.email} Yes"
  end

  scenario "make user an admin" do
    user = FactoryGirl.create(:user)
    visit admin_users_path
    expect(page).to have_content "#{user.display_name} #{user.email} No"
    expect(page).to have_content "#{admin.display_name} #{admin.email} Yes"
    click_link "Make Admin"
    expect(page).to have_content "Admin added."
    expect(page).to have_content "#{user.display_name} #{user.email} Yes"
  end

  scenario "remove admin status from a user" do
    admin2 = FactoryGirl.create(:user, admin: true)
    visit admin_users_path
    expect(page).to have_content "#{admin2.display_name} #{admin2.email} Yes"
    expect(page).to have_content "#{admin.display_name} #{admin.email} Yes"
    find(
      :xpath, "//a[@href='/admin/users/#{admin2.id}/edit?status=remove']"
    ).click
    expect(page).to have_content "Admin removed."
    expect(page).to have_content "#{admin2.display_name} #{admin2.email} No"
  end

  scenario "cannot remove own admin status" do
    visit admin_users_path
    click_link "Remove Admin"
    expect(page).to have_content "You cannot change your own admin status."
    expect(page).to have_content "#{admin.display_name} #{admin.email} Yes"
  end
end
