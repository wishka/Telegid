class AddLinksToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :link, :string
  end
end
