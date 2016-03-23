class Configuracion < ActiveRecord::Base
	
  mount_uploader :empresa_logo, EmpresaLogoUploader
  validates :empresa_nombre, presence: true
  validates :empresa_nombre, length: {maximum: 50, minimum: 2}
  validates :empresa_nombre, format: { with: /\A[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+\z/}
  validates :empresa_direccion, presence: true
  validates :empresa_direccion, length: {maximum: 100, minimum: 4}
  validates :empresa_tel, length: {maximum: 20}
  validates :empresa_horario_atencion, length: {maximum: 100}
  validates :empresa_email, length: {maximum: 30}
  validates :empresa_web, length: {maximum: 40}
end
