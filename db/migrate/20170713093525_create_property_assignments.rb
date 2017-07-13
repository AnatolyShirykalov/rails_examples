class CreatePropertyAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :property_assignments do |t|
      t.references :valueable, polymorphic: true
      t.references :value, foreign_key: true

      t.timestamps
    end
  end
end
