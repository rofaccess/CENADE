class Control < ActiveRecord::Base
	paginates_per 10

	#asociaciones
 	belongs_to :doctor, :foreign_key => :doctor_id
 	#belongs_to :user
 	belongs_to :paciente
 	belongs_to :area
 	belongs_to :consulta_nutricional_pediatrica


 	delegate :persona_nombre, :persona_apellido, :persona_estado_civil_descripcion, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :id,
			 to: :paciente, prefix: true, allow_nil: true


	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

	delegate :nombre, to: :area, prefix: true, allow_nil: true
end
