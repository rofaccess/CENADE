class Consulta < ActiveRecord::Base 	
 	acts_as_paranoid
 	
 	belongs_to :Doctor
 	belongs_to :User
 	belongs_to :Paciente
 	belongs_to :Area
 	 
end