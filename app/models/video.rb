class Video < ApplicationRecord
  belongs_to :topic
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save :get_video_id
  before_save :get_video_title

  # default_scope {order('created_at DESC') }
    default_scope {order('rank DESC') }


  def get_video_id
    regex = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
    match = regex.match(url)
    if match && !match[1].blank?
      self.video_id = match[1]
    end
  end

  def get_video_title
    video = Yt::Video.new id: self.video_id
    title = video.title
    if title
      self.video_title = title
    end
  end

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

end
