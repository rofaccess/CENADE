class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string  :nombre,default: '' ,limit: Domain::AREA ,null: false
      t.decimal :costo_usual   ,default: 0
      t.decimal :costo_casual  ,default: 0
      t.integer :costo

      t.timestamps null: false
    end

    add_index :areas, :nombre, unique: true
  end
end
