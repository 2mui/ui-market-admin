class AddConstraintToDownloadHistories < ActiveRecord::Migration[6.1]
  def self.up
    execute 'ALTER TABLE download_histories ADD CONSTRAINT download_histories_item_id_user_id_key unique ("item_id", "user_id")'
  end

  def self.down
    execute "ALTER TABLE download_histories DROP CONSTRAINT download_histories_item_id_user_id_key"
  end
end
