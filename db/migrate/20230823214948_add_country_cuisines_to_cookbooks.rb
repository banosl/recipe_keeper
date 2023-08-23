class AddCountryCuisinesToCookbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :cookbooks, :country_cuisine, :string
  end
end
