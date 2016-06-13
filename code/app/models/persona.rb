class Persona < ActiveRecord::Base
 	acts_as_paranoid
 	has_one :empleado, -> { with_deleted }
 	has_one :paciente, -> { with_deleted }
 	belongs_to :estado_civil

 	#validates :email, length: {maximum: Domain::EMAIL, minimum: 8} #El minimo ausa problemas en paciente

 	# Retorna el nombre y apellido
	def full_name
  		"#{nombre} #{apellido}"
	end

 	# Law of Demeter
 	delegate :descripcion, to: :estado_civil, prefix: true, allow_nil: true
end