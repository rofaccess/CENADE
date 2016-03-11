class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
    	t.string   :descripcion ,default: '' ,limit: Domain::CARGO ,null: false
    	t.decimal  :sueldo ,default: 0 

    	t.timestamps
    end
    add_index :cargos, :descripcion, unique: true

  end
end
