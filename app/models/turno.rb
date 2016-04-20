class Turno < ActiveRecord::Base
	paginates_per 10
	belongs_to :paciente
	belongs_to :area
	validate :coincidencia_area
  validate :verificar_fecha_consulta
  validate :paciente_unico_area_fecha_consulta
	
  before_create :actualizar_estado
  before_create :actualizar_turno

	def actualizar_turno
      turnoo = Turno.where("fecha_consulta = ? and area_id= ? and doctor_id= ?", self.fecha_consulta, self.area_id, self.doctor_id).order(:turno)
      if turnoo.empty?
        self.turno = 1
      else
        nro_turno = turnoo.last.turno
        self.turno = nro_turno+1
      end
    end

  def actualizar_estado
      self.estado = 'pendiente'
    end
  def verificar_fecha_consulta
      if (self.fecha_consulta<self.fecha_expedicion)

        errors.add(:base, "Fecha de consulta no válida ")
    end

   end

  def coincidencia_area
      if !(self.area_id == Empleado.where("id = ?", self.doctor_id).first.area_id)
        errors.add(:base, "El Doctor no atiende en el Área de #{self.area.nombre}")
      end
    end
 
   def paciente_unico_area_fecha_consulta

      turno= Turno.find_by(paciente_id: self.paciente_id, fecha_consulta: self.fecha_consulta, area_id: self.area_id)
      if !turno.nil?
        errors.add(:base, "El paciente ya posee un turno para el área y la fecha")
      end
    end
	
end
