require 'rails_helper'

RSpec.describe "Goals", type: :request do
  describe "GET #index" do
    it "returns http success" do
      get "/goals"
      expect(response).to render_template(:index)
    end
  end
  describe "GET /new" do
    it "returns http success" do
      get "/goals/new"
      expect(response).to render_template(:new)
    end
  end
  
  describe "GET /show" do
    let (:user) {User.create(username: 'test', password: 'password')}
    let (:goal) {Goal.create(title: 'test', user_id: user.id, private: false, completed: false)}
    it "returns http success" do
      get "/goals/#{goal.id}"
      expect(response).to render_template(:show)
    end
  end

  describe "POST /create" do
    let (:user) {User.create(username: 'test', password: 'password')}
    it "returns http success" do
      post "/goals", params: {goal: {title: 'test', user_id: user.id, private: false, completed: false}}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /edit" do
    let (:user) {User.create(username: 'test', password: 'password')}
    let (:goal) {Goal.create(title: 'test', user_id: user.id, private: false, completed: false)}
    it "returns http success" do
      get "/goals/#{goal.id}/edit"
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /update" do
    let (:user) {User.create(username: 'test', password: 'password')}
    let (:goal) {Goal.create(title: 'test', user_id: user.id, private: false, completed: false)}
    it "returns http success" do
      patch "/goals/#{goal.id}", params: {goal: {title: 'test', user_id: user.id, private: false, completed: false}}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE /destroy" do
    let (:user) {User.create(username: 'test', password: 'password')}
    let (:goal) {Goal.create(title: 'test', user_id: user.id, private: false, completed: false)}
    it "returns http success" do
      delete "/goals/#{goal.id}"
      expect(response).to have_http_status(:redirect)
    end
  end
end
