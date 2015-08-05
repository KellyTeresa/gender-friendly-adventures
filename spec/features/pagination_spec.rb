require "rails_helper"

feature "pagination is visible" do
  it "has multiple pages when there are more than 8 venues" do
    9.times { FactoryGirl.create(:venue, approved: true) }
    visit root_path
    expect(page).to have_content("1 2 Next")
  end
end
