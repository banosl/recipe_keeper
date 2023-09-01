class ChangeReferencesForLibraries < ActiveRecord::Migration[7.0]
  def change
    remove_reference :libraries, :user, foreign_key: true, index: false
    add_reference :libraries, :user, null: false, index:{ unique: true }, foreign_key: true
  end
end
