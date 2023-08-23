class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :measurement_us
      t.string :measurement_metric

      t.timestamps
    end
  end
end
