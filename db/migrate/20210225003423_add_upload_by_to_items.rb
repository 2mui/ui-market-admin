class AddUploadByToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :upload_by, :bigint
  end
end
