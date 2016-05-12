class CreateFichasNeurologicas < ActiveRecord::Migration
	def change
		create_table :fichas_neurologicas do |t|
			t.integer :paciente_id     , null: false
			t.integer :area_id         , null: false
			t.integer :doctor_id       , null: false

			t.string :p       	 		,default: '' ,limit: Domain::DESC10,   null: true
			t.string :a       	 		,default: '' ,limit: Domain::DESC10,   null: true
			t.string :pc1       		,default: '' ,limit: Domain::DESC10,   null: true
			t.string :pt1       	 	,default: '' ,limit: Domain::DESC10,   null: true
			t.string :pa       	 		,default: '' ,limit: Domain::DESC10,   null: true
			t.string :control       	,default: '' ,limit: Domain::DESC250,   null: true
			t.string :gestacion       	,default: '' ,limit: Domain::DESC100,   null: true
			t.string :paridad       	,default: '' ,limit: Domain::DESC100,   null: true
			t.string :abortos       	,default: '' ,limit: Domain::DESC100,   null: true
			t.string :nacidos_muertos   ,default: '' ,limit: Domain::DESC100,   null: true
			t.string :partos_anteriores ,default: '' ,limit: Domain::DESC100,   null: true
			t.string :gru_san_paciente  ,default: '' ,limit: Domain::DESC10,   null: true
			t.string :rh_paciente       ,default: '' ,limit: Domain::DESC10,   null: true
			t.string :coombs       	 	,default: '' ,limit: Domain::DESC10,   null: true
			t.string :gru_san_padre     ,default: '' ,limit: Domain::DESC10,   null: true
			t.string :rh_padre       	,default: '' ,limit: Domain::DESC10,   null: true
			t.string :fum       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :fp       	 		,default: '' ,limit: Domain::DESC50,   null: true
			t.string :duracion       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :riesgos       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :tipo_parto       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :anestesia       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :analgesia       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :neonatal_cianosis ,default: '' ,limit: Domain::DESC50,   null: true
			t.string :ictericia_antes   ,default: '' ,limit: Domain::DESC50,   null: true
			t.string :ictericia_despues ,default: '' ,limit: Domain::DESC50,   null: true
			t.string :apgar       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :peso1       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :talla1       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :pc2       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :tp       	 		,default: '' ,limit: Domain::DESC50,   null: true
			t.string :fontanela       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :dubowitz       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :parkin       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :gru_san2       	,default: '' ,limit: Domain::DESC10,   null: true
			t.string :rh2       	 	,default: '' ,limit: Domain::DESC10,   null: true
			t.string :medicacion       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :ccu       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :tiempo_internacion,default: '' ,limit: Domain::DESC50,   null: true
			t.string :alta       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :peso2       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :talla2       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :pb       	 		,default: '' ,limit: Domain::DESC50,   null: true
			t.string :pt1       	 	,default: '' ,limit: Domain::DESC50,   null: true

			t.string :alimentacion_natural		,default: '' ,limit: Domain::DESC100,   null: true
			t.string :duracion       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :alimentacion_artificial   ,default: '' ,limit: Domain::DESC100,   null: true

			t.string :bcg       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :antisarampionosa  ,default: '' ,limit: Domain::DESC50,   null: true
			t.string :antigripal       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :mmr       	 	,default: '' ,limit: Domain::DESC50,   null: true

			t.string :dpt       	 	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :dpt1       	 	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :dpt2       	 	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :dpt3       	 	,default: '' ,limit: Domain::DESC20,   null: true

			t.string :dpt_ref1       	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :dpt_ref2       	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :dpt_ref3      	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :dpt_ref4       	,default: '' ,limit: Domain::DESC20,   null: true

			t.string :sabin       	 	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :sabin1       	 	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :sabin2       	 	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :sabin3       	 	,default: '' ,limit: Domain::DESC20,   null: true

			t.string :sabin_ref1       	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :sabin_ref2       	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :sabin_ref3       	,default: '' ,limit: Domain::DESC20,   null: true
			t.string :sabin_ref4       	,default: '' ,limit: Domain::DESC20,   null: true

			t.string :otras       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :app       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :apf       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :edad_mental    	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :dpt2       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :epl       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :dpm       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :tto_ant       	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :epl       	 	,default: '' ,limit: Domain::DESC50,   null: true
			t.string :sosten_cefalico   ,default: '' ,limit: Domain::DESC50,   null: true
			t.string :sedentacion       ,default: '' ,limit: Domain::DESC50,   null: true
			t.string :mancha       	 	,default: '' ,limit: Domain::DESC50,   null: true


			t.date :fecha               , null: false
			t.integer :nro_ficha
			t.timestamps null: false
		end

		add_foreign_key(:fichas_neurologicas, :pacientes, column: 'paciente_id', on_delete: :restrict)
	    add_foreign_key(:fichas_neurologicas, :areas, column: 'area_id', on_delete: :restrict)

	    add_index :fichas_neurologicas, :paciente_id
	    add_index :fichas_neurologicas, :doctor_id
	    add_index :fichas_neurologicas, :area_id
	end
end
