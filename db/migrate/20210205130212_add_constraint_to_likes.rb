class AddConstraintToLikes < ActiveRecord::Migration[6.1]
  def self.up
    execute 'ALTER TABLE likes ADD CONSTRAINT likes_item_id_user_id_key unique ("item_id", "user_id")'
  end

  def self.down
    execute "ALTER TABLE likes DROP CONSTRAINT likes_item_id_user_id_key"
  end
end
