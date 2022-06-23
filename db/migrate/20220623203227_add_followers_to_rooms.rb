class AddFollowersToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :followers, :string
  end
end
