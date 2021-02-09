class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.string :cover
      t.string :detail
      t.string :url
      t.string :author, default: "二木设计"
      # t.integer :category_id
      # t.integer :industry_id
      t.references :category, null: false, foreign_key: true
      t.references :industry, null: false, foreign_key: true
      t.integer :likes_count, default: 0
      t.integer :downloads_count, default: 0
      t.integer :browses_count, default: 0
      t.string :filesize, default: 0
      t.boolean :featured, default: false
      t.boolean :draft, default: true
      t.timestamps
    end
  end
end
