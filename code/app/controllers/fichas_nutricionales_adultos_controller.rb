class FichasNutricionalesAdultosController < ApplicationController

  before_action :set_submenu, only: [:edit, :new, :show, :index, :create, :update]
  before_action :set_sidebar, only: [:edit, :new, :show, :index, :create, :update]
  #before_action :set_consulta, only: [:show, :edit]
  before_action :set_ficha_nutri_adulto, only: [:show, :edit , :update]
  load_and_authorize_resource
  skip_load_resource :only => [:create]

  def set_submenu
  	@submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
   	@sidebar_layout = 'layouts/sidebar_fichas'
  end

  def index
  	get_fichas
  end
#falta filtrar pacientes solo mayores a 10
  def new
  	@nutri_adulto= FichaNutricionalAdulto.new
    # Para renderizar un formulario vacio de datos del paciente
    @paciente = Paciente.new
  	get_doctores_nutricion

  end

  def create
  	@nutri_adulto = FichaNutricionalAdulto.new(nutri_adulto_params)
    #@paciente= @nutri_adulto.paciente
  	 respond_to do |format|
      if @nutri_adulto.save
		    format.html { redirect_to ficha_nutricional_adulto_path(@nutri_adulto), notice: t('messages.save_success', resource: 'la ficha')}
      else
        flash.now[:alert] = t('messages.save_error', resource: 'la ficha', errors: @nutri_adulto.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to new_ficha_nutricional_adulto_path, alert: flash.now[:alert]}
      end
    end
  end

  def edit
    get_doctores_nutricion
  end

  def get_fichas
    @search = FichaNutricionalAdulto.search(params[:q])
    @nutri_adultos = @search.result.order('nro_ficha').page(params[:page])
  end

  def update

  	respond_to do |format|
      if @nutri_adulto.update_attributes(nutri_adulto_params)
    		  format.html { redirect_to ficha_nutricional_adulto_path(@nutri_adulto), notice: t('messages.update_success', resource: 'la ficha')}
      else
        flash.now[:alert] = t('messages.update_error', resource: 'la ficha', errors: @nutri_adulto.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_ficha_nutricional_adulto_path(@nutri_adulto), alert: flash.now[:alert]}
      end
    end
  end

  def show

  end

   def print_ficha
    @nutri_adulto = FichaNutricionalAdulto.find params[:ficha_id]

    respond_to do |format|
      format.pdf do
        render :pdf => "Ficha",
        :template => "fichas_nutricionales_adultos/print_ficha.pdf.erb",
        :layout => "pdf.html",
        title:      'Ficha Nutricional Adulto ',
          footer: {
          center: '[page] de [topage]',
          right:  "#{Formatter.format_datetime(Time.now)}",
          left:   "CI Nº: #{@nutri_adulto.paciente_persona_ci}"
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

  def set_consulta
    @consultas= ConsultaNutricionalAdulto.where(ficha_id: @nutri_adulto.id).limit(9).order(id: :desc)
  end

  #metodo creado para el filtro
  def buscar
    get_fichas
    render 'index'
  end

  def check_paciente_has_ficha
    ficha = FichaNutricionalAdulto.find_by_paciente_id(params[:paciente_id])
    render json: (ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  def set_ficha_nutri_adulto
  	@nutri_adulto= FichaNutricionalAdulto.find(params[:id])
    @paciente= @nutri_adulto.paciente
    @consultas= ConsultaNutricionalAdulto.where(ficha_nutricional_adulto_id: @nutri_adulto.id).limit(9).order(id: :desc)
  end

  def nutri_adulto_params
  	params.require(:ficha_nutricional_adulto).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha,
      :nro_hijos, :obesidad, :dbt, :hta, :cardiopatias, :actuales)
  end
end
