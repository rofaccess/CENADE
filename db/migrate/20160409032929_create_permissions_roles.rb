class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles do |t|
      t.integer :role_id
      t.integer :permission_id

      t.timestamps null: false
    end
    add_foreign_key(:permissions_roles, :roles, column: 'role_id', options: 'ON DELETE CASCADE')
    add_foreign_key(:permissions_roles, :permissions, column: 'permission_id', options: 'ON DELETE CASCADE')
    
  end
end
