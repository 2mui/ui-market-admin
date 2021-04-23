class CreateResourceCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_categories do |t|
      t.string :category_name
      t.string :link_to_extract

      t.timestamps
    end
  end
end
