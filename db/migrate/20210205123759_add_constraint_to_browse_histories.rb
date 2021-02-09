class AddConstraintToBrowseHistories < ActiveRecord::Migration[6.1]
  def self.up
    execute 'ALTER TABLE browse_histories ADD CONSTRAINT browse_histories_item_id_user_id_key unique ("item_id", "user_id")'
  end

  def self.down
    execute "ALTER TABLE browse_histories DROP CONSTRAINT browse_histories_item_id_user_id_key"
  end
end

