class Consulta < ActiveRecord::Base
 	acts_as_paranoid
 	paginates_per 20

 	#asociaciones
 	belongs_to :doctor, :foreign_key => :profesional_salud_id
 	belongs_to :user
 	belongs_to :paciente,:foreign_key => :paciente_id
 	belongs_to :area

 	#validaciones
 	validates :tratamiento , length: { maximum: Domain::DESC600, message: ' soporta un máximo de 600 caracteres' }
 	validates :evaluacion , length: { maximum: Domain::DESC300, message: ' soporta un máximo de 300 caracteres' }
 	validates :motivo_consulta, length: { maximum: Domain::DESC300, message: ' soporta un máximo de 300 caracteres' }
 	validates :observaciones, length: { maximum: Domain::DESC250, message: ' soporta un máximo de 250 caracteres' }

 	# Law of Demeter
	delegate :persona_nombre, :persona_apellido, :persona_estado_civil_descripcion, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :id,
			 to: :paciente, prefix: true, allow_nil: true


	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

	delegate :nombre, to: :area, prefix: true, allow_nil: true

end