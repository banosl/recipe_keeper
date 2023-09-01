class RemoveUserFromCookbooks < ActiveRecord::Migration[7.0]
  def change
    remove_reference :cookbooks, :user, add_foreign_key: true, index: false
  end
end
