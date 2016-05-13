class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string   :ci        			  ,default: '' ,limit: Domain::CI,null: false
      t.string   :nombre            ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string   :apellido          ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string   :direccion         ,default: '' ,limit: Domain::DIRECCION
      t.string   :telefono          ,default: '' ,limit: Domain::TELEFONO
      t.string   :email             ,default: '' ,limit: Domain::EMAIL
      t.string   :ruc               ,default: '' ,limit: Domain::RUC
      t.date     :fecha_nacimiento
      t.string   :sexo              ,default: '' ,limit: Domain::SEXO
      t.string   :edad              ,default: '' ,limit: Domain::EDAD
      t.string   :nacionalidad      ,default: '' ,limit: Domain::NACIONALIDAD


      t.integer  :estado_civil_id

      t.datetime :deleted_at

      t.timestamps
    end
    add_index :personas, :deleted_at, unique: true

    # ON DELETE RESTRICT: No te permite borrar el estado civil si esta relacionado con una persona
    add_foreign_key(:personas, :estados_civiles, column: 'estado_civil_id', on_delete: :restrict)

    add_index :personas, :estado_civil_id
  end
end
