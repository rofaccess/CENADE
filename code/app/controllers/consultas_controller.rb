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
			flash.now[:notice] = "Se ha guardado la consulta de #{@consulta.paciente_persona_full_name}."
			format.html {render 'show'}
      format.js { render "show"}
		else
      if @consulta.errors.full_messages.any?
          flash.now[:alert] = @consulta.errors.full_messages.first
      else
          flash.now[:alert] = "No se ha podido guardar la Consulta."
      end
      @paciente= @consulta.paciente
			format.html { render "new"}
      format.js { render "new"}
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
   			flash.now[:notice] = "Se ha actualizado la consulta de #{@consulta.paciente_persona_full_name}."
   			format.html {render 'show'}
        format.js { render "show"}
   		else
        if @consulta.errors.full_messages.any?
          flash.now[:alert] = @consulta.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido actualizar la Consulta."
        end
   			format.html { render "edit"}
        format.js { render "edit"}
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
     @paciente= Paciente.find(params[:paciente])
     @area= Area.find(params[:area_id])
     get_doctores
     new

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
