class CreateControles < ActiveRecord::Migration
  def change
    create_table :controles do |t|
      t.integer :consulta_nutricional_pediatrica_id ,   null: true
      t.integer :doctor_id                          ,   null: false
      t.integer :area_id                            ,   null: false
      t.integer :paciente_id                        ,   null: false
      t.date :fecha                                 ,   null: false
      t.string :tratamiento                         ,default: '' ,limit: Domain::DESC300,   null: true
      t.string :observaciones                       ,default: '' ,limit: Domain::DESC300,   null: true

      t.timestamps null: false
    end
    add_foreign_key(:controles, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:controles, :areas, column: 'area_id', on_delete: :restrict)
    add_foreign_key(:controles, :empleados, column: 'doctor_id', on_delete: :restrict)
    add_foreign_key(:controles, :consultas_nutricionales_pediatricas, column: 'consulta_nutricional_pediatrica_id', on_delete: :restrict)

    add_index :controles, :paciente_id
    add_index :controles, :area_id
    add_index :controles, :doctor_id
  end
end
