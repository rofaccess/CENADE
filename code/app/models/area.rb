class Area < ActiveRecord::Base
	has_many :turnos
	has_many :doctores
	has_many :funcionarios
	has_many :consultas
	has_many :consultas_nutricionales_pediatricas
	has_many :consultas_nutricionales_adultos
	has_many :consultas_odontologicas
	has_many :controles
	has_many :ficha_fisioterapia_ninos
	has_many :fichas_fonoaudiologicas
	has_many :fichas_nutricionales_pediatricas
	has_many :fichas_nutricionales_adultos
	has_many :reportes_estadisticos
end
