require 'rails_helper'

feature "user looks at homepage" do
  scenario "they see a list of businesses" do
    businesses = []
    5.times do
      businesses << FactoryGirl.create(:business)
    end
    visit root_path
    expect(page).to have_content businesses[0].name
    expect(page).to have_content businesses[1].name
    expect(page).to have_content businesses[2].name
    expect(page).to have_content businesses[3].name
    expect(page).to have_content businesses[4].name
  end

  scenario "they can navigate to a show page" do
    business = FactoryGirl.create(:business)
    visit root_path
    click_link business.name
    expect(page).to have_content business.summary
  end

end
