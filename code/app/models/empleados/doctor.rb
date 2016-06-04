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

 	has_many :reportes_estadisticos

 	# Retorna el titulo, nombre y apellido del doctor
	def full_name
  		"#{abr_profesion} #{persona_nombre} #{persona_apellido}"
	end

   def name
      "#{persona_nombre}"
   end

   # Retorna los doctores con el área especificada
   def self.get_all_area(area_nombre)
      area = Area.find_by_nombre(area_nombre)
      self.where(area_id: area.id)
   end

	# Law of Demeter
	delegate :nombre, :costo, to: :area, prefix: true, allow_nil: true
end