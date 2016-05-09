class FichaFonoaudiologica < ActiveRecord::Base
  paginates_per 20
  #asociaciones
  belongs_to :paciente
  belongs_to :area
  belongs_to :doctor, :foreign_key => :doctor_id

  # Autoincremente el numero de ficha
  protokoll :nro_ficha, pattern: '#'

  before_create :cargar_area_id

	def cargar_area_id
		area= Area.where(nombre: 'Fonoaudiología').first.id
		self.area_id= area
	end

  # Law of Demeter
  delegate :persona_nombre, :persona_apellido, :persona_full_name,
           :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
           :persona_fecha_nacimiento,:persona_telefono, :persona_direccion,
           to: :paciente, prefix: true, allow_nil: true

  delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

end
