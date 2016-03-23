class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.string :empresa_nombre            , default: "", limit: Domain::EMPRESA_NOMBRE
      t.string :empresa_direccion         , default: "", limit: Domain::DIRECCION
      t.string :empresa_tel               , default: "", limit: Domain::TELEFONO
      t.string :empresa_email             , default: "", limit: Domain::EMAIL
      t.string :empresa_horario_atencion  , default: "", limit: Domain::EMPRESA_HORARIO
      t.string :empresa_web               , default: "", limit: Domain::EMPRESA_WEB
      t.string :empresa_logo 

      t.timestamps null: false
    end
  end
end
