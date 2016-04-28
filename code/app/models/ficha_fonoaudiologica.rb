class FichaFonoaudiologica < ActiveRecord::Base
  paginates_per 20
  belongs_to :paciente
  belongs_to :area
  belongs_to :doctor, :foreign_key => :doctor_id


  	def validate_paciente 
		paciente= FichaFonoaudiologica.where("paciente_id = ?", self.paciente_id)
		if !paciente.empty?
			errors.add(:base, "El paciente ya posee una Ficha en Fonoaudiología")
		end
	end
end
