class Doctor < Empleado
 	 	
 	belongs_to :especialidad
 	belongs_to :area
 	has_many :turnos
 	has_many :ficha_fisioterapia_ninos
 	has_many :fichas_fonoaudiologicas
 	has_many :fichas_psicopedagogicas	

 	has_many :consultas

 	# Retorna el nombre y apellido del doctor, usado en /doctores/buscar
	def full_name
  		"#{persona_nombre} #{persona_apellido}"
	end

	# Law of Demeter 
	delegate :nombre, :costo, to: :area, prefix: true, allow_nil: true

	ransack_alias :doctor, :persona_nombre_or_persona_apellido_or_area_nombre
end