class AddFiletypeToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :filetype, :jsonb
  end
end
