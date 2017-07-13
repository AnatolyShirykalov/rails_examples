class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :slug
      t.integer :sort, null: false, default: 0

      t.timestamps
    end
    add_index :properties, :slug, unique: true
    add_index :properties, :name, unique: true
  end
end
