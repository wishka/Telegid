class AddOptionsToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :hot, :boolean, default: false
    add_column :rooms, :big_size, :boolean, default: false
    add_column :rooms, :carousel, :boolean, default: false
    add_column :rooms, :free, :boolean, default: false
  end
end
