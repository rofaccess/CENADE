class FichasNutricionalesPediatricasController < ApplicationController

  before_action :set_submenu, only: [:edit, :new, :show, :index, :create, :update]
  before_action :set_sidebar, only: [:edit, :new, :show, :index, :create, :update]
  before_action :set_ficha_nutri_pediatrica, only: [:show, :edit, :update]
  before_action :set_Titulo, only: [:show, :create, :update, :edit, :new, :print_ficha]
  before_action :set_consulta, only: [:show, :edit]
  load_and_authorize_resource
  skip_load_resource :only => [:create]

  def set_submenu
  	@submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_Titulo
    @titulos_largos= TituloLargo.all
  end

  def set_sidebar
   	@sidebar_layout = 'layouts/sidebar_fichas'
  end

  def index
  	get_fichas
  end

  def new
  	@nutri_pediatrica= FichaNutricionalPediatrica.new
    # Para renderizar un formulario vacio de datos del paciente
    @paciente = Paciente.new
  	get_doctores_nutricion

  end

  def create
  	@nutri_pediatrica = FichaNutricionalPediatrica.new(nutri_pediatrica_params)
    #@paciente= @nutri_pediatrica.paciente
    set_consulta
  	 respond_to do |format|
      if @nutri_pediatrica.save
        flash.now[:notice] = 'Ficha registrada exitosamente'
		    format.html {render 'show'}
        format.js { render "show"}
      else
        if @nutri_pediatrica.errors.full_messages.any?
          flash.now[:alert] = @nutri_pediatrica.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Ficha"
        end

        format.html { render "edit"}
        format.js { render "edit"}

      end
    end
  end

  def edit
    get_doctores_nutricion
  end

  def get_fichas
    @search = FichaNutricionalPediatrica.search(params[:q])
    @nutri_pediatricas = @search.result.order('nro_ficha').page(params[:page])
  end

  def update

  	respond_to do |format|
      if @nutri_pediatrica.update_attributes(nutri_pediatrica_params)
	        flash.now[:notice] = 'Ficha actualizada exitosamente'
    		  format.html {render 'show'}
    	    format.js { render "show"}
      else

        if @nutri_pediatrica.errors.full_messages.any?
          flash.now[:alert] = @nutri_pediatrica.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Ficha"
        end
        format.html { render "edit"}
        format.js { render "edit"}
      end
    end
  end

  def show

  end

   def print_ficha
    @nutri_pediatrica = FichaNutricionalPediatrica.find params[:ficha_id]

    respond_to do |format|
      format.pdf do
        render :pdf => "Ficha",
        :template => "fichas_nutricionales_pediatricas/print_ficha.pdf.erb",
        :layout => "pdf.html",
        title:      'Ficha Nutricional Pediátrica',
          footer: {
          center: '[page] de [topage]',
          right:  "#{Formatter.format_datetime(Time.now)}",
          left:   "CI Nº: #{@nutri_pediatrica.paciente_persona_ci}"
      }
      end
    end
  end

  def get_doctores_nutricion
	@area = Area.find_by_nombre('Nutrición')
	@doctores = Doctor.where(area_id: @area.id)
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= Paciente.find(params[:id])
  end

  #metodo creado para el filtro
  def buscar
    get_fichas
    render 'index'
  end

  def check_paciente_has_ficha
    ficha = FichaNutricionalPediatrica.find_by_paciente_id(params[:paciente_id])
    render json: (ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  def set_ficha_nutri_pediatrica
  	@nutri_pediatrica= FichaNutricionalPediatrica.find(params[:id])
    @paciente= Paciente.find(@nutri_pediatrica.paciente_id)
  end

  def set_consulta
    @consultas= ConsultaNutricionalPediatrica.where(ficha_nutri_ped_id: @nutri_pediatrica.id).limit(9).order(id: :desc)
  end

  def nutri_pediatrica_params
  	params.require(:ficha_nutricional_pediatrica).permit(:area_id,:paciente_id, :doctor_id, :fecha, :nro_ficha,
  		 :problema_embarazo,:control_prenatal,:alimentacion_embarazo,:otros_datos,:parto_vaginal_cesarea, :termino_pretermino,
  		 :lugar_parto,:como_fue_parto, :peso_nacimiento, :asfixia_lloro, :tomo_pecho, :alimentacion_complementaria)
  end
end
