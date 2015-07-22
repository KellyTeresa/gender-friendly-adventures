require "rails_helper"

feature "admin reviews pending venues" do
  let(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:venues) {
    [
      FactoryGirl.create(:venue),
      FactoryGirl.create(:venue),
      FactoryGirl.create(:venue)
    ]
  }

  before(:each) do
    visit new_user_session_path
    sign_in_as(admin)
  end

  scenario "view pending venues" do
    visit admin_dashboard_path
    click_link "Pending Venues"
    expect(current_path).to eq(admin_venues_path)
    expect(page).to have_content venues[0].name
    expect(page).to have_content venues[1].name
    expect(page).to have_content venues[2].name
  end

  scenario "view show page and approve venue" do
    visit admin_venues_path
    click_link venues[0].name
    click_link "Approve"
    expect(page).to have_content "Venue approved."
    expect(page).to_not have_content(venues[0].name)
    expect(page).to have_content venues[1].name
    expect(page).to have_content venues[2].name
    expect(current_path).to eq(admin_venues_path)
  end

  scenario "find approved venue on regular index" do
    visit admin_venues_path
    click_link venues[0].name
    click_link "Approve"
    expect(page).to have_content "Venue approved."
    visit root_path
    expect(page).to have_content(venues[0].name)
  end
end
