class CreateConsultas < ActiveRecord::Migration
  def change
    create_table :consultas do |t|

    	t.integer :profesional_salud_id, 				null: true  # La consulta la atiende un profesional
    	#t.integer :turno_id, 							null: true  # Normalmente se saca turno para consultar
    	#t.integer :user_id, 							null: false # Un usuario del sistema guarda la consulta
    	t.integer :paciente_id,							null: false # La consulta pertenece a un paciente
    	t.integer :area_id,								null: false # La consulta se hace en un área

    	# Datos de la consulta
    	t.date :fecha
    	t.string :profesional_salud,		default: '' ,limit: Domain::NOM_APE, null: true # Nombre y Apellido del Profesional por si las dudas

    	t.string :motivo_consulta,			default: '' ,limit: Domain::DESC250, null: true
    	t.string :evaluacion,				default: '' ,limit: Domain::DESC250, null: true
    	t.string :tratamiento,				default: '' ,limit: Domain::DESC250, null: true
    	t.string :observaciones,			default: '' ,limit: Domain::DESC250, null: true

    	t.datetime :deleted_at 
    end

    # ON DELETE RESTRICT: No se permite borrar un empleado (Profesional de salud) relacionado a alguna consulta
    add_foreign_key(:consultas, :empleados, column: 'profesional_salud_id', on_delete: :restrict)

    # ON DELETE RESTRICT: No se permite borrar un user relacionado a alguna consulta
    # add_foreign_key(:consultas, :users, column: 'user_id', on_delete: :restrict)

    # ON DELETE CASCADE: Si se borra un paciente se borran todas sus consultas
    add_foreign_key(:consultas, :pacientes, column: 'paciente_id', on_delete: :cascade)

    # ON DELETE RESTRICT: No se permite borrar un área relacionada a alguna consulta
    add_foreign_key(:consultas, :areas, column: 'area_id', on_delete: :restrict)
  end
end