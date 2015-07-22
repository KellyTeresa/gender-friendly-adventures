require "rails_helper"
require "faker"

feature "admit edits a venue", %(
As an admin, I want to edit a venue
So I can correct information before approving it
Or update information that has changed.
) do
  let(:admin) { FactoryGirl.create(:user, admin: true) }
  let(:venue) { FactoryGirl.create(:venue) }
  before(:each) do
    visit new_user_session_path
    sign_in_as(admin)
  end

  xscenario "from admin panel" do
    visit admin_dashboard_path
    click_link "Pending Venues"
    click_link venue.name
    click_link "Edit"
    fill_in "description", with: Faker::Lorem.paragraph
    click_button "Save and Approve"
  end

  xscenario "from regular show page" do

  end
end
