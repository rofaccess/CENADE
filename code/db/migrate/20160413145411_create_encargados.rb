class CreateEncargados < ActiveRecord::Migration
  def change
    create_table :encargados do |t|

    	t.string   :padre_nombre		,default: '' ,limit: Domain::NOM_APE, 		null: true
    	t.string   :padre_edad   		,default: '' ,limit: Domain::EDAD, 			null: true
    	t.string   :padre_prof_act_ant  ,default: '' ,limit: Domain::PROF_ACT_ANT, 	null: true
    	
    	t.string   :madre_nombre 		,default: '' ,limit: Domain::NOM_APE, 		null: true
    	t.string   :madre_edad   		,default: '' ,limit: Domain::EDAD, 			null: true
        t.string   :madre_num_hijos     ,default: '' ,limit: Domain::NUM_HIJOS,     null: true
	    t.string   :madre_prof_act_ant  ,default: '' ,limit: Domain::PROF_ACT_ANT, 	null: true

		t.string   :encargado_nombre 		,default: '' ,limit: Domain::NOM_APE, 		null: true
		t.string   :encargado_edad   		,default: '' ,limit: Domain::EDAD, 			null: true
		t.string   :encargado_prof_act_ant  ,default: '' ,limit: Domain::PROF_ACT_ANT, 	null: true

		t.timestamps null: false

        t.datetime :deleted_at 
    end

    # Se agrega la columna encargado_id a pacientes
    add_foreign_key(:pacientes, :encargados, column: 'encargado_id', on_delete: :restrict)
  end
end
