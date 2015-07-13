require 'rails_helper'

feature 'user edits profile', %Q{
  As an authenticated user
  I want to edit my profile
  So I can change my display name.
} do

  let (:user) { FactoryGirl.create(:user) }

  scenario 'authenticated user edits profile' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit edit_user_registration_path
    fill_in 'Display name', with: 'Bruh'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content 'Your account has been updated successfully.'
    expect(page).to have_content 'Bruh'
    expect(current_path).to eq user_path(user)
  end

  scenario 'unauthenticated user attempts to visit edit path' do
    visit edit_user_registration_path
    expect(page).to have_content 'You need to sign in or sign up before
      continuing.'
  end
end
