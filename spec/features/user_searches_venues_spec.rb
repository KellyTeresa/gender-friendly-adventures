require "rails_helper"

feature "search venues" do
  before(:each) do
    FactoryGirl.create(:venue, name: "1369 Coffee House")
    FactoryGirl.create(:venue, name: "Backbar")
  end

  scenario "valid search" do
    visit root_path
    fill_in "q", with: "1369"
    click_button "Go"
    expect(page).to have_content "1369 Coffee House"
    expect(page).to_not have_content "Backbar"
  end

  scenario "no valid search" do
    visit root_path
    fill_in "q", with: "Bronwyn"
    click_button "Go"
    expect(page).to have_content "No results"
  end

  scenario "blank search" do
    visit root_path
    click_button "Go"
    expect(page).to have_content "Please specify a search phrase"
  end
end
