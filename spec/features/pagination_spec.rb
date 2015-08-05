require "rails_helper"

feature "pagination is visible" do
  it "has multiple pages when there are more than 10 venues" do
    11.times { FactoryGirl.create(:venue, approved: true) }
    visit root_path
    expect(page).to have_content("1 2 Next")
  end
end
