class FichaFisioterapeuticaAdulto < ActiveRecord::Base
	paginates_per 20

	belongs_to :paciente
	belongs_to :doctor, :foreign_key => :doctor_id	

	before_create :actualizar_nro, :cargar_area_id

	def actualizar_nro
      ficha = FichaFisioterapeuticaAdulto.last
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

    #No se usa
	#def validate_paciente 
	#	paciente= FichaFisioterapeuticaAdulto.where("paciente_id = ?", self.paciente_id)
	#	if !paciente.empty?
	#		errors.add(:base, "El paciente ya posee una Ficha de Fisioterapia Adulto")
	#	end
	#end

end
