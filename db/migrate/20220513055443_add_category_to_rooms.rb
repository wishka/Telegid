class AddCategoryToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :category, :string
  end
end
