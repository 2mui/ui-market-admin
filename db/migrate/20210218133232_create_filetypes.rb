class CreateFiletypes < ActiveRecord::Migration[6.1]
  def change
    create_table :filetypes do |t|
      t.string :ext

      t.timestamps
    end
  end
end
