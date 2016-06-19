class CreateEmpleados < ActiveRecord::Migration
  def change
    create_table :empleados do |t|

    t.integer  :persona_id, null: false

    t.integer  :area_id

	t.string   :type ,default: '' ,limit: Domain::TIPO_EMPLEADO, null: false
    t.string   :cargo ,default: '' ,limit: Domain::CARGO_EMPLEADO

    t.string   :abr_profesion ,default: '' ,limit: Domain::ABREVIATURA_PROFESION


    #t.string   :costo ,default: '' ,limit: Domain::COSTO, null: true

    t.datetime :deleted_at
    t.timestamps

    end

    add_index :empleados, :deleted_at,unique: true

    add_foreign_key(:empleados, :personas, column: 'persona_id', on_delete: :restrict)

    # Se hacen algunas modificaciones a la tabla users
    add_foreign_key(:users, :empleados, column: 'empleado_id',on_delete: :restrict)

    add_index :empleados, :persona_id
    add_index :empleados, :area_id
  end
end
