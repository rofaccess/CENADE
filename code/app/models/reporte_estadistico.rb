class ReporteEstadistico < ActiveRecord::Base
	paginates_per 20

	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
 	belongs_to :area

 	 delegate :nombre, to: :area, prefix: true, allow_nil: true
 	 delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true


end
