class AddContentToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :content, :string
  end
end
