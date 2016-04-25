class Area < ActiveRecord::Base
	has_many :turnos
	has_many :doctores
	has_many :funcionarios
	has_many :consultas
end
