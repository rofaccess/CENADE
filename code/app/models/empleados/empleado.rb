class Empleado < ActiveRecord::Base
 	
 	has_one :user
 	belongs_to :persona
 	belongs_to :horario
 	belongs_to :cargo

end