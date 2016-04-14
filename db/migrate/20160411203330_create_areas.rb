class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string  :nombre,default: '' ,limit: Domain::AREA ,null: false
      t.decimal :costo_usual   ,default: 0
      t.decimal :costo_casual  ,default: 0
      t.string :costo          ,default: '',limit: Domain::COSTO, null: true

      t.timestamps null: false
    end

    add_index :areas, :nombre, unique: true

    # Se hacen algunas modificaciones a la tabla empleados
    add_foreign_key(:empleados, :areas, column: 'area_id',on_delete: :restrict)
  end
end
