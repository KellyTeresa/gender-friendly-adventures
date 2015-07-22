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
    expect(page).to have_content users[0].display_name
    expect(page).to have_content users[0].email
    expect(page).to have_content users[1].display_name
    expect(page).to have_content users[1].email
    expect(page).to have_content admin.display_name
    expect(page).to have_content admin.email
  end

  xscenario "make user an admin" do

  end
end
