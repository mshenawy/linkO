class AddArabicNameToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :arabic_name, :string
  end
end
