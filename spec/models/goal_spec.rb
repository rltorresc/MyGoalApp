require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:private) }
    it { should validate_presence_of(:completed) }
    it { should belong_to(:user) }
  end
end
