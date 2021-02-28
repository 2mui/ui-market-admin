class CreateBanners < ActiveRecord::Migration[6.1]
  def change
    create_table :banners do |t|
      t.string :image
      t.string :alt
      t.integer :position
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :banners, :discarded_at
  end
end
