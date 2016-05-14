class CreateControles < ActiveRecord::Migration
  def change
    create_table :controles do |t|
      t.integer :consulta_nutricional_pediatrica_id
      t.integer :paciente_id
      t.integer :doctor_id
      t.date :fecha
      t.string :tratamiento
      t.string :observaciones

      t.timestamps null: false
    end
  end
end
