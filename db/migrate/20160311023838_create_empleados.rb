class CreateEmpleados < ActiveRecord::Migration
  def change
    create_table :empleados do |t|
    
    t.integer  :persona_id, null: false    
   
    t.integer  :area_id

	t.string   :type ,default: '' ,limit: Domain::TIPO_EMPLEADO, null: false
    t.string   :cargo ,default: '' ,limit: Domain::CARGO_EMPLEADO, null: false

    t.string   :abr_profesion ,default: '' ,limit: Domain::ABREVIATURA_PROFESION, null: true  


    t.decimal :costo  ,default: 0

    t.datetime :deleted_at
    t.timestamps

    end
    
    add_index :empleados, :deleted_at,unique: true 
        
    add_foreign_key(:empleados, :personas, column: 'persona_id', on_delete: :restrict)   
    add_foreign_key(:empleados, :areas, column: 'area_id', on_delete: :restrict)

    # Se hacen algunas modificaciones a la tabla users
    add_foreign_key(:users, :empleados, column: 'empleado_id',on_delete: :restrict)
  end  
end
