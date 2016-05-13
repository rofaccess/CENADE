class CreateTurnos < ActiveRecord::Migration
  def change
    create_table :turnos do |t|
      t.integer :paciente_id, null: false
      t.date :fecha_expedicion, null: false
      t.date :fecha_consulta, null: false
      t.integer :area_id, null: false
      t.integer :doctor_id, null: false
      t.string :estado, null: false
      t.integer :monto
      t.boolean :paga, null: false
      t.string :nro_factura
      t.integer :turno

      t.timestamps null: false
    end
    add_foreign_key(:turnos, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:turnos, :areas, column: 'area_id', on_delete: :restrict)
    add_foreign_key(:turnos, :empleados, column: 'doctor_id', on_delete: :restrict)

    add_index :turnos, :paciente_id
    add_index :turnos, :area_id
    add_index :turnos, :doctor_id
  end
end