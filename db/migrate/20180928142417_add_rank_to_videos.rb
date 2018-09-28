class AddRankToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :rank, :float
  end
end
