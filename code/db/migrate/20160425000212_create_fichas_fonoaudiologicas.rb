class CreateFichasFonoaudiologicas < ActiveRecord::Migration
  def change
    create_table :fichas_fonoaudiologicas do |t|
      t.references :paciente, index: true
      t.references :area, index: true

      t.string :escolaridad, default: '' ,limit: 150,   null: true
      t.string :escuela, default: '' ,limit: 150,   null: true

      t.timestamps null: false
    end
    add_foreign_key(:fichas_fonoaudiologicas, :pacientes, column: 'paciente_id', on_delete: :restrict)
    add_foreign_key(:fichas_fonoaudiologicas, :areas, column: 'area_id', on_delete: :restrict)
  end
end
