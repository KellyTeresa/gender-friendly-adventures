require "rails_helper"

feature "admin views users" do
  scenario "view all users" do
    users = []
    3.times do
      users << FactoryGirl.create(:user)
    end
    visit admin_dashboard_path
    click_link "Manage Users"
    expect(page).to have_content users[0].display_name
    expect(page).to have_content users[0].email
    expect(page).to have_content users[1].display_name
    expect(page).to have_content users[1].email
    expect(page).to have_content users[2].display_name
    expect(page).to have_content users[2].email
  end
end
