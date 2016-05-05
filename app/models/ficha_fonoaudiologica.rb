class FichaFonoaudiologica < ActiveRecord::Base
  paginates_per 2
  #asociaciones
  belongs_to :paciente
  belongs_to :area
  belongs_to :doctor, :foreign_key => :doctor_id


  #cargas automáticas
  before_create :cargar_area_id
  before_create :actualizar_nro

	def actualizar_nro
      ficha = FichaFonoaudiologica.last
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
		area= Area.where(nombre: 'Fonoaudiología').first.id
		self.area_id= area
	end


  	def validate_paciente 
		paciente= FichaFonoaudiologica.where("paciente_id = ?", self.paciente_id)
		if !paciente.empty?
			errors.add(:base, "El paciente ya posee una Ficha en Fonoaudiología")
		end
	end

  ransack_alias :paciente, :paciente_persona_nombre_or_paciente_persona_apellido_or_paciente_persona_ci 

end
