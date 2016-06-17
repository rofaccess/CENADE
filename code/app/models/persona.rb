class Persona < ActiveRecord::Base
 	acts_as_paranoid

  #Asociaciones
  has_one :empleado, -> { with_deleted }
 	has_one :paciente, -> { with_deleted }
 	belongs_to :estado_civil

  #Validaciones
  validates :nombre,  presence: true, length: { in: 3..Domain::NOMBRE }
  validates :apellido, presence: true, length: { in: 3..Domain::NOMBRE }
  validates :ci, presence: true, length: { in: 4..Domain::CI }, uniqueness: true, number_only: true
  validates :ruc, length: {maximum: Domain::RUC}, ruc_only: true, allow_blank: true
  validates :fecha_nacimiento, presence: true, date_less_system_date: true
  validates :edad, length: {maximum: Domain::EDAD}, number_only: true, allow_blank: true
  validates :sexo, presence: true, length: { maximum: Domain::SEXO }
  validates :nacionalidad, length: { maximum: Domain::NACIONALIDAD }
  validates :direccion, length: { maximum: Domain::DIRECCION }
  validates :telefono, length: { maximum: Domain::TELEFONO }, tel_only: true
  validates :email, length: {in: 8..Domain::EMAIL}, allow_blank: true, email: true

  # Retorna el nombre y apellido
	def full_name
  		"#{nombre} #{apellido}"
	end

 	# Law of Demeter
 	delegate :descripcion, to: :estado_civil, prefix: true, allow_nil: true
end