class AddLinksToTelechannels < ActiveRecord::Migration[6.1]
  def change
    add_column :telechannels, :links, :string
  end
end
