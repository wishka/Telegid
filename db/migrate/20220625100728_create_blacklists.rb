class CreateBlacklists < ActiveRecord::Migration[6.1]
  def change
    create_table :blacklists do |t|
      t.references :blacklists, null: false, foreign_key: true
      t.timestamps
    end
  end
end
