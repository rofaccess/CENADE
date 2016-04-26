class FichaFisioterapiaNino < ActiveRecord::Base
	paginates_per 20
	validates :condicion_general , length: { maximum: 20, message: 'Máximo 700 caracteres' }
	belongs_to :paciente
	belongs_to :doctor, :foreign_key => :doctor_id
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

end
