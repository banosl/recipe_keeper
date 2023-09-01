class ChangeGoogleIdInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :google_id, :bigint
  end
end
