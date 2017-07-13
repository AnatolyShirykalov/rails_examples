class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps
    end
    add_index :cars, :name, unique: true
  end
end
