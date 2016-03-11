class CreateEstadosCiviles < ActiveRecord::Migration
  def change
    create_table :estados_civiles do |t|
    
    t.string :descripcion ,default: '' ,limit: Domain::ESTADO_CIVIL ,null: false

    t.timestamps

    end

    add_index :estados_civiles, :descripcion, unique: true
  end
end
