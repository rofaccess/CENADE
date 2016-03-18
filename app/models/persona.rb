class Persona < ActiveRecord::Base
 	acts_as_paranoid
 	has_one :empleado
 	belongs_to :estado_civil
end