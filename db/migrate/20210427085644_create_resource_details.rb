class CreateResourceDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_details do |t|
      t.string :title
      t.string :description
      t.string :cover
      t.string :detail
      t.string :url
      t.integer :category_id
      t.integer :industry_id
      t.integer :upload_by
      t.boolean :featured, default: false
      t.boolean :draft, default: true
      t.boolean :processed, default: false

      t.timestamps
    end
  end
end
