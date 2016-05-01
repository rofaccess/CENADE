class CreateFichasFonoaudiologicas < ActiveRecord::Migration
  def change
    create_table :fichas_fonoaudiologicas do |t|
      t.integer :paciente_id  , null: false
      t.integer :area_id      , null: false
      t.integer :doctor_id    , null: false

      t.string :escolaridad   , default: '' ,   limit: 50,   null: true
      t.string :escuela       , default: '' ,   limit: 100,  null: true
      t.date :fecha           , null: false
      t.integer :nro_ficha

      t.timestamps null: false
    end
    add_foreign_key(:fichas_fonoaudiologicas, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:fichas_fonoaudiologicas, :areas, column: 'area_id', on_delete: :restrict)
  end
end
