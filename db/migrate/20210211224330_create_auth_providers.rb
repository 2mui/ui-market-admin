class CreateAuthProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :auth_providers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
