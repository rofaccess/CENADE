class AtencionesProfesionalesController < ApplicationController
  before_action :set_submenu, only: [:show, :index ]
  before_action :set_sidebar, only: [:show, :index]
  before_action :get_turnos, only: [:show, :index]

  def set_submenu
    @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_atencion_profesional'
  end

  def index
  end

  def show
    @turno = Turno.find(params[:id])

    case @turno.area_nombre
    when "Clínico"
      get_data_clinico
    when "Fisioterapia"
      get_data_fisioterapia
    when "Fonoaudiología"
    when "Neurología"
    when "Nutrición"
      @partial='/nutricion/show'
    when "Odontología"
    when "Pediatría"
    when "Psicología"
    when "Psicología"
    else
    end
  end

  def create_consulta_ped
    @consulta_ped = ConsultaNutricionalPediatrica.new(consulta_ped_params)

    if @consulta_ped.save
      flash.now[:notice] = 'Control registrado exitosamente'
    else
      flash.now[:alert] = "No se ha podido guardar el control."
    end
    render 'atenciones_profesionales/nutricion/create_consulta_ped', format: :js
  end

  def consulta_ped_params
    params.require(:consulta_nutricional_pediatrica).permit(:area_id,:ficha_nutri_ped_id, :paciente_id, :doctor_id, :fecha, :encargado, :sosten_cefalico,
       :sento, :paro,:camino, :sigue_luz, :rie_llora, :busca_sonido, :emite_sonido, :habilidades, :mastica_deglute, :otros, :desayuno, :media_manana, :almuerzo,
       :merienda, :cena, :cargo_quien, :diarrea, :vomitos, :fiebre, :constipacion, :orina, :sudor, :problemas_respiratorios,
       :distension_abdominal, :otros2, :diagnostico, :peso, :talla, :pc, :imc, :cm)
  end

  def create_control
    @control = Control.new(control_params)

    if @control.save
      flash.now[:notice] = 'Control registrado exitosamente'
    else
      flash.now[:alert] = "No se ha podido guardar el control."
    end
    render 'atenciones_profesionales/nutricion/create_control', format: :js
  end

  def control_params
    params.require(:control).permit(:paciente_id, :area_id, :doctor_id, :fecha, :tratamiento, :observaciones)
  end

  def set_estado_turno_to_atendido
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

    unless params[:fecha_consulta].blank?
      date = params[:fecha_consulta]
      fecha_consulta = Date.parse(date).strftime('%Y/%m/%d')
      unless params[:doctor_id].blank?
        doctor_id = params[:doctor_id]
      end
    end
    @turnos = Turno.where(doctor_id: doctor_id, fecha_consulta: fecha_consulta)
                   .where.not(turnos: {estado: 'cancelado'})
                   .order('turnos.fecha_consulta')
  end
end
