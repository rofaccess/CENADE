class CreateFichaFisioterapiaNinos < ActiveRecord::Migration
  def change
    create_table :ficha_fisioterapia_ninos do |t|
      t.integer :area_id               , null: false
      t.integer :doctor_id             , null: false
      t.integer :paciente_id           , null: false
      t.string :control_embarazo       ,default: '' ,limit: 100,   null: true
      t.string :edad_gestacional       ,default: '' ,limit: 100,   null: true
      t.string :tipo_parto             ,default: '' ,limit: 100,   null: true
      t.string :peso_nacer             , default: '' ,limit: 50,   null: true
      t.string :apgar                  , default: '' ,limit: 50,   null: true
      t.string :antecedentes_familiares,default: '' ,limit: 250,   null: true
      t.string :condicion_general      ,default: '' ,limit: 250,   null: true
      t.date :fecha                    , null: false
      t.integer :nro_ficha             
      t.timestamps null: false
    end 

    add_foreign_key(:ficha_fisioterapia_ninos, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:ficha_fisioterapia_ninos, :areas, column: 'area_id', on_delete: :restrict)  

  end
end
