class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
      	t.integer :persona_id,		null: false
      	t.integer :encargado_id, 	null: true
	    
	    t.date 	  :fecha_ingreso, 	null: false
	   

	    t.boolean :es_menor, 		null: true

	    t.string   :lugar_nacimiento ,default: '' ,limit: Domain::LUGAR_NACIMIENTO, 	null: true
	    t.string   :profesion		 ,default: '' ,limit: Domain::PROFESION, 			null: true
	    t.string   :lugar_trabajo    ,default: '' ,limit: Domain::LUGAR_TRABAJO, 		null: true

      	t.timestamps null: false
    end
    add_foreign_key(:pacientes, :personas, column: 'persona_id', on_delete: :restrict)
    add_foreign_key(:pacientes, :personas, column: 'encargado_id', on_delete: :restrict)
  end
end
