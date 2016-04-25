class FichaFisioterapiaNino < ActiveRecord::Base
	paginates_per 20
	belongs_to :paciente
	belongs_to :doctor, :foreign_key => :doctor_id
	before_create :cargar_area_id


	def cargar_area_id
		area= Area.where(nombre: 'Fisioterapia').first.id
		self.area_id= area
	end



end
