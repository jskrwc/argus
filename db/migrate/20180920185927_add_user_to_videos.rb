class AddUserToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :user_id, :integer
    add_index :videos, :user_id
  end
end
