require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "POST #create" do
    let(:user) { User.create(username: "John", password: "password") }
    let(:goal) { Goal.create(title: "Test Goal", user: user) }
    let(:user2) { User.create(username: "John2", password: "password") }
    before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) }
    it "creates a new comment" do
      post goal_comments_url(goal), params: { comment: { body: "This is a comment" } }
      expect(response).to redirect_to(goal_url(goal))
      follow_redirect!

      expect(Comment.count).to eq(1)
      comment = Comment.first
      expect(comment.body).to eq("This is a comment")
      expect(comment.user).to eq(user)
      expect(comment.commentable).to eq(goal)
    end
    it "renders a error if is invalid" do
      post goal_comments_url(goal), params: { comment: { body: "" } }
      expect(flash[:errors]).to be_present
    end

  end

  describe "DELETE #destroy" do
    let(:user) { User.create(username: "John", password: "password") }
    let(:goal) { Goal.create(title: "Test Goal", user: user) }
    let!(:comment) { Comment.create(body: "Test comment", user: user, commentable: goal) }

    it "deletes the comment" do
      delete url_for(comment)
      expect(Comment.count).to eq(0)
    end

    it "redirects to the commentable's page" do
      delete url_for(comment)
      expect(response).to redirect_to(goal_url(goal))
    end
  end
end
