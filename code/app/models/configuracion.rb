class Configuracion < ActiveRecord::Base

  mount_uploader :empresa_logo, EmpresaLogoUploader
  validates :empresa_nombre, presence: true, length: { in: 3..Domain::EMPRESA_NOMBRE },format: { with: /\A[a-zA-ZñÑáéíóúÁÉÍÓÚ\s\-0-9]+\z/}
  validates :empresa_web, length: {maximum: Domain::EMPRESA_WEB}
  validates :empresa_direccion, presence: true, length: {maximum: Domain::DIRECCION}
  validates :empresa_email, length: {maximum: Domain::EMAIL}, email_custom: true, allow_blank: true
  validates :empresa_tel, length: {maximum: Domain::TELEFONO}, tel_only: true

  validates :hora_inicio_mañana,length: {maximum: Domain::EMPRESA_HORARIO}, time: true, allow_blank: true
  validates :hora_fin_mañana,length: {maximum: Domain::EMPRESA_HORARIO}, time: true, allow_blank: true
  validates :hora_inicio_tarde, length: {maximum: Domain::EMPRESA_HORARIO}, time: true, allow_blank: true
  validates :hora_fin_tarde,length: {maximum: Domain::EMPRESA_HORARIO}, time: true, allow_blank: true
  validates :dias_atencion, length: {maximum: Domain::DIAS_DE_ATENCION}
  validates :usuario_admin, presence: true
end
