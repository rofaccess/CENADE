class CreateFichasOdontologicas < ActiveRecord::Migration
  def change
    create_table :fichas_odontologicas do |t|
      t.integer :paciente_id  , null: false
      t.integer :area_id      , null: false
      t.integer :doctor_id    , null: false
      t.integer :nro_ficha

      t.date :fecha
      t.string :motivo_consulta
      t.string :observaciones
      t.string :servicio_cenade
      t.string :medicacion_actual
      t.string :anestesico
      t.string :penicilina
      t.string :otros_medicamentos
      t.string :hemorragias
      t.string :problema_tratamiento
      t.string :enfermedad_cardiovascular
      t.string :diabetes
      t.string :hepatitis
      t.string :enfermedades_renales
      t.string :artritis
      t.string :tuberculosis
      t.string :enfermedades_venereas
      t.string :enfermedades_sanguineas
      t.string :fumador
      t.string :enfermedades_neurologicas
      t.string :menstruacion
      t.string :embarazada
      t.string :tiene_hijos
      t.string :cantidad_hijos
      t.string :amamanta
      t.string :hospitalizado
      t.string :causa_hospitalizado
      t.string :ecg
      t.string :tac
      t.string :rx
      t.string :laboratorios
      t.string :otros_examenes
      t.string :tratamiento

      t.timestamps null: false
    end
    add_foreign_key(:fichas_odontologicas, :areas, column: 'area_id')
    add_foreign_key(:fichas_odontologicas, :pacientes, column: 'paciente_id')
  end
end
