class FichaOdontologica < ActiveRecord::Base

  paginates_per 20

  # Autoincremente el numero de ficha
  protokoll :nro_ficha, pattern: '#'
  
  #asociaciones
  belongs_to :paciente
  belongs_to :doctor, :foreign_key => :doctor_id
  before_create :cargar_area_id


  	def cargar_area_id
		area= Area.where(nombre: 'Odontología').first.id
		self.area_id= area
	end

    ransack_alias :paciente, :paciente_persona_nombre_or_paciente_persona_apellido_or_paciente_persona_ci	
    ransack_alias :doctor,   :doctor_persona_nombre_or_doctor_persona_apellido

  # Law of Demeter 
  delegate :persona_nombre, :persona_apellido, :persona_full_name, 
           :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
           :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :persona_estado_civil_descripcion,
           to: :paciente, prefix: true, allow_nil: true
       
  delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true
end
