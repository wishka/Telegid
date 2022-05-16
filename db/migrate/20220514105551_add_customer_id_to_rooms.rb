class AddCustomerIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :customer_id, :integer
  end
end
