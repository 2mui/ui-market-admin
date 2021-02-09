class AddConstraintToFolders < ActiveRecord::Migration[6.1]
  def self.up
    execute 'ALTER TABLE folders ADD CONSTRAINT folders_name_user_id_key unique ("name", "user_id")'
  end

  def self.down
    execute "ALTER TABLE folders DROP CONSTRAINT folders_name_user_id_key"
  end
end
