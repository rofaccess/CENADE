class Paciente < ActiveRecord::Base
	paginates_per 20
	acts_as_paranoid

  # Asociaciones
	belongs_to :persona, -> { with_deleted }
	belongs_to :encargado, -> { with_deleted }

	has_one :ficha_fisioterapia_nino, dependent: :restrict_with_error
	has_one :ficha_fonoaudiologica, dependent: :restrict_with_error
	has_one :ficha_psicopedagogica, dependent: :restrict_with_error
	has_one :ficha_fisioterapeutica_adulto, dependent: :restrict_with_error
	has_one :ficha_odontologica, dependent: :restrict_with_error
	has_one :ficha_nutricional_pediatrica, dependent: :restrict_with_error
	has_one :ficha_nutricional_adulto, dependent: :restrict_with_error
	has_one :ficha_clinico, dependent: :restrict_with_error
	has_one :ficha_neurologica, dependent: :restrict_with_error
	has_one :ficha_pediatrica, dependent: :restrict_with_error

	has_many :consultas, dependent: :restrict_with_error
  has_many :consultas_odontologicas, dependent: :restrict_with_error
  has_many :consultas_nutricionales_adultos, dependent: :restrict_with_error
	has_many :consultas_nutricionales_pediatricas, dependent: :restrict_with_error
	has_many :controles, dependent: :restrict_with_error

  has_many :turnos, dependent: :restrict_with_error

	# Permiten guardar persona y encargado en el formulario de paciente
	accepts_nested_attributes_for :persona
	accepts_nested_attributes_for :encargado

  # Validaciones
  validates :lugar_nacimiento, length: { in: 3..Domain::LUGAR_NACIMIENTO }, allow_blank: true
  validates :fecha_ingreso, presence: true, date_less_system_date: true
  validates :profesion, length: {in: 3..Domain::PROFESION}, allow_blank: true
  validates :lugar_trabajo, length: {in: 3..Domain::LUGAR_TRABAJO}, allow_blank: true

  # Callbacks
  after_destroy :destroy_persona, :destroy_encargado

	# Se elimina el registro de persona al eliminar el paciente
	def destroy_persona
      persona.destroy
    end

    # Se elimina el registro de encargado al eliminar el paciente
	def destroy_encargado
    if !encargado.blank?
      # Se setea el campo paciente_id de encargado, para que se sepa a que paciente perteneció
      encargado.update(paciente_id: id)
    	encargado.destroy
    end
  end

	# Law of Demeter
	delegate :full_name, :nombre, :apellido, :ruc, :edad, :sexo, :ci, :nacionalidad,
			 :fecha_nacimiento, :profesion, :telefono, :direccion, :fecha_ingreso,
			 :estado_civil_descripcion, :lugar_nacimiento,:email,:estado_civil_id,
			 to: :persona, prefix: true, allow_nil: true

	delegate :padre_nombre, :padre_edad, :padre_prof_act_ant, :madre_nombre, :madre_edad,
			 :madre_num_hijos, :madre_prof_act_ant, :encargado_nombre, :encargado_edad,
			 :encargado_prof_act_ant, to: :encargado, prefix: true, allow_nil: true
end
