class Turno < ActiveRecord::Base
	paginates_per 3
	belongs_to :paciente
	belongs_to :area
	ransack_alias :turno, :area_nombre_or_fecha_expedicion
	before_create :actualizar_turno
  before_create :actualizar_estado

	def actualizar_turno
      turno = Turno.where("fecha_expedicion = ? and area_id= ? and doctor_id= ?", self.fecha_expedicion, self.area_id, self.doctor_id).order(:turno)
      if turno.empty?
        self.turno = 1
      else
        nro_turno = turno.last.turno
        self.turno = nro_turno+1
      end
    end

  def actualizar_estado
      self.estado = 'pendiente'
    end
	
end
