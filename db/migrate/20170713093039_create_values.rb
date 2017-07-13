class CreateValues < ActiveRecord::Migration[5.1]
  def change
    create_table :values do |t|
      t.string :name
      t.string :slug
      t.integer :sort, null: false, default: 0
      t.attachment :icon
      t.references :property

      t.timestamps
    end
    add_index :values, :slug, unique: true
  end
end
