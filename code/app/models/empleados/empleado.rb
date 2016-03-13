class Empleado < ActiveRecord::Base
 	
 	has_one :user
 	belongs_to :persona
 	accepts_nested_attributes_for :persona

 	has_one :horario
 	belongs_to :cargo

end