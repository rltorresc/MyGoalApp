require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #new" do
    it "renders the new user page" do
      get new_user_url
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to the user show page" do
       post '/users', params: {user: {username: 'test', password: 'password'}}
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "validates the presence of the user's username and password" do
        post '/users', params: { user: { username: '', password: '' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post '/users', params: { user: { username: 'test', password: '12345' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
end
