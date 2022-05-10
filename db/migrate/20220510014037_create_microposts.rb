class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.string :title
      t.string :content
      t.string :image

      t.timestamps
    end
  end
end
