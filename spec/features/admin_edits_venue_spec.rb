require "rails_helper"
require "faker"

feature "admit edits a venue", %(
As an admin, I want to edit a venue
So I can correct information before approving it
Or update information that has changed.
) do
  context "an admin edits" do
    let(:admin) { FactoryGirl.create(:user, admin: true) }
    let!(:venue) { FactoryGirl.create(:venue) }
    let!(:approved_venue) { FactoryGirl.create(:venue, approved: true) }
    before(:each) do
      visit new_user_session_path
      sign_in_as(admin)
    end

    scenario "from admin panel" do
      visit admin_dashboard_path
      click_link "Pending Venues"
      click_link venue.name
      click_link "Edit"
      expect(current_path).to eq(edit_venue_path(venue))
      fill_in "Long description", with: Faker::Lorem.paragraph
      click_button "Save and Approve"
      expect(page).to have_content("Venue updated.")
    end

    scenario "from regular show page" do
      visit venue_path(approved_venue)
      click_link "Edit"
      fill_in "Long description", with: Faker::Lorem.paragraph
      click_button "Save and Approve"
      expect(page).to have_content("Venue updated.")
    end
  end

  context "a non-admin tries to edit" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:venue) { FactoryGirl.create(:venue, approved: true) }
    scenario "regular user cannot edit a venue" do
      visit new_user_session_path
      sign_in_as(user)
      visit edit_venue_path(venue)
      expect(page).to have_content "You must be signed in as
        an admin to view this page."
    end

    scenario "signed-out user cannot edit a venue" do
      visit edit_venue_path(venue)
      expect(page).to have_content "You must be signed in as
        an admin to view this page."
    end
  end
end
