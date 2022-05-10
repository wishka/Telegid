class AddBodyToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :body, :string
  end
end
