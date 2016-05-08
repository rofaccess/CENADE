class CreateFechas < ActiveRecord::Migration
  def change
    create_table :fechas do |t|
      t.integer :horario_id, null: false
      t.date :fecha, null: false
      t.time :turno_manana_hora_inicio
      t.time :turno_manana_hora_fin
      t.time :turno_tarde_hora_inicio
      t.time :turno_tarde_hora_fin

      t.timestamps null: false
    end
    add_foreign_key(:fechas, :horarios, column: 'horario_id', on_delete: :restrict)

    add_index :fechas, :horario_id
  end
end
