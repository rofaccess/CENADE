class CreateFichaNuricionalPediatricas < ActiveRecord::Migration
  def change
    create_table :ficha_nuricional_pediatricas do |t|
      t.integer :paciente_id
      t.integer :area_id
      t.integer :profesional_salud_id
      t.integer :nro_ficha
      t.date :fecha
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

      t.timestamps null: false
    end
  end
end
