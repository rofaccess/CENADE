class ConsultasController < ApplicationController
	before_action :set_consulta, only: [:show, :edit, :update]
	load_and_authorize_resource
  before_action :set_sidebar, only: [:edit, :new, :show, :index]
  before_action :set_submenu, only: [:edit, :update, :show, :index, :new]
  skip_load_resource :only => [:create]
  respond_to :html, :js

  def set_submenu
   @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_consultas'
  end

  def index
  	get_consultas
  end

  def new
  	@consulta= Consulta.new
    @area= Area.find(params[:area_id])
    get_doctores
    @paciente= Paciente.new
  end

  def create
  	respond_to do |format|
  		@consulta = Consulta.new(consulta_params)
  		if @consulta.save
        format.html{redirect_to consulta_path(@consulta), notice: t('messages.save_success', resource: 'la consulta')}
  		else
        flash.now[:alert] = t('messages.save_error', resource: 'la consulta', errors: @consulta.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to new_consulta_path(area_id: consulta_params[:area_id]), alert: flash.now[:alert]}
      end
	  end
  end

  def edit
    @area= @consulta.area
    get_doctores
  end

  def update
  	respond_to do |format|
   		if @consulta.update(consulta_params)
   			format.html{redirect_to consulta_path(@consulta), notice: t('messages.update_success', resource: 'la consulta')}
   		else
        flash.now[:alert] = t('messages.update_error', resource: 'la consulta', errors: @consulta.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_consulta_path(@consulta), alert: flash.now[:alert]}
   		end
   	end

  end

  def show

  end

  def get_doctores
    @doctores = Doctor.where(area_id: @area.id)
  end

  #obtiene el paciente
   def get_paciente
    @paciente= Paciente.find(params[:idd])
  end

  #recarga la lista de profesionales segun el area
   def recarga_profesional
    @sidebar_layout = ' '
    @area= Area.find(params[:id])

  end

  def set_consulta
  	@consulta = Consulta.find(params[:id])
  end

  def get_consultas
    @search = Consulta.where(area_id: params[:area_id]).ransack(params[:q])
    @consultas= @search.result.page(params[:page])

  end

  #autocompleta campos como area y paciente si se llama a nuevo desde alguna ficha
  def consulta_from_ficha
     @consulta= Consulta.new
     @paciente= Paciente.find(params[:paciente])
     @area= Area.find(params[:area_id])
     get_doctores
     #new
  end

  # Chequea si el paciente no tiene ficha
  def check_paciente_has_not_ficha
    ficha = Consulta.get_ficha(params[:area_nombre], params[:paciente_id])
    render json: ficha.nil? ? "El Paciente no tiene Ficha".to_json : true
  end

  #Busca las Consultas segun los datos puestos para filtrar
  def buscar
    get_consultas
    render 'index'
  end

  #imprime una consulta en específico
  def print_consulta
      @consulta = Consulta.find params[:consulta_id]
      respond_to do |format|
        format.pdf do
          render pdf: 'Consulta',
          template:   'consultas/print_consulta.pdf.erb',
          layout:     'pdf.html',
          title:       'Consulta',
          footer: {
            center: '[page] de [topage]',
            right: "#{Formatter.format_datetime(Time.now)}",
            left: "CI Nº: #{@consulta.paciente_persona_ci}"
          }
        end
      end
    end

  def consulta_params
    params.require(:consulta).permit(:paciente_id, :area_id, :doctor_id, :fecha,
      									:motivo_consulta, :evaluacion, :tratamiento, :observaciones)
  end
end
