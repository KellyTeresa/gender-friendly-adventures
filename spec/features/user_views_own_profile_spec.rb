require "rails_helper"

feature "user visits their profile" do
  let (:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_user_session_path
    sign_in_as(user)
  end
  
  xscenario "visit from root" do
    visit root_path
    click_link "My Profile"
    expect(page).to have_content user.display_name
    expect(current_path).to eq user_path(user)
  end
end
