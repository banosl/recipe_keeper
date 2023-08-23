class CreateCookbooks < ActiveRecord::Migration[7.0]
  def change
    create_table :cookbooks do |t|
      t.string :name
      t.string :isbn
      t.string :author
      t.string :publisher

      t.timestamps
    end
  end
end
