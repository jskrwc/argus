class AddVideoIdToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :video_id, :string
  end
end
