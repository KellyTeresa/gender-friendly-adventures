require "rails_helper"

feature "adding a venue" do
  let (:venue) { FactoryGirl.build(:venue) }
  let (:user) { FactoryGirl.create(:user) }

  context "signed in user" do
    before(:each) do
      visit new_user_session_path
      sign_in_as(user)
    end

    scenario "correctly provide information" do
      visit new_venue_path
      fill_in "Name", with: venue.name
      fill_in "Street address", with: venue.street_address
      fill_in "City", with: venue.city
      fill_in "State", with: venue.state
      fill_in "Zip code", with: venue.zip_code
      fill_in "Short description", with: venue.summary
      click_button "Submit"
      expect(page).to have_content "Venue queued for approval."
      expect(current_path).to eq(venues_path)
    end

    scenario "missing information" do
      visit new_venue_path
      fill_in "Name", with: venue.name
      click_button "Submit"
      expect(page).to have_content "errors prohibited this
        venue from being saved"
      expect(page).to have_field("Name", with: venue.name)
    end

    scenario "navigate from root" do
      visit root_path
      click_link "Add Venue"
      expect(current_path).to eq(new_venue_path)
    end
  end

  scenario "correctly provide information AND is admin" do
    admin = FactoryGirl.create(:user, admin: true)
    visit new_user_session_path
    sign_in_as(admin)
    visit new_venue_path
    fill_in "Name", with: venue.name
    fill_in "Street address", with: venue.street_address
    fill_in "City", with: venue.city
    fill_in "State", with: venue.state
    fill_in "Zip code", with: venue.zip_code
    fill_in "Short description", with: venue.summary
    click_button "Submit"
    expect(page).to have_content venue.name
    expect(page).to have_content venue.street_address
    expect(page).to have_content venue.summary
    expect(page).to have_content "Venue added."
  end

  scenario "unauthenticated user attempts to add new venue" do
    visit new_venue_path
    expect(page).to have_content "You need to sign in
      or sign up before continuing."
  end
end
