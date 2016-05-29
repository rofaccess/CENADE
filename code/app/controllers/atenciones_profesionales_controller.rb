class AtencionesProfesionalesController < ApplicationController
  before_action :set_submenu, only: [:show, :index ]
  before_action :set_sidebar, only: [:show, :index]

  def set_submenu
    @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_atencion_profesional'
  end

  def index
    get_pacientes
  end

  def show
  end

  # Obtiene los pacientes que tienen turno en cierta fecha
  def get_pacientes
    empleado = current_user.empleado
    doctor_id = empleado.id
    fecha_consulta = Date.today
    @es_doctor = es_doctor(empleado)

    unless params[:fecha_consulta].blank?
      date = params[:fecha_consulta]
      fecha_consulta = Date.parse(date).strftime('%Y/%m/%d')
      unless params[:doctor_id].blank?
        doctor_id = params[:doctor_id]
      end
    end

    @pacientes = Paciente.joins(:turnos)
                         .where(turnos: {doctor_id: doctor_id, fecha_consulta: fecha_consulta})
                         .order('turnos.fecha_consulta')
  end

  # Devuelve true si el empleado es de tipo doctor, caso contrario false
  def es_doctor(empleado)
    tipo = empleado.type
    if tipo == 'Doctor'
      true
    else
      false
    end
  end
end
