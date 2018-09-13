class Video < ApplicationRecord
  belongs_to :topic

  before_save :get_video_id
  before_save :get_video_title

  # BUG validation below is preventing create video
  # validates :video_id, length: { minimum: 11 }, presence: true

  def get_video_id
    regex = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
    match = regex.match(url)
    if match && !match[1].blank?
      self.video_id = match[1]
    end
  end

  # BUG temporary - just grab video_id again to use as title for now
  def get_video_title
    regex = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
    match = regex.match(url)
    if match && !match[1].blank?
      self.video_title = "Title of " + match[1]
    end
  end

end
