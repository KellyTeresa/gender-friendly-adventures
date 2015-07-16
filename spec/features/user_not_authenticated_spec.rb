require "rails_helper"

feature "a user who is not signed in cannot access member-only pages" do
  scenario "user attempts to add new business" do
    visit new_business_path
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end

  scenario "user cannot see link to profile" do
    visit root_path
    expect(page).to_not have_content "My Profile"
  end

  context "user who is not signed in attempts to add a review" do
    let (:venue) { FactoryGirl.create(:business) }
    scenario "from business show page" do
      visit business_path(venue)
      click_link "Add Review"
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end

    scenario "from url" do
      visit new_business_review_path(venue)
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end
end
