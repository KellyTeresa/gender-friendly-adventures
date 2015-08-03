require "rails_helper"

feature "Venues appearing in search results" do
  scenario "an approved venue will appear" do
    venue = FactoryGirl.create(:venue, approved: true)
    visit root_path
    fill_in "q", with: venue.name
    expect(page).to have_content venue.name
  end

  scenario "a queued venue will not appear" do
    venue = FactoryGirl.create(:venue)
    visit root_path
    fill_in "q", with: venue.name
    expect(page).to_not have_content venue.name
  end
end

feature "Categories shown on index page" do
  let!(:diner) { Category.create(name: "Diner") }
  scenario "a category with approved venues will appear" do
    FactoryGirl.create(:venue, approved: true, categories: [diner])
    visit root_path
    expect(page).to have_content "Diner"
  end

  scenario "a category with only queued venues will not appear" do
    FactoryGirl.create(:venue, categories: [diner])
    visit root_path
    expect(page).to_not have_content "Diner"
  end
end
