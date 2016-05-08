class FichaNutricionalAdulto < ActiveRecord::Base
	paginates_per 20
    
    #incremento automatico de nro de ficha
	protokoll :nro_ficha, pattern: '#'

 	#asociaciones
 	belongs_to :doctor, :foreign_key => :doctor_id
 	belongs_to :paciente
 	belongs_to :area


 	before_create :cargar_area_id


 	def cargar_area_id
		area= Area.where(nombre: 'Nutrición').first.id
		self.area_id= area
	end

	def validate_paciente 
		paciente= FichaNutricionalAdulto.where("paciente_id = ?", self.paciente_id)
		if !paciente.empty?
			errors.add(:base, "El paciente ya posee una Ficha de Nutrición Adulto")
		end
	end

	# Law of Demeter 
	delegate :persona_nombre, :persona_apellido, :persona_estado_civil_descripcion, :persona_full_name, 
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, 
			 to: :paciente, prefix: true, allow_nil: true

			 
	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

end
