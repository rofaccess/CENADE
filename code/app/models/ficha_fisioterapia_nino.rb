class FichaFisioterapiaNino < ActiveRecord::Base
	paginates_per 20

	#incremento automatico de nro de ficha
	protokoll :nro_ficha, pattern: '#'

	#asociaciones
	belongs_to :paciente, -> { with_deleted }
	belongs_to :area
	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id

	#validaciones
	validates :condicion_general , length: { maximum: 500, message: ' soporta un máximo 500 caracteres' }

	#cargas automáticas
	before_create :cargar_area_id


	def cargar_area_id
		area= Area.where(nombre: 'Fisioterapia').first.id
		self.area_id= area
	end

	def validate_paciente
		paciente= FichaFisioterapiaNino.where("paciente_id = ?", self.paciente_id)
		if !paciente.empty?
			errors.add(:base, "El paciente ya posee una Ficha en el Fisioterapia Niño")
		end
	end

	delegate :persona_nombre, :persona_apellido, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion,
			 to: :paciente, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true

	delegate :encargado_padre_nombre, :encargado_padre_edad, :encargado_padre_prof_act_ant,
			 :encargado_madre_nombre, :encargado_madre_edad,
			 :encargado_madre_num_hijos, :encargado_madre_prof_act_ant, :encargado_encargado_nombre,
			 :encargado_encargado_edad, :encargado_encargado_prof_act_ant, to: :paciente, prefix: true, allow_nil: true
end
