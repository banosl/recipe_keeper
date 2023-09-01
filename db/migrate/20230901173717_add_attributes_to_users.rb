class AddAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :google_id, :integer
    add_column :users, :google_token, :string
    add_column :users, :profile_picture, :string
  end
end
