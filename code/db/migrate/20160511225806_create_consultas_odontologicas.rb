class CreateConsultasOdontologicas < ActiveRecord::Migration
  def change
    create_table :consultas_odontologicas do |t|
      t.integer :paciente_id                    ,null:false
      t.integer :area_id                        ,null:false
      t.integer :doctor_id                      ,null:false
      t.date    :fecha                          ,null:false

      t.string :motivo_consulta                ,limit: Domain::DESC250,  null: true
      t.string :observaciones                  ,limit: Domain::DESC250,  null: true
      t.string :servicio_cenade                ,limit: Domain::DESC250,  null: true
      t.string :medicacion_actual              ,limit: Domain::DESC250,  null: true
      t.string :anestesico                     ,limit: Domain::DESC50,   null: true
      t.string :penicilina                     ,limit: Domain::DESC50,   null: true
      t.string :otros_medicamentos             ,limit: Domain::DESC50,   null: true
      t.string :hemorragias                    ,limit: Domain::DESC250,  null: true
      t.string :problema_tratamiento           ,limit: Domain::DESC250,  null: true
      t.string :enfermedad_cardiovascular      ,limit: Domain::DESC250,  null: true
      t.string :diabetes                       ,limit: Domain::DESC50,   null: true
      t.string :hepatitis                      ,limit: Domain::DESC50,   null: true
      t.string :enfermedades_renales           ,limit: Domain::DESC50,   null: true
      t.string :artritis                       ,limit: Domain::DESC50,   null: true
      t.string :tuberculosis                   ,limit: Domain::DESC50,   null: true
      t.string :enfermedades_venereas          ,limit: Domain::DESC50,   null: true
      t.string :enfermedades_sanguineas        ,limit: Domain::DESC50,   null: true
      t.string :fumador                        ,limit: Domain::DESC50,   null: true
      t.string :enfemedades_neurologicas       ,limit: Domain::DESC50,   null: true
      t.string :menstruacion                   ,limit: Domain::DESC50,   null: true
      t.string :embarazada                     ,limit: Domain::DESC50,   null: true
      t.string :tiene_hijos                    ,limit: Domain::DESC50,   null: true
      t.string :cantidad_hijos                 ,limit: Domain::NUM_HIJOS,null: true
      t.string :amamanta                       ,limit: Domain::DESC50,   null: true
      t.string :hospitalizado                  ,limit: Domain::DESC50,   null: true
      t.string :causa_hospitalizado            ,limit: Domain::DESC50,   null: true
      t.string :ecg                            ,limit: Domain::DESC50,   null: true
      t.string :tac                            ,limit: Domain::DESC50,   null: true
      t.string :rx                             ,limit: Domain::DESC50,   null: true
      t.string :laboratorios                   ,limit: Domain::DESC50,   null: true
      t.string :otros_examenes                 ,limit: Domain::DESC50,   null: true
      t.string :tratamiento                    ,limit: Domain::DESC250,  null: true

      t.timestamps null: false
    end
      add_foreign_key(:consultas_odontologicas, :pacientes, column: 'paciente_id', on_delete: :restrict)
      add_foreign_key(:consultas_odontologicas, :areas, column: 'area_id', on_delete: :restrict)

    add_index :consultas_odontologicas, :paciente_id
    add_index :consultas_odontologicas, :doctor_id
    add_index :consultas_odontologicas, :area_id
  end
end
