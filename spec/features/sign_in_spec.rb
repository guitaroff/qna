require 'rails_helper'

feature 'User sign in', %q{
  In order to able to ask question
  As an user
  I want to be able to sign in
} do
  scenario 'Registered user try to sign in' do
    User.create(email: 'ex1@example.com', password: '123456')

    visit new_user_session_path
    fill_in 'Email', with: 'ex1@example.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'non_registered@example.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    
    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
