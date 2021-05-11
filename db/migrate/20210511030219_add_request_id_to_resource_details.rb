class AddRequestIdToResourceDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :resource_details, :filetypes, :string
    add_column :resource_details, :request_id, :string
    add_column :resource_details, :original_url, :string
  end
end
