class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :grupo_id
      t.string :model
      t.string :nombre

      t.timestamps null: false
    end
    add_foreign_key(:permissions, :grupos, column: 'grupo_id',on_delete: :restrict)

  	add_index :permissions, :grupo_id
  end

end
