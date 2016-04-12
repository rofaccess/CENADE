class Paciente < ActiveRecord::Base
	has_many :turnos
	belongs_to :persona
end
