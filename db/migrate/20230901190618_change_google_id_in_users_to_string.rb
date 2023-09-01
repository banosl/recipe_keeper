class ChangeGoogleIdInUsersToString < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :google_id, :string
  end
end
