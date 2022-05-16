class CreateTelechannels < ActiveRecord::Migration[6.1]
  def change
    create_table :telechannels do |t|
      t.string :name
      t.string :content
      t.string :image

      t.timestamps
    end
  end
end
