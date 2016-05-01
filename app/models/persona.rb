class Persona < ActiveRecord::Base
 	acts_as_paranoid
 	has_one :empleado
 	has_one :paciente
 	belongs_to :estado_civil

 	#validates :email, length: {maximum: Domain::EMAIL, minimum: 8} #El minimo ausa problemas en paciente	 	

 	# Law of Demeter
 	delegate :descripcion, to: :estado_civil, prefix: true, allow_nil: true
end