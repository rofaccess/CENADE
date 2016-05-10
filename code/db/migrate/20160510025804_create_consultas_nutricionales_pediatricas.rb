class CreateConsultasNutricionalesPediatricas < ActiveRecord::Migration
  def change
    create_table :consultas_nutricionales_pediatricas do |t|
      t.integer :paciente_id              , null: false
      t.integer :area_id                  , null: false
      t.integer :doctor_id                , null: false
      t.date :fecha                       , null: false
      t.string :sosten_cefalico           ,limit: Domain::DESC100,       null: true
      t.string :sento                     ,limit: Domain::TIEMPO,       null: true
      t.string :paro                      ,limit: Domain::TIEMPO,       null: true
      t.string :camino                    ,limit: Domain::TIEMPO,       null: true
      t.string :sigue_luz                 ,limit: Domain::DESC50,       null: true
      t.string :busca_sonido              ,limit: Domain::DESC50,       null: true
      t.string :rie_llora                 ,limit: Domain::DESC50,       null: true
      t.string :emite_sonido              ,limit: Domain::DESC50,       null: true
      t.string :habilidades               ,limit: Domain::DESC200,       null: true
      t.string :mastica_deglute           ,limit: Domain::DESC100,       null: true
      t.string :otros                     ,limit: Domain::DESC250,       null: true
      t.string :desayuno                  ,limit: Domain::DESC250,       null: true
      t.string :media_manana              ,limit: Domain::DESC250,       null: true
      t.string :almuerzo                  ,limit: Domain::DESC250,       null: true
      t.string :merienda                  ,limit: Domain::DESC250,       null: true
      t.string :cena                      ,limit: Domain::DESC250,       null: true
      t.string :encargado                 ,limit: Domain::DESC100,       null: true
      t.string :diarrea                   ,limit: Domain::DESC50,       null: true
      t.string :vomitos                   ,limit: Domain::DESC50,       null: true
      t.string :fiebre                    ,limit: Domain::DESC50,       null: true
      t.string :constipacion              ,limit: Domain::DESC100,       null: true
      t.string :orina                     ,limit: Domain::DESC100,       null: true
      t.string :sudor                     ,limit: Domain::DESC100,       null: true
      t.string :problemas_respiratorios   ,limit: Domain::DESC100,       null: true
      t.string :distension_abdominal      ,limit: Domain::DESC100,       null: true
      t.string :otros2                    ,limit: Domain::DESC200,       null: true
      t.string :diagnostico               ,limit: Domain::DESC250,       null: true
      t.string :peso                      ,limit: Domain::NRO_CHICO,       null: true
      t.string :talla                     ,limit: Domain::NRO_CHICO,       null: true
      t.string :pc                        ,limit: Domain::NRO_CHICO,       null: true
      t.string :imc                       ,limit: Domain::NRO_CHICO,       null: true
      t.string :cm                        ,limit: Domain::NRO_CHICO,       null: true

      t.timestamps null: false
    end
    add_foreign_key(:consultas_nutricionales_pediatricas, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:consultas_nutricionales_pediatricas, :areas, column: 'area_id', on_delete: :restrict)
  end
end
