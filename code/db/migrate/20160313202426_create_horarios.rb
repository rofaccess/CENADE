class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
    	t.integer  :empleado_id, null: false
    	t.timestamps
    end

    # ON DELETE CASCADE: Si se borra el empleado, se borra el horario
    add_foreign_key(:horarios, :empleados, column: 'empleado_id', on_delete: :cascade)

  	add_index :horarios, :empleado_id
  end
end
