class ConsultaNutricionalPediatrica < ActiveRecord::Base

 	paginates_per 20

	#asociaciones
 	belongs_to :doctor, :foreign_key => :profesional_salud_id
 	belongs_to :user
 	belongs_to :paciente
 	belongs_to :area
 	belongs_to :ficha_nutricional_pediatrica


 	# Law of Demeter
	delegate :persona_nombre, :persona_apellido, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :id,
			 to: :paciente, prefix: true, allow_nil: true

	delegate :nombre, to: :area, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

end
