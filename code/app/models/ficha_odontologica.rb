class FichaOdontologica < ActiveRecord::Base

  paginates_per 20

  # Autoincremente el numero de ficha
  protokoll :nro_ficha, pattern: '#'

  #asociaciones
  belongs_to :paciente
  belongs_to :area
  belongs_to :doctor, :foreign_key => :doctor_id
  has_many :consultas_odontologicas

  before_create :cargar_area_id



  	def cargar_area_id
		area= Area.where(nombre: 'Odontología').first.id
		self.area_id= area
	end


  # Law of Demeter
  delegate :persona_nombre, :persona_apellido, :persona_full_name,
           :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
           :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :persona_estado_civil_descripcion,
           to: :paciente, prefix: true, allow_nil: true

  delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true
end
