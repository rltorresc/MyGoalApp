require 'rails_helper'

RSpec.feature "Addgoals", type: :feature do

  def create_user(username, password)
    visit new_user_url
    fill_in "Username", with: username
    fill_in "Password", with: password
    click_button "Create User"
  end

  def create_goal(title)
    visit new_goal_url
    fill_in "Title", with: title
    click_button "Create Goal"
  end

  def create_user2(username, password)
    visit new_user_url
    fill_in "Username", with: username
    fill_in "Password", with: password
    click_button "Create User"
  end

  feature "user adds a goal" do

    scenario "user adds a goal" do
      create_user("testuser", "password")
      create_goal("testgoal")
      expect(page).to have_content("testgoal")
    end

    scenario "user adds a goal with no title" do
      create_user("testuser", "password")
      visit new_goal_url
      click_button "Create Goal"
      expect(page).to have_content("Title can't be blank")
    end

    scenario "user adds a goal with no user" do
      visit new_goal_url
      expect(page).to have_content("You must be logged in to create a goal")
    end
  
  end
  feature "user edits a goal" do

    scenario "user edits a goal" do
      create_user("testuser", "password")
      create_goal("testgoal")
      visit edit_goal_url(Goal.last)
      fill_in "Title", with: "testgoal2"
      click_button "Update Goal"
      expect(page).to have_content("testgoal2")
    end
    
    scenario "user edits a goal from another user" do
      create_user("testuser", "password")
      create_goal("testgoal")
      click_on "Sign Out"
      create_user2("testuser2", "password")
      visit edit_goal_url(Goal.last)
      expect(page).to have_content("You are not authorized to edit this goal")
    end
  end

  feature "user deletes a goal" do
    
    scenario "user deletes a goal" do
      create_user("testuser", "password")
      create_goal("testgoal")
      visit goal_url(Goal.last)
      expect(page).to have_content("testgoal")
      click_on "Delete Goal"
      expect(page).to_not have_content("testgoal")
    end
    
    scenario "user deletes a goal from another user" do
      create_user("testuser", "password")
      create_goal("testgoal")
      click_on "Sign Out"
      create_user2("testuser2", "password")
      visit goal_url(Goal.last)
      click_on "Delete Goal"
      expect(page).to have_content("You are not authorized to edit this goal")
    end
  end
end
