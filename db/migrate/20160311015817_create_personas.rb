class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string   :ci        			  ,default: '' ,limit: Domain::CI,null: false
      t.string   :nombre                  ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string   :apellido                ,default: '' ,limit: Domain::NOMBRE ,null: false
      t.string   :direccion               ,default: '' ,limit: Domain::DIRECCION
      t.string   :telefono                ,default: '' ,limit: Domain::TELEFONO
      t.string   :email                   ,default: '' ,limit: Domain::EMAIL
      t.string   :ruc                     ,default: '' ,limit: Domain::RUC
      t.datetime :fecha_nacimiento
      t.string   :sexo                    ,default: '' ,limit: Domain::SEXO      
      t.string   :edad                    ,default: '' ,limit: Domain::EDAD
            
      t.integer  :estado_civil_id     

      t.timestamps
    end

    add_index :personas, :email, unique: true
    add_foreign_key(:personas, :estados_civiles, column: 'estado_civil_id', options: 'ON DELETE RESTRICT')

  end
end
