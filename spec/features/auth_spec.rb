require 'rails_helper'

RSpec.feature "Auths", type: :feature do
  def login(username, password)
    visit new_session_url
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_on 'Log In'
  end
  
  feature 'the signup process' do
    scenario 'has a new user page' do
      visit new_user_url
      expect(page).to have_content('Create a New User')
    end
    feature 'signing up a user' do
      before(:each) do
        visit new_user_url
        fill_in 'Username', with: 'test'
        fill_in 'Password', with: 'password'
        click_on 'Create User'
      end

      scenario 'shows username on the homepage after signup' do
        expect(page).to have_content('Welcome')
      end
  
    end
  end
  
  feature 'logging in' do
    before(:each) do
      User.create(username: 'test', password: 'password')
      login('test', 'password')
    end
    scenario 'shows username on the homepage after login' do
      expect(page).to have_content('test')
    end
  
  end
  
  feature 'logging out' do
    before(:each) do
      User.create(username: 'test', password: 'password')
      login('test', 'password')
    end
    scenario 'begins with a logged out state' do
      click_on 'Sign Out'
      expect(page).to have_content('Log In')
    end
    scenario 'doesn\'t show username on the homepage after logout' do
      click_on 'Sign Out'
      expect(page).to_not have_content('test')
    end
  
  end
end
