class Persona < ActiveRecord::Base
 	acts_as_paranoid
 	has_one :empleado
 	has_one :paciente
 	belongs_to :estado_civil

 	validates :email, length: {maximum: Domain::EMAIL, minimum: 8}
end