class FichaFisioterapeuticaAdulto < ActiveRecord::Base
	paginates_per 20

	# Autoincremente el numero de ficha
	protokoll :nro_ficha, pattern: '#'
	
	belongs_to :paciente
	belongs_to :doctor, :foreign_key => :doctor_id	

	before_create :cargar_area_id

	def cargar_area_id
		area= Area.where(nombre: 'Fisioterapia').first.id
		self.area_id= area
	end

	# Estos alias fallan despues de guardar una ficha por eso dejo de usarse en el index
	ransack_alias :paciente, :paciente_persona_nombre_or_paciente_persona_apellido_or_paciente_persona_ci	
	ransack_alias :doctor,   :doctor_persona_nombre_or_doctor_persona_apellido
    #No se usa
	#def validate_paciente 
	#	paciente= FichaFisioterapeuticaAdulto.where("paciente_id = ?", self.paciente_id)
	#	if !paciente.empty?
	#		errors.add(:base, "El paciente ya posee una Ficha de Fisioterapia Adulto")
	#	end
	#end

end
