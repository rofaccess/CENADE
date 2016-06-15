class CreateConsultas < ActiveRecord::Migration
  def change
    create_table :consultas do |t|

    	t.integer :doctor_id, 		null: true  # La consulta la atiende un profesional
    	#t.integer :turno_id, 		null: true  # //- Normalmente se saca turno para consultar
    	#t.integer :user_id, 		null: false # //- Un usuario del sistema guarda la consulta
    	t.integer :paciente_id,		null: false # La consulta pertenece a un paciente
    	t.integer :area_id,			null: false # La consulta se hace en un área

    	# Datos de la consulta
    	t.date :fecha

    	t.string :motivo_consulta,			default: '' ,limit: Domain::DESC300, null: true
    	t.string :evaluacion,				default: '' ,limit: Domain::DESC300, null: true
    	t.string :tratamiento,				default: '' ,limit: Domain::DESC600, null: true
    	t.string :observaciones,			default: '' ,limit: Domain::DESC250, null: true

    	t.datetime :deleted_at
    end

    # ON DELETE RESTRICT: No se permite borrar un empleado (Profesional de salud) relacionado a alguna consulta
    add_foreign_key(:consultas, :empleados, column: 'doctor_id', on_delete: :restrict)

    # ON DELETE RESTRICT: No se permite borrar un user relacionado a alguna consulta
    # add_foreign_key(:consultas, :users, column: 'user_id', on_delete: :restrict)

    # ON DELETE RESTRICT: No se permite borrar un paciente relacionada a alguna consulta
    add_foreign_key(:consultas, :pacientes, column: 'paciente_id', on_delete: :restrict)

    # ON DELETE RESTRICT: No se permite borrar un área relacionada a alguna consulta
    add_foreign_key(:consultas, :areas, column: 'area_id', on_delete: :restrict)

    add_index :consultas, :paciente_id
    add_index :consultas, :doctor_id
    add_index :consultas, :area_id
  end
end