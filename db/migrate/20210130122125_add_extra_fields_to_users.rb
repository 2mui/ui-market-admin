class AddExtraFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :login, :string
    add_column :users, :qq, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :nickname, :string
    add_column :users, :gender, :string
    add_column :users, :avatar, :string
    add_column :users, :occupation, :string
    add_column :users, :city, :string
    add_column :users, :cid, :string
    add_column :users, :name, :string
    add_column :users, :last_login_at, :datetime
    add_column :users, :last_login_location, :string
  end
end
