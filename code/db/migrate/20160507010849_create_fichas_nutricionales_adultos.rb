class CreateFichasNutricionalesAdultos < ActiveRecord::Migration
  def change
    create_table :fichas_nutricionales_adultos do |t|
      t.integer :paciente_id      , null: false
      t.integer :area_id          , null: false
      t.integer :doctor_id        , null: false
      t.date :fecha               , null: false
      t.integer :nro_ficha
      t.integer :nro_hijos        ,limit: Domain::NUM_HIJOS,       null: true
      t.string :obesidad          ,limit: Domain::DESC50,       null: true
      t.string :dbt               ,limit: Domain::DESC50,       null: true
      t.string :hta               ,limit: Domain::DESC50,       null: true
      t.string :cardiopatias      ,limit: Domain::DESC50,       null: true
      t.string :actuales          ,limit: Domain::DESC200,       null: true

      t.timestamps null: false
    end
    add_foreign_key(:fichas_nutricionales_adultos, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:fichas_nutricionales_adultos, :areas, column: 'area_id', on_delete: :restrict)
     add_foreign_key(:fichas_nutricionales_adultos, :empleados, column: 'doctor_id', on_delete: :restrict)

    add_index :fichas_nutricionales_adultos, :paciente_id
    add_index :fichas_nutricionales_adultos, :doctor_id
    add_index :fichas_nutricionales_adultos, :area_id

  end
end
