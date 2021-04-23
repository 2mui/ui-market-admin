class CreateResourceItems < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_items do |t|
      t.string :title
      t.string :link
      t.boolean :scraped

      t.timestamps
    end
  end
end
