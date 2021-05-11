class AddRequestIdToResourceItems < ActiveRecord::Migration[6.1]
  def change
    add_column :resource_items, :request_id, :string
  end
end
