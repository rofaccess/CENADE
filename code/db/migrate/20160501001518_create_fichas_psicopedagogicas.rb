class CreateFichasPsicopedagogicas < ActiveRecord::Migration
  def change
    create_table :fichas_psicopedagogicas do |t|
      t.integer :paciente_id  , null: false
      t.integer :area_id      , null: false
      t.integer :doctor_id    , null: false

      t.string :escolaridad   , default: '' ,   limit: 50,   null: true
      t.string :escuela       , default: '' ,   limit: 100,  null: true
      t.date :fecha           , null: false
      t.integer :nro_ficha

      t.timestamps null: false

    end

    add_foreign_key(:fichas_psicopedagogicas, :areas, column: 'area_id', on_delete: :restrict)
    add_foreign_key(:fichas_psicopedagogicas, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:fichas_psicopedagogicas, :empleados, column: 'doctor_id', on_delete: :restrict)

    add_index :fichas_psicopedagogicas, :paciente_id
    add_index :fichas_psicopedagogicas, :doctor_id
    add_index :fichas_psicopedagogicas, :area_id
  end
end
