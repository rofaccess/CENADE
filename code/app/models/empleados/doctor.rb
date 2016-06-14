class Doctor < Empleado

 	belongs_to :area

 	has_many :ficha_fisioterapia_ninos, dependent: :restrict_with_error
 	has_many :fichas_fonoaudiologicas, dependent: :restrict_with_error
 	has_many :fichas_psicopedagogicas, dependent: :restrict_with_error
 	has_many :fichas_odontologicas, dependent: :restrict_with_error
 	has_many :fichas_nutricionales_pediatricas, dependent: :restrict_with_error
 	has_many :fichas_nutricionales_adultos, dependent: :restrict_with_error
 	has_many :fichas_psicopedagogicas, dependent: :restrict_with_error
 	has_many :fichas_clinicos, dependent: :restrict_with_error
 	has_many :fichas_neurologicas, dependent: :restrict_with_error
 	has_many :fichas_pediatricas, dependent: :restrict_with_error

 	has_many :controles, dependent: :restrict_with_error
 	has_many :consultas, dependent: :restrict_with_error
 	has_many :consultas_nutricionales_pediatricas, dependent: :restrict_with_error

  has_many :turnos, dependent: :restrict_with_error

 	has_many :reportes_estadisticos, dependent: :restrict_with_error

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