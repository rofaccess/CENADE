class Persona < ActiveRecord::Base
 	has_one :empleado
 	belongs_to :estado_civil
end