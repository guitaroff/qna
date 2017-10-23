require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
  } do

  scenario 'Authenticated user creates a question' do
    User.create(email: 'ex1@example.com', password: '123456')

    visit new_user_session_path
    fill_in 'Email', with: 'ex1@example.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Non-authenticated user ties to create question' do
    visit questions_path
    click_on 'Ask question'
    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
