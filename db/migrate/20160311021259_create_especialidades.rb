class CreateEspecialidades < ActiveRecord::Migration
  def change
    create_table :especialidades do |t|
    	t.string :descripcion ,default: '' ,limit: Domain::ESPECIALIDAD ,null: false

    	t.timestamps

    end
    
    add_index :especialidades, :descripcion, unique: true
  end
end
