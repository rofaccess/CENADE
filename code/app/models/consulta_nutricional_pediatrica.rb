class ConsultaNutricionalPediatrica < ActiveRecord::Base

 	paginates_per 20

	#asociaciones
 	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
 	belongs_to :paciente, -> { with_deleted }
 	belongs_to :area
 	belongs_to :ficha_nutricional_pediatrica, :foreign_key => :ficha_nutri_ped_id
 	has_many :controles

 	#Validaciones
  validates :paciente, presence: true
  validates :doctor, presence: true
  validates :fecha, presence: true, date_less_system_date: true
  validate  :paciente_has_not_ficha

 	#Callbacks
 	#carga id area antes de guardar la consulta
 	#before_create :cargar_area_id

  def paciente_has_not_ficha
    if Consulta.get_ficha(area.nombre + ' Pediatría', paciente.id).nil?
      errors.add(:base, I18n.t('activerecord.errors.messages.paciente_has_not_ficha'))
    end
  end

  #carga el area automaticamente
 	def cargar_area_id
		area= Area.where(nombre: 'Nutrición').first.id
		self.area_id= area
	end


 	# Law of Demeter
	delegate :persona_nombre, :persona_apellido, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :id,
			 to: :paciente, prefix: true, allow_nil: true

	delegate :nombre, to: :area, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true

end
