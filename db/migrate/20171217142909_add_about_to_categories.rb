class AddAboutToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :about, :string
  end
end
