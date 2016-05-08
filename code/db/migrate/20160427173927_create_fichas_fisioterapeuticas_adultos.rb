class CreateFichasFisioterapeuticasAdultos < ActiveRecord::Migration
  def change
    create_table :fichas_fisioterapeuticas_adultos do |t|
      t.integer :area_id               , null: false
      t.integer :doctor_id             , null: false
      t.integer :paciente_id           , null: false
     
      t.string :encargado       		,default: '' ,limit: Domain::DESC50,   null: true

      t.string :medicamentos       		,default: '' ,limit: Domain::DESC250,   null: true
      t.string :antecedente_actual 		,default: '' ,limit: Domain::DESC250,   null: true
      t.string :antecedente_hereditario	,default: '' ,limit: Domain::DESC250,   null: true
      t.string :condicion_paciente      ,default: '' ,limit: Domain::DESC250,   null: true
      
      t.date :fecha                    , null: false
      t.integer :nro_ficha             
      t.timestamps null: false

    end

     	add_foreign_key(:fichas_fisioterapeuticas_adultos, :pacientes, column: 'paciente_id', on_delete: :restrict)
    	add_foreign_key(:fichas_fisioterapeuticas_adultos, :areas, column: 'area_id', on_delete: :restrict)  
  
      add_index :fichas_fisioterapeuticas_adultos, :paciente_id
      add_index :fichas_fisioterapeuticas_adultos, :doctor_id
      add_index :fichas_fisioterapeuticas_adultos, :area_id
  end
end
