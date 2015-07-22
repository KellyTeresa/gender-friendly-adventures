require 'rails_helper'

feature "user looks at homepage" do
  scenario "they see a list of venues" do
    venues = []
    5.times do
      venues << FactoryGirl.create(:venue, approved: true)
    end
    visit root_path
    expect(page).to have_content venues[0].name
    expect(page).to have_content venues[1].name
    expect(page).to have_content venues[2].name
    expect(page).to have_content venues[3].name
    expect(page).to have_content venues[4].name
  end

  scenario "they can navigate to a show page" do
    venue = FactoryGirl.create(:venue, approved: true)
    visit root_path
    click_link venue.name
    expect(page).to have_content venue.summary
  end

end
