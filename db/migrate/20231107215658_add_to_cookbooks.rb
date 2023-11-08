class AddToCookbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :cookbooks, :published_date, :string
    add_column :cookbooks, :image_link, :string
    add_column :cookbooks, :language, :string
    add_column :cookbooks, :google_id, :string
    add_column :cookbooks, :subtitle, :string
  end
end
