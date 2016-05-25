class FichaFisioterapeuticaAdulto < ActiveRecord::Base
	paginates_per 20

	# Autoincrementa el numero de ficha
	protokoll :nro_ficha, pattern: '#'

	belongs_to :paciente
	belongs_to :doctor, :foreign_key => :doctor_id

	before_create :cargar_area_id

	def cargar_area_id
		area= Area.where(nombre: 'Fisioterapia').first.id
		self.area_id= area
	end

    # //- No se usa todavía
	#def validate_paciente
	#	paciente= FichaFisioterapeuticaAdulto.where("paciente_id = ?", self.paciente_id)
	#	if !paciente.empty?
	#		errors.add(:base, "El paciente ya posee una Ficha de Fisioterapia Adulto")
	#	end
	#end

	# Law of Demeter
	delegate :persona_nombre, :persona_apellido, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion,
			 to: :paciente, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, :full_name, to: :doctor, prefix: true, allow_nil: true
end
