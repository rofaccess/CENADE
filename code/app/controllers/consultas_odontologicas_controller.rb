class ConsultasOdontologicasController < ApplicationController

  before_action :set_consulta, only: [:show, :edit, :update]
	load_and_authorize_resource
  before_action :set_sidebar, only: [:edit, :new, :show, :index]
  before_action :set_submenu, only: [:edit, :update, :show, :index, :new]
  before_action :set_Titulo, only: [:show, :create, :update, :edit, :new, :print_consulta,:from_ficha]
  before_action :set_paciente, only: [:from_ficha]
  skip_load_resource :only => [:create]
  respond_to :html, :js

  def set_submenu
   @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_consultas'
  end

  def set_Titulo
    @titulos_largos= TituloLargo.all
  end

  def set_consulta
    @consulta= ConsultaOdontologica.find(params[:id])
    @paciente= @consulta.ficha_odontologica.paciente
  end

  #paciente para la llamada remota desde la ficha
  def set_paciente
     @paciente= FichaOdontologica.find(params[:ficha]).paciente
  end
  #autocompleta campos como area y paciente si se llama a nuevo desde alguna ficha
  def from_ficha
    ficha = FichaOdontologica.find(params[:ficha])
    @paciente= ficha.paciente
    @area= Area.find_by_nombre('Odontología')
    @consulta= ConsultaOdontologica.new
    get_doctores_odontologia
  end

  def index
  	get_consultas
  end

  def new
  	@consulta= ConsultaOdontologica.new
    @area = Area.find_by_nombre('Odontología')
    # Para renderizar un formulario vacio de datos del paciente
    @paciente = Paciente.new
  	get_doctores_odontologia
  end

   def create
    @consulta = ConsultaOdontologica.new(consulta_params)
     respond_to do |format|
      if @consulta.save
        format.html { redirect_to consulta_odontologica_path(@consulta), notice: t('messages.save_success', resource: 'la consulta')}
      else
        flash.now[:alert] = t('messages.save_error', resource: 'la consulta', errors: @consulta.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to new_consulta_odontologica_path, alert: flash.now[:alert]}
      end
    end
  end

  def edit
    @area = @consulta.area
    get_doctores_odontologia
  end

  def update

    respond_to do |format|
      if @consulta.update_attributes(consulta_params)
        format.html { redirect_to consulta_odontologica_path(@consulta), notice: t('messages.update_success', resource: 'la consulta')}
      else
        flash.now[:alert] = t('messages.update_error', resource: 'la consulta', errors: @consulta.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_consulta_odontologica_path(@consulta), alert: flash.now[:alert]}
      end
    end
  end

  def show

  end

   def print_consulta
    @consulta = ConsultaOdontologica.find params[:consulta_id]

    respond_to do |format|
      format.pdf do
        render :pdf => "Consulta",
        :template => "consultas_odontologicas/print_consulta.pdf.erb",
        :layout => "pdf.html"
      end
    end
  end

  def check_paciente_has_ficha
     ficha = FichaOdontologica.find_by_paciente_id(params[:paciente_id])

     render json: !(ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente no posee una Ficha aún".to_json
  end

  def get_consultas
    @search = ConsultaOdontologica.search(params[:q])
    @consultas = @search.result.page(params[:page])
  end

  def get_doctores_odontologia
	@area = Area.find_by_nombre('Odontología')
	@doctores = Doctor.where(area_id: @area.id)
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= FichaOdontologica.find(params[:idd]).paciente
  end

  #metodo creado para el filtro
  def buscar
    get_consultas
    render 'index'
  end

  def consulta_params
  	params.require(:consulta_odontologica).permit(:area_id, :paciente_id, :doctor_id,:ficha_odontologica_id, :fecha,
      :motivo_consulta, :observaciones,:servicio_cenade,:medicacion_actual, :anestesico,:penicilina, :otros_medicamentos,
      :hemorragias,:problema_tratamiento,:enfermedad_cardiovascular,:diabetes,:hepatitis,:enfermedades_renales,:artritis,
      :tuberculosis,:enfermedades_venereas,:enfermedades_sanguineas,:fumador,:enfermedades_neurologicas,:menstruacion,
      :embarazada,:tiene_hijos,:cantidad_hijos,:amamanta,:hospitalizado,:causa_hospitalizado,:ecg,:tac,:rx,:laboratorios,:otros_examenes,:tratamiento)
  end
end