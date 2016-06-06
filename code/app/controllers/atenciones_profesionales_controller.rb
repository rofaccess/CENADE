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
    when "Fisioterapia"
      @partial='/fisioterapia/show'
    when "Fonoaudiología"
    when "Neurología"
    when "Nutrición"
      @partial='/nutricion/show'
    when "Odontología"
      @partial='/odontologia/show'
    when "Pediatría"
    when "Psicología"
    when "Psicopedagogía"
    else
    end
  end

  def create_consulta
    @consulta = Consulta.new(consulta_params)

    if @consulta.save
      flash.now[:notice] = 'Consulta registrada exitosamente'
    else
      flash.now[:alert] = "No se ha podido guardar la consulta."
    end
    render 'atenciones_profesionales/compartido/create_consulta', format: :js
  end

  def consulta_params
    params.require(:consulta).permit(:paciente_id, :area_id, :doctor_id, :fecha,
                        :motivo_consulta, :evaluacion, :tratamiento, :observaciones)
  end

  def create_consulta_ped
    @consulta_ped = ConsultaNutricionalPediatrica.new(consulta_ped_params)

    if @consulta_ped.save
      flash.now[:notice] = 'Consulta registrada exitosamente'
    else
      flash.now[:alert] = "No se ha podido guardar la consulta."
    end
    render 'atenciones_profesionales/nutricion/create_consulta_ped', format: :js
  end

  def consulta_ped_params
    params.require(:consulta_nutricional_pediatrica).permit(:area_id,:ficha_nutri_ped_id, :paciente_id, :doctor_id, :fecha, :encargado, :sosten_cefalico,
       :sento, :paro,:camino, :sigue_luz, :rie_llora, :busca_sonido, :emite_sonido, :habilidades, :mastica_deglute, :otros, :desayuno, :media_manana, :almuerzo,
       :merienda, :cena, :cargo_quien, :diarrea, :vomitos, :fiebre, :constipacion, :orina, :sudor, :problemas_respiratorios,
       :distension_abdominal, :otros2, :diagnostico, :peso, :talla, :pc, :imc, :cm)
  end

  def create_consulta_ad
    @consulta_ad = ConsultaNutricionalAdulto.new(consulta_ad_params)

    if @consulta_ad.save
      flash.now[:notice] = 'Consulta registrada exitosamente'
    else
      flash.now[:alert] = "No se ha podido guardar la consulta."
    end
    render 'atenciones_profesionales/nutricion/create_consulta_ad', format: :js
  end

  def consulta_ad_params
    params.require(:consulta_nutricional_adulto).permit(:ficha_nutricional_adulto_id, :doctor_id, :fecha,
      :motivo_consulta, :actuales, :dx, :peso_actual, :peso_ideal, :peso_deseable, :talla, :biotipo,
      :cir_muneca, :circ_brazo, :circ_cintura, :imc, :evaluacion, :medicamentos, :suplementos, :apetito,
      :factores_apetito, :alergia_intolerancia, :cae_cabello, :estado_bucal, :orina_bien, :ir_cuerpo,
      :actividades_fisicas, :tipo, :hs_act_fisicas, :frecuencia, :actividad_laboral, :horas_laborales,
      :vive_con, :quien_prepara, :que_elementos, :toma_agua, :mastica_deglute, :dificultad_beber, :hora_acuesta,
      :hora_levanta, :duerme_bien, :habilidades, :tratamientos_cenade, :alim_desayuno, :alim_media, :alim_almuerzo,
      :alim_merienda, :alim_cena, :cant_desayuno, :cant_media, :cant_almuerzo, :cant_merienda, :cant_cena,
      :modo_desayuno, :modo_media, :modo_almuerzo, :modo_merienda, :modo_cena, :lugar_desayuno, :lugar_media, :lugar_almuerzo, :lugar_merienda, :lugar_cena, :indicaciones)
  end

  def create_consulta_odontologica
    @consulta = ConsultaOdontologica.new(consulta_odontologica_params)

    if @consulta.save
      flash.now[:notice] = 'Consulta registrada exitosamente'
    else
      flash.now[:alert] = "No se ha podido guardar la consulta."
    end
    render 'atenciones_profesionales/odontologia/create_consulta', format: :js
  end

  def consulta_odontologica_params
    params.require(:consulta_odontologica).permit(:area_id, :paciente_id, :doctor_id,:ficha_odontologica_id, :fecha,
      :motivo_consulta, :observaciones,:servicio_cenade,:medicacion_actual, :anestesico,:penicilina, :otros_medicamentos,
      :hemorragias,:problema_tratamiento,:enfermedad_cardiovascular,:diabetes,:hepatitis,:enfermedades_renales,:artritis,
      :tuberculosis,:enfermedades_venereas,:enfermedades_sanguineas,:fumador,:enfermedades_neurologicas,:menstruacion,
      :embarazada,:tiene_hijos,:cantidad_hijos,:amamanta,:hospitalizado,:causa_hospitalizado,:ecg,:tac,:rx,:laboratorios,:otros_examenes,:tratamiento)
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
