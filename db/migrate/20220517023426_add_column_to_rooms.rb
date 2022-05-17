class AddColumnToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :route, :string
    add_column :rooms, :cat_route, :string
    add_column :rooms, :city, :string
    add_column :rooms, :subdir, :string
    add_column :rooms, :option, :string
  end
end
