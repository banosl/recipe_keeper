class AddUsertoCookbooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :cookbooks, :user, foreign_key: true
  end
end
