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
    get_turnos
  end

  def show
    @turno = Turno.find(params[:id])
    area = @turno.area_nombre

    case area
    when "Clínico"
      get_datos_clinico
      @data_partial = 'datos_clinico'
    when "Fisioterapia"
      get_datos_fisioterapia
      @data_partial = 'datos_fisioterapia'
    when "Fonoaudiología"
    when "Neurología"
    when "Nutrición"
      get_datos_nutricion
    when "Odontología"
    when "Pediatría"
    when "Psicología"
    when "Psicología"
    else
    end
  end

  def get_datos_clinico
    @datos = 'CLINICO'
  end

  def get_datos_fisioterapia
    @datos = 'FISIOTERAPIA'
  end

  def get_datos_nutricion
    paciente  = @turno.paciente
    ficha_ped = paciente.ficha_nutricional_pediatrica
    ficha_ad  = paciente.ficha_nutricional_adulto
    consultas_ped = ConsultaNutricionalPediatrica.where(ficha_nutri_ped_id: ficha_ped.blank? ? nil : ficha_ped.id).order(fecha: :desc)
    consultas_ad  = ConsultaNutricionalAdulto.where(ficha_nutricional_adulto_id: ficha_ad.blank? ? nil : ficha_ad.id).order(fecha: :desc)
    controles     = Control.where(area_id: @turno.area_id,paciente_id: paciente.id).order(fecha: :desc)

    @datos = {paciente: paciente, ficha_ped: ficha_ped, data_partial: 'datos_nutricion'}
  end

  def setEstadoTurnoToAtendido
    turno = Turno.find(params[:turno_id])
    if turno.update_attribute(:estado, 'atendido')
      flash.now[:notice] = "El paciente #{turno.paciente.persona_full_name} ha sido atendido."
      get_turnos
      render 'get_turnos'
    else
      flash.now[:alert] = "Ocurrio un error."
      get_turnos
      render 'get_turnos'
    end
  end

  # Obtiene los turnos en cierta fecha que no hayan sido cancelados
  # Si el usuario que accede a atención profesional es de tipo doctor, se obtendrán los turnos con el
  # caso contrario, se permitirá seleccionar un doctor para seleccionar los turnos que se tienen con el
  # Solo se obtienen los turnos pendientes y atendidos
  def get_turnos
    empleado = current_user.empleado
    doctor_id = empleado.id
    fecha_consulta = Date.today
    es_doctor = es_doctor(empleado)

    unless params[:fecha_consulta].blank?
      date = params[:fecha_consulta]
      fecha_consulta = Date.parse(date).strftime('%Y/%m/%d')
      unless params[:doctor_id].blank?
        doctor_id = params[:doctor_id]
      end
    end
    turnos = Turno.where(doctor_id: doctor_id, fecha_consulta: fecha_consulta)
                   .where.not(turnos: {estado: 'cancelado'})
                   .order('turnos.fecha_consulta')

    @at_prof = {es_doctor: es_doctor, turnos: turnos}
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
