require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations'
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_length_of(:password).is_at_least(6).allow_nil}
  it {should validate_presence_of(:session_token)}
  it {should have_many(:goals)}

  let(:user) {User.new(username: 'test')}
  before {user.save}

  context 'username uniqueness' do
    let(:user1) {User.new(username: 'test')}

    it {expect(user1).to_not be_valid}
  end

  describe 'methods' do
    describe '::find_by_credentials' do
      let (:user) {User.create(username: 'test', password: 'password')}
      it 'should return a user if the username and password are correct' do
        expect(User.find_by_credentials(user.username, 'password')).to eq(user)
      end
      it 'should return nil if the password are incorrect' do
        expect(User.find_by_credentials(user.username, 'wrong_password')).to eq(nil)
      end
      it 'should return nil if the username is incorrect' do
        expect(User.find_by_credentials('wrong_username', 'password')).to eq(nil)
      end
    end

    describe '#is_password?' do
      let(:user) {User.create(username: 'test', password: 'password')}
      it {expect(user.is_password?('password')).to be true}
      it {expect(user.is_password?('wrong_password')).to be false}
    end

    describe '#reset_session_token!' do
      let(:user) {User.create(username: 'test', password: 'password')}
      it 'should reset the session token' do
        old_session_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).to_not eq(old_session_token)
        expect(user.reload.session_token).to_not eq(old_session_token)
      end
    end
  end
end
