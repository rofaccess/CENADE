class CreateEmpleados < ActiveRecord::Migration
  def change
    create_table :empleados do |t|
    
    t.integer  :persona_id, null: false
    t.integer  :horario_id, null: false
    t.integer  :cargo_id,   null: false
    t.integer  :especialidad_id

	t.string   :type ,default: '' ,limit: Domain::TIPO_EMPLEADO, null: false

    t.timestamps

    end

    add_foreign_key(:empleados, :personas, column: 'persona_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:empleados, :horarios, column: 'horario_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:empleados, :cargos, column: 'cargo_id', options: 'ON DELETE RESTRICT')
    add_foreign_key(:empleados, :especialidades, column: 'especialidad_id', options: 'ON DELETE RESTRICT')


    # Se hacen algunas modificaciones a la tabla users    

    add_foreign_key(:users, :empleados, column: 'empleado_id', options: 'ON DELETE RESTRICT')

    add_column :users, :rol, :string, limit: Domain::ROL

  end  
end
