class Topic < ApplicationRecord
  belongs_to :user
  has_many :videos, dependent: :destroy

  validates :title, length: { minimum: 3 }, presence: true
end
