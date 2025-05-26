class TwitterAccount < ApplicationRecord
  has_many :tweets
  belongs_to :user
  validates :username, presence: true, uniqueness: true
end
