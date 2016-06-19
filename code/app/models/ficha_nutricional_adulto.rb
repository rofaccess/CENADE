class FichaNutricionalAdulto < ActiveRecord::Base
	paginates_per 20
  #incremento automatico de nro de ficha
	protokoll :nro_ficha, pattern: '#'

 	#asociaciones
 	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
 	belongs_to :paciente, -> { with_deleted }
 	belongs_to :area
 	has_many :consultas_nutricionales_adultos

 	#Validaciones
  validates :paciente, presence: true
  validates :doctor, presence: true
  validates :fecha, presence: true, date_less_system_date: true
  validate  :paciente_has_ficha

 	#Callbacks
 	before_create :cargar_area_id

	def paciente_has_ficha
		if paciente.ficha_nutricional_adulto.present? && id.nil?
			errors.add(:base, I18n.t('activerecord.errors.messages.paciente_has_ficha'))
		end
	end

 	def cargar_area_id
		area= Area.where(nombre: 'Nutrición').first.id
		self.area_id= area
	end

	# Law of Demeter
	delegate :persona_nombre, :persona_apellido, :persona_estado_civil_descripcion, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion,
			 to: :paciente, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true

end
