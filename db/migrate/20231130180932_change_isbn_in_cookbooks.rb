class ChangeIsbnInCookbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :cookbooks, :isbn_temp, :jsonb

    Cookbook.find_each do |cookbook|
      json_data = cookbook.isbn.gsub("=>", ": ")
      isbn_hash = JSON.parse(json_data)
      cookbook.update(isbn_temp: isbn_hash)
    end

    remove_column :cookbooks, :isbn
    
    rename_column :cookbooks, :isbn_temp, :isbn
  end
end
