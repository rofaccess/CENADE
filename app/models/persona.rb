class Persona < ActiveRecord::Base
 	acts_as_paranoid
 	has_one :empleado
 	has_one :paciente
 	belongs_to :estado_civil
end