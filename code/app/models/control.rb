class Control < ActiveRecord::Base
	paginates_per 10

	#asociaciones
 	belongs_to :doctor, :foreign_key => :doctor_id
 	#belongs_to :user
 	belongs_to :paciente
 	belongs_to :area
 	belongs_to :consulta_nutricional_pediatrica

end
