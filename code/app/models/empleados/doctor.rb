class Doctor < Empleado

 	belongs_to :especialidad
 	belongs_to :area
 	has_many :turnos
 	has_many :ficha_fisioterapia_ninos # //- Actualizar al formato requerido
 	has_many :fichas_fonoaudiologicas
 	has_many :fichas_psicopedagogicas
 	has_many :fichas_odontologicas
 	has_many :fichas_nutricionales_pediatricas
 	has_many :fichas_nutricionales_adultos
 	has_many :fichas_psicopedagogicas
 	has_many :fichas_clinicos
 	has_many :fichas_neurologicas
 	has_many :fichas_pediatricas

 	has_many :controles
 	has_many :consultas
 	has_many :consultas_nutricionales_pediatricas

 	# Retorna el nombre y apellido del doctor, usado en /doctores/buscar
	def full_name
  		"#{abr_profesion} #{persona_nombre} #{persona_apellido}"
	end

	# Law of Demeter
	delegate :nombre, :costo, to: :area, prefix: true, allow_nil: true
end