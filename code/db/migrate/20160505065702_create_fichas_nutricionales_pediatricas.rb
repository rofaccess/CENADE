class CreateFichasNutricionalesPediatricas < ActiveRecord::Migration
  def change
    create_table :fichas_nutricionales_pediatricas do |t|
      t.integer :paciente_id              , null: false
      t.integer :area_id                  , null: false
      t.integer :doctor_id     , null: false
      t.integer :nro_ficha
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

      t.timestamps null: false
    end
    add_foreign_key(:fichas_nutricionales_pediatricas, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:fichas_nutricionales_pediatricas, :areas, column: 'area_id', on_delete: :restrict)
     add_foreign_key(:fichas_nutricionales_pediatricas, :empleados, column: 'doctor_id', on_delete: :restrict)

    add_index :fichas_nutricionales_pediatricas, :paciente_id
    add_index :fichas_nutricionales_pediatricas, :doctor_id
    add_index :fichas_nutricionales_pediatricas, :area_id
  end
end

