class AddOauthProvderToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :oauth_provider, :integer
  end
end
