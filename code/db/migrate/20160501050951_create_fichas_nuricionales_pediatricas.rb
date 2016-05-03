class CreateFichasNuricionalesPediatricas < ActiveRecord::Migration
  def change
    create_table :fichas_nuricionales_pediatricas do |t|
 
      t.integer :paciente_id              , null: false
      t.integer :area_id                  , null: false
      t.integer :profesional_salud_id     , null: false 
      t.date :fecha                       , null: false
      t.string :problema_embarazo         ,limit: Domain::DESC250,       null: true
      t.string :control_prenatal          ,limit: Domain::DESC250,       null: true
      t.string :alimentacion_embarazo     ,limit: Domain::DESC250,       null: true
      t.string :otros_datos               ,limit: Domain::DESC250,       null: true
      t.string :parto_vaginal_cesarea     ,limit: Domain::DESC50,       null: true
      t.string :termino_pretermino        ,limit: Domain::DESC50,       null: true
      t.string :lugar_parto               ,limit: Domain::DESC100,       null: true
      t.string :como_fue_parto            ,limit: Domain::DESC100,       null: true
      t.string :peso_nacimiento           ,limit: Domain::DESC50,       null: true
      t.string :asfixia_lloro             ,limit: Domain::DESC250,       null: true
      t.string :tomo_pecho                ,limit: Domain::DESC200,       null: true
      t.string :alimentacion_complementaria,limit: Domain::DESC100,       null: true
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
      t.string :cargo_quien               ,limit: Domain::DESC100,       null: true
      t.boolean :diarrea                   
      t.boolean :vomitos
      t.boolean :fiebre
      t.string :constipacion              ,limit: Domain::DESC100,       null: true
      t.string :orina                     ,limit: Domain::DESC100,       null: true
      t.string :sudor                     ,limit: Domain::DESC100,       null: true
      t.boolean :problemas_respiratorios
      t.boolean :distension_abdominal
      t.string :otros2                    ,limit: Domain::DESC250,       null: true
      t.string :diagnostico               ,limit: Domain::DESC250,       null: true
      t.string :peso                      ,limit: Domain::NRO_CHICO,       null: true
      t.string :talla                     ,limit: Domain::NRO_CHICO,       null: true
      t.string :pc                        ,limit: Domain::NRO_CHICO,       null: true
      t.string :imc                       ,limit: Domain::NRO_CHICO,       null: true
      t.string :cm                        ,limit: Domain::NRO_CHICO,       null: true
      t.string :evaluacion                ,limit: Domain::DESC250,       null: true
      t.string :indicaciones              ,limit: Domain::DESC600,       null: true
      t.integer :nro_ficha                 
      t.timestamps null: false
    end
  end
end
