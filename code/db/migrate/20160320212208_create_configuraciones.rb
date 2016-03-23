class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.string :empresa_nombre
      t.string :empresa_direccion
      t.string :empresa_tel
      t.string :empresa_email
      t.string :empresa_horario_atencion
      t.string :empresa_web
      t.string :empresa_logo

      t.timestamps null: false
    end
  end
end
