class FichaNuricionalPediatrica < ActiveRecord::Base

	paginates_per 20
    
    #incremento automatico de nro de ficha
	#protokoll :nro_ficha, pattern: '#'

 	#asociaciones
 	belongs_to :doctor, :foreign_key => :profesional_salud_id
 	belongs_to :paciente
 	belongs_to :area


 	before_create :cargar_area_id


 	def cargar_area_id
		area= Area.where(nombre: 'Nutrición').first.id
		self.area_id= area
	end

	def validate_paciente 
		paciente= FichaNuricionalPediatrica.where("paciente_id = ?", self.paciente_id)
		if !paciente.empty?
			errors.add(:base, "El paciente ya posee una Ficha de Nutrición Pediátrica")
		end
	end

end
