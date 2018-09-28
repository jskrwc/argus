class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :video
  after_save :update_video

  validates :value, inclusion: { in: [-1,1], message: "%{value] is not a valid vote."}, presence: true

  private

  def update_video
    video.update_rank
  end
end
