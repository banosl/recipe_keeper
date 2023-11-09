class AddDescriptionToCookbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :cookbooks, :description, :string
  end
end
