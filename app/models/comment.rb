class Comment < ApplicationRecord
  belongs_to :video
  belongs_to :user

  validates :body, length: {minimum: 3 }, presence: true
  validates :user, presence: true
end
