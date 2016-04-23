class Consulta < ActiveRecord::Base
 	pagintes_per 20
 	acts_as_paranoid
 	
 	belongs_to :Doctor
 	belongs_to :User
 	belongs_to :Paciente
 	belongs_to :Area
 	 
end