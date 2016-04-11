class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
      t.integer :persona_id, null: false
      t.date :fecha_ingreso, null: false
      t.boolean :es_menor

      t.timestamps null: false
    end
    add_foreign_key(:pacientes, :personas, column: 'persona_id', on_delete: :restrict)
  end
end
