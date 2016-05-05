class FichaFisioterapiaNino < ActiveRecord::Base
	paginates_per 20

	#asociaciones
	belongs_to :paciente
	belongs_to :area
	belongs_to :doctor, :foreign_key => :doctor_id

	#validaciones
	validates :condicion_general , length: { maximum: 700, message: ' soporta un máximo 700 caracteres' }

	#cargas automáticas
	before_create :cargar_area_id
	before_create :actualizar_nro



	def actualizar_nro
      ficha = FichaFisioterapiaNino.last
      if ficha.nil? 
        self.nro_ficha = 1
      elsif  ficha.nro_ficha.nil?
      	self.nro_ficha = 1
      else
        ficha_nro = ficha.nro_ficha
        self.nro_ficha = ficha_nro+1
      end
    end

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

	ransack_alias :paciente, :paciente_persona_nombre_or_paciente_persona_apellido_or_paciente_persona_ci	

	delegate :persona_nombre, :persona_apellido, :persona_full_name, 
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion,
			 :fecha_ingreso, 
			 to: :paciente, prefix: true, allow_nil: true
end
