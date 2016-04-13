class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :grupo
      t.string :model
      t.string :nombre

      t.timestamps null: false
    end
    end
    
end
