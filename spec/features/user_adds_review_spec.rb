require "rails_helper"

feature "add a review" do
  let (:venue) { FactoryGirl.create(:venue, approved: true) }
  let (:user) { FactoryGirl.create(:user) }
  let (:review) { FactoryGirl.build(:review) }

  context "signed in" do
    before(:each) do
      visit new_user_session_path
      sign_in_as(user)
      visit venue_path(venue)
      click_link "Add Review"
    end

    scenario "user adds a review with minimum required fields" do
      choose review.overall
      fill_in "review[comment]", with: review.comment
      click_button "Add Review"
      expect(page).to have_content "Review added!"
      expect(page).to have_content review.comment
    end

    scenario "user adds a review including optional fields" do
      select "Occasionaly", from: "review[terminology]"
      select "Gender based single stall, no key/code required.",
        from: "review[bathrooms]"
      choose "Yes"
      choose review.overall
      fill_in "review[comment]", with: review.comment
      click_button "Add Review"
      expect(page).to have_content "Review added!"
      expect(page).to have_content review.comment
    end

    scenario "user attempts to add review with missing fields" do
      fill_in "review[comment]", with: review.comment
      click_button "Add Review"
      expect(page).to have_content "prohibited this review from being saved"
      expect(page).to have_field("review[comment]", with: review.comment)
    end
  end

  context "not signed in" do
    scenario "from venue show page" do
      visit venue_path(venue)
      click_link "Add Review"
      expect(page).to have_content "You need to sign in
        or sign up before continuing."
    end

    scenario "from url" do
      visit new_venue_review_path(venue)
      expect(page).to have_content "You need to sign in
        or sign up before continuing."
    end
  end
end
