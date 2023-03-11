require 'rails_helper'

RSpec.feature "Addcomments", type: :feature do
  before(:each) do
    @user1 = User.create(username: "John", password: "password")
    @user2 = User.create(username: "Jane", password: "password")
  end

  scenario "User creates and deletes a comment on another user's profile page" do
    # User logs in
    visit new_session_url
    fill_in 'Username', with: "John"
    fill_in 'Password', with: "password"
    click_button "Log In"

    # User navigates to other user's profile page and leaves a comment
    visit user_url(@user2)
    fill_in 'comment_body', with: "This is a comment"
    click_button "Comment"
    expect(page).to have_text("This is a comment")
    
    # User deletes the comment
    click_on "Delete"
    expect(page).to_not have_text("This is a comment")
  end

end
