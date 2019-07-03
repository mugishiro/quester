class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :username, :string
    add_column :users, :nickname, :string
    add_column :users, :image_url, :string
    add_column :users, :description, :string
    add_column :users, :access_token, :string
    add_column :users, :access_secret, :string
  end
end
