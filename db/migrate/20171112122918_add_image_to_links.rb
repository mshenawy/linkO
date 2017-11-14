class AddImageToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :image, :string
  end
end
