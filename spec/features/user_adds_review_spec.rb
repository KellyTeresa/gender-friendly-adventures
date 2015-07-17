require "rails_helper"

feature "add a review" do
  let (:venue) { FactoryGirl.create(:business) }
  let (:user) { FactoryGirl.create(:user) }
  let (:review) { FactoryGirl.build(:review) }

  before(:each) do
    visit new_user_session_path
    sign_in_as(user)
    visit business_path(venue)
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
