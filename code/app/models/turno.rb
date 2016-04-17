class Turno < ActiveRecord::Base
	paginates_per 10
	belongs_to :paciente
	belongs_to :area
	ransack_alias :turno, :area_nombre_or_fecha_expedicion
  validate :paciente_unico_area_fecha_consulta
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

   def paciente_unico_area_fecha_consulta

      turno= Turno.find_by(paciente_id: self.paciente_id, fecha_consulta: self.fecha_consulta, area_id: self.area_id)
      if !turno.nil?
        errors.add(:paciente_id, "El paciente ya posee un turno para el área y la fecha")
      end
    end
	
end
