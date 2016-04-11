class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :nombre, null: false
      t.integer :costo

      t.timestamps null: false
    end
  end
end
