class CreateConfiguraciones < ActiveRecord::Migration
  def change
    create_table :configuraciones do |t|
      t.string :empresa_nombre            , default: "", limit: Domain::EMPRESA_NOMBRE
      t.string :empresa_direccion         , default: "", limit: Domain::DIRECCION
      t.string :empresa_tel               , default: "", limit: Domain::TELEFONO
      t.string :empresa_email             , default: "", limit: Domain::EMAIL
      t.string :empresa_web               , default: "", limit: Domain::EMPRESA_WEB
      t.string :empresa_logo
      t.string :hora_inicio_mañana
      t.string :hora_fin_mañana
      t.string :hora_inicio_tarde
      t.string :hora_fin_tarde
      t.string :dias_atencion
      t.string :usuario_admin

      t.timestamps
    end
  end
end
