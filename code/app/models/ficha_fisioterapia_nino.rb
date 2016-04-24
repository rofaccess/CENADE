class FichaFisioterapiaNino < ActiveRecord::Base
	paginates_per 20
	belongs_to :paciente
	belongs_to :doctor, :foreign_key => :doctor_id
end
