class CreateFichaNuricionalPediatricas < ActiveRecord::Migration
  def change
    create_table :ficha_nuricional_pediatricas do |t|
      t.integer :paciente_id
      t.integer :area_id
      t.integer :profesional_salud_id
      t.date :fecha
      t.string :problema_embarazo
      t.string :control_prenatal
      t.string :alimentacion_embarazo
      t.string :otros_datos
      t.string :parto_vaginal_cesarea
      t.string :termino_pretermino
      t.string :lugar_parto
      t.string :como_fue_parto
      t.string :peso_nacimiento
      t.string :asfixia_lloro
      t.string :tomo_pecho
      t.string :alimentacion_complementaria
      t.string :sosten_cefalico
      t.string :sento
      t.string :paro
      t.string :camino
      t.string :sigue_luz
      t.string :habilidades
      t.string :mastica_deglute
      t.string :otros
      t.string :desayuno
      t.string :media_manana
      t.string :almuerzo
      t.string :merienda
      t.string :cena
      t.string :cargo_quien
      t.string :diarrea
      t.string :vomitos
      t.string :fiebre
      t.string :constipacion
      t.string :orina
      t.string :sudor
      t.string :problemas_respiratorios
      t.string :distension_abdominal
      t.string :otros2
      t.string :diagnostico
      t.integer :peso
      t.string :talla
      t.string :pc
      t.string :imc
      t.string :cm
      t.string :evaluacion
      t.string :indicaciones

      t.timestamps null: false
    end
  end
end
