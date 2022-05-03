class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.string :price
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:customer_id, :created_at]
  end
end
