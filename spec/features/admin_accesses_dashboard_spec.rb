require "rails_helper"

feature "admin user can access admin dashboard" do
  context "signed-in admin interacts with dashboard" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    xscenario "navigating to dashboard from url" do
      visit root_path
      sign_in_as(admin)
      visit admin_dashboard_path
      expect(page).to have_content "Admin Dashboard"
    end

    scenario "navigating to dashboard from link" do
      visit root_path
      sign_in_as(admin)
      click_link "Admin Dashboard"
      expect(page).to have_content "View Users"
      expect(page).to have_content "Pending Venues"
    end

    xscenario "view users" do
      users = []
      3.times do
        users << FactoryGirl.create(:user)
      end
      visit admin_dashboard_path
    end

    xscenario "view pending venues" do
      visit admin_dashboard_path
    end

    xscenario "approve venue" do

    end

  end

  context "signed-in non-admin does not reach dashboard" do
    xscenario "navigating to dashboard from url" do

    end

    xscenario "navigating to dashboard from site" do

    end
  end

  context "signed-out user does not reach dashboard" do
    xscenario "navigating to dashboard from url" do

    end

    xscenario "navigating to dashboard from site" do

    end
  end
end
