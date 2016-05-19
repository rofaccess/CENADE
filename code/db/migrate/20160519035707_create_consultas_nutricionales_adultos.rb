class CreateConsultasNutricionalesAdultos < ActiveRecord::Migration
  def change
    create_table :consultas_nutricionales_adultos do |t|
      t.belongs_to :ficha_nutricional_adulto    , null: false
      t.integer :doctor_id                      , null: false
      #t.integer :area_id
      t.date   :fecha                           , null: false
      t.string :motivo_consulta                 ,limit: Domain::DESC250,   null: true
      t.string :actuales                        ,limit: Domain::DESC200,   null: true
      t.string :dx                              ,limit: Domain::DESC250,   null: true
      t.string :peso_actual                     ,limit: Domain::DESC10,    null: true
      t.string :peso_ideal                      ,limit: Domain::DESC10,    null: true
      t.string :peso_deseable                   ,limit: Domain::DESC10,    null: true
      t.string :talla                           ,limit: Domain::DESC10,    null: true
      t.string :biotipo                         ,limit: Domain::DESC50,    null: true
      t.string :cir_muneca                      ,limit: Domain::DESC50,    null: true
      t.string :circ_brazo                      ,limit: Domain::DESC50,    null: true
      t.string :circ_cintura                    ,limit: Domain::DESC50,    null: true
      t.string :imc                             ,limit: Domain::DESC50,    null: true
      t.string :evaluacion                      ,limit: Domain::DESC250,   null: true
      t.string :medicamentos                    ,limit: Domain::DESC100,   null: true
      t.string :suplementos                     ,limit: Domain::DESC50,    null: true
      t.string :apetito                         ,limit: Domain::DESC10,    null: true
      t.string :factores_apetito                ,limit: Domain::DESC150,   null: true
      t.string :alergia_intolerancia            ,limit: Domain::DESC100,   null: true
      t.string :cae_cabello                     ,limit: Domain::DESC10,   null: true
      t.string :estado_bucal                    ,limit: Domain::DESC150,   null: true
      t.string :orina_bien                      ,limit: Domain::DESC50,   null: true
      t.string :ir_cuerpo                       ,limit: Domain::DESC10,   null: true
      t.string :actividades_fisicas             ,limit: Domain::DESC10,   null: true
      t.string :tipo                            ,limit: Domain::DESC100,   null: true
      t.string :hs_act_fisicas                  ,limit: Domain::DESC10,   null: true
      t.string :frecuencia                      ,limit: Domain::DESC50,   null: true
      t.string :actividad_laboral               ,limit: Domain::DESC150,   null: true
      t.string :horas_laborales                 ,limit: Domain::DESC50,   null: true
      t.string :vive_con                        ,limit: Domain::DESC50,   null: true
      t.string :quien_prepara                   ,limit: Domain::DESC50,   null: true
      t.string :que_elementos                   ,limit: Domain::DESC100,   null: true
      t.string :toma_agua                       ,limit: Domain::DESC50,   null: true
      t.string :mastica_deglute                 ,limit: Domain::DESC100,   null: true
      t.string :hora_acuesta                    ,limit: Domain::DESC150,   null: true
      t.string :habilidades                     ,limit: Domain::DESC150,   null: true
      t.string :tratamientos_cenade             ,limit: Domain::DESC100,   null: true
      t.string :indicaciones                    ,limit: Domain::DESC250,   null: true

      t.timestamps null: false
    end

    add_index :consultas_nutricionales_adultos, :ficha_nutricional_adulto_id, name: "ficha_id"
    add_index :consultas_nutricionales_adultos, :doctor_id

  end
end
