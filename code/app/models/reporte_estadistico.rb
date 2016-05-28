class ReporteEstadistico < ActiveRecord::Base
	paginates_per 20

	belongs_to :doctor, :foreign_key => :doctor_id
 	belongs_to :area

 	 delegate :nombre, to: :area, prefix: true, allow_nil: true
 	 delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true



 	 def obtener_cantidad
    turnos= Turno.where("area_id = ? and doctor_id = ? and fecha_consulta =  ?", self.area_id, self.doctor_id, self.fecha_consulta).count
    return turnos
  end

end
