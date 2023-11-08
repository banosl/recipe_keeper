class ChangeAuthorInCookbooks < ActiveRecord::Migration[7.0]
  def change
    change_column :cookbooks, :author, "varchar[] USING (string_to_array(author, ','))"
    rename_column :cookbooks, :author, :authors
  end
end
