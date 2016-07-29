class Turno < ActiveRecord::Base
	paginates_per 20

  #Asociaciones
	belongs_to :paciente, -> { with_deleted }
	belongs_to :area
  belongs_to :doctor, -> { with_deleted }

  #Validaciones
  validates :paciente_id,  presence: true
  validates :fecha_expedicion, presence: true
  validates :fecha_consulta,  presence: true
  validates :area_id,  presence: true
  validates :doctor_id,  presence: true
  validates :paga, inclusion: { in: [true, false] }
  validates :estado,  presence: true
  validates :monto, length: {maximum: Domain::COSTO}, number_only: true, allow_blank: true
  validates :nro_factura, length: {maximum: Domain::NRO_FACTURA}

	validate :coincidencia_area
  validate :verificar_fecha_consulta
  validate :paciente_unico_area_fecha_consulta

  #Cargas automaticas
  before_validation :actualizar_estado, on: :create

  before_create :actualizar_turno
  #before_update :actualizar_turno #No se debe actualizar el numero de turno
  before_create :actualizar_grupo

  before_update :actualizar_grupo
  #before_create :actualizar_estado #Reemplazado por before_validation :actualizar_estado, on: :create
  after_create :actualizar_reporte_pend
  after_update :actualizar_reporte

	def actualizar_turno
     turnoo = Turno.where("fecha_consulta = ? and area_id= ? and doctor_id= ?", self.fecha_consulta, self.area_id, self.doctor_id).order(:turno)
      if turnoo.empty?
        self.turno = 1
      else
        nro_turno = turnoo.last.turno
        self.turno = nro_turno+1
      end
    end

  #MODIFICA ESTE METODO CUANDO SE IMPLEMENTA ATENCION PROFESIONAL#
  def actualizar_reporte
    if (self.estado == "atendido")
      fecha= self.fecha_consulta
      mes= fecha.strftime('%B')
      anho= fecha.strftime('%Y')
      reporte= ReporteEstadistico.find_or_create_by(area_id: self.area_id, doctor_id: self.doctor_id, mes: mes, anho: anho)
      cant= reporte.cantidad
      if (cant.nil?)
        reporte.update_attribute(:cantidad, 1)
      else
        reporte.update_attribute(:cantidad, cant + 1)
      end
    end
  end

  def actualizar_reporte_pend
    fecha= self.fecha_consulta
    mes= fecha.strftime('%B')
    anho= fecha.strftime('%Y')
    reporte= ReporteEstadistico.find_or_create_by(area_id: self.area_id, doctor_id: self.doctor_id, mes: mes, anho: anho)
    cant= reporte.cant_pend
    if (cant.nil?)
      reporte.update_attribute(:cant_pend, 1)
    else
      reporte.update_attribute(:cant_pend, cant + 1)
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

  def obtener_cantidad
    turnos= Turno.where("area_id = ? and doctor_id = ? and fecha_consulta =  ?", self.area_id, self.doctor_id, self.fecha_consulta).count
    return turnos
  end

  def coincidencia_area
    if !(self.area_id == Empleado.where("id = ?", self.doctor_id).first.area_id)
      errors.add(:base, "El Doctor no atiende en el Área de #{self.area.nombre}")
    end
  end

   def paciente_unico_area_fecha_consulta
      turno= Turno.find_by(paciente_id: self.paciente_id, fecha_consulta: self.fecha_consulta, area_id: self.area_id)
      if !turno.nil? && turno.id != self.id
        errors.add(:base, "El paciente ya posee un turno para el área y la fecha")
      end
    end

  def pendiente?
    self.estado=='pendiente'
  end

  def atender
    self.update_attribute(:estado, 'atendido')
  end

  def actualizar_grupo
    self.grupo= self.fecha_consulta.strftime("%d/%m/%Y").to_s + ' en ' + self.area_nombre.humanize.to_s
  end

  # Law of Demeter
  delegate :nombre, to: :area, prefix: true, allow_nil: true

  delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true

  delegate :persona_full_name,:persona_ci,:persona_nombre,:persona_apellido,
             :persona_direccion,:persona_telefono, to: :paciente, prefix: true, allow_nil: true
end
