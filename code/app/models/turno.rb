class Turno < ActiveRecord::Base
	belongs_to :paciente
	belongs_to :area
	
end
