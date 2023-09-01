class AddLibraryToCookbooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :cookbooks, :library, null: false, foreign_key: true
  end
end
