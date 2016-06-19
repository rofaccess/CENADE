class Control < ActiveRecord::Base
	paginates_per 10

	#asociaciones
 	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
 	belongs_to :paciente, -> { with_deleted }
 	belongs_to :area
 	belongs_to :consulta_nutricional_pediatrica

  #Validaciones
  validates :paciente, presence: true
  validates :doctor, presence: true
  validates :fecha, presence: true, date_less_system_date: true
  validates :tratamiento, length: {maximum: Domain::DESC300}
  validates :observaciones, length: {maximum: Domain::DESC300}

 	delegate :persona_nombre, :persona_apellido, :persona_estado_civil_descripcion, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :id,
			 to: :paciente, prefix: true, allow_nil: true


	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true

	delegate :nombre, to: :area, prefix: true, allow_nil: true
end
