class ChangeNameInCookbooks < ActiveRecord::Migration[7.0]
  def change
    rename_column(:cookbooks, :name, :title)
  end
end
