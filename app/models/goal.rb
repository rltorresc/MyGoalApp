class Goal < ApplicationRecord
    validates :title, :user_id, presence: { message: 'Title can\'t be blank' }
    validates :private, inclusion: { in: [true, false] }
    validates :completed, inclusion: { in: [true, false] }

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id
    has_many :comments, as: :commentable

end
