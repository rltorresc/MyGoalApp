require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:body) }
  
  describe "add a coment to a goal" do
    before do
      @user = User.create(username: "John", password: "password")
      @goal = Goal.create(title: "Goal", user: @user)
      @comment = Comment.new(body: "This is a comment", user: @user, commentable: @goal)
      @goal_comment_count = @goal.comments.count
      @comment.save
      @goal.reload
    end
  
    it "associates the comment with the correct goal" do
      expect(@comment.commentable).to eq(@goal)
    end
  
    it "increases the number of comments on the goal" do
      expect(@goal.comments.count).to eq(@goal_comment_count + 1)
    end
  end
  describe "adding a comment to a user" do
    before do
      @user1 = User.create(username: "John", password: "password")
      @user2 = User.create(username: "Jane", password: "password")
      @comment = Comment.new(body: "This is a comment", user: @user1, commentable: @user2)
      @user2_comment_count = @user2.comments.count
      @comment.save
      @user2.reload
    end
  
    it "associates the comment with the correct user" do
      expect(@comment.commentable).to eq(@user2)
    end
  
    it "increases the number of comments on the user" do
      expect(@user2.comments.count).to eq(@user2_comment_count + 1)
    end
  end
end
