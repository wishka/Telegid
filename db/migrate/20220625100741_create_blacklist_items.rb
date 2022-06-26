class CreateBlacklistItems < ActiveRecord::Migration[6.1]
  def change
    create_table :blacklist_items do |t|
      t.integer :blacklist_id
      t.integer :customer_id
      t.timestamps
    end
  end
end
