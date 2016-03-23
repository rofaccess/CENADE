class Configuracion < ActiveRecord::Base
	
  mount_uploader :empresa_logo, EmpresaLogoUploader
  validates :empresa_nombre, presence: true
  validates :empresa_nombre, length: {maximum: Domain::EMPRESA_NOMBRE, minimum: 2}
  validates :empresa_nombre, format: { with: /\A[a-zA-ZñÑáéíóúÁÉÍÓÚ\s\-0-9]+\z/}
  validates :empresa_direccion, presence: true
  validates :empresa_direccion, length: {maximum: Domain::DIRECCION, minimum: 4}
  validates :empresa_tel, length: {maximum: Domain::TELEFONO}
  validates :empresa_horario_atencion, length: {maximum: Domain::EMPRESA_HORARIO}
  validates :empresa_email, length: {maximum: Domain::EMAIL}
  validates :empresa_web, length: {maximum: Domain::EMPRESA_WEB}
end
