class AddVideoTitleToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :video_title, :string
  end
end
