class Comment < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true
end
