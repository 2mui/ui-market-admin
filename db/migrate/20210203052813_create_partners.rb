class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :url
      t.string :image
      t.integer :position

      t.timestamps
    end
  end
end
