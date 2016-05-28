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
    @es_doctor = es_doctor
    if @es_doctor
      get_pacientes
    else

    end
  end

  def show
  end

  # Obtiene los pacientes que tienen turno con el doctor logueado
  # en la fecha especificada
  def get_pacientes
    doctor_id = current_user.empleado_id
    @pacientes = Paciente.joins(:turnos)
                         .where(turnos: {doctor_id: doctor_id, fecha_consulta: Date.today})
                         #.joins('LEFT OUTER JOIN turnos ON pacientes.id = turnos.paciente_id')
                         #.where('pacientes.id = turnos.paciente_id OR turnos.doctor_id = 16')
                         #.where("turnos.doctor_id = '#{doctor_id}'")
                         #.order('turnos.fecha')
  end

  def es_doctor
    tipo = current_user.empleado_type
    if tipo == 'Doctor'
      true
    else
      false
    end
  end
end
