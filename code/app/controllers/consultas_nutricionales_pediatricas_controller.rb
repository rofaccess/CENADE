class ConsultasNutricionalesPediatricasController < ApplicationController

  before_action :set_consulta, only: [:show, :edit, :update]
	#load_and_authorize_resource
  before_action :set_sidebar, only: [:edit, :new, :show, :index]
  before_action :set_submenu, only: [:edit, :update, :show, :index, :new, :create]
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
  	@consulta= ConsultaNutricionalPediatrica.new
    # Para renderizar un formulario vacio de datos del paciente
    @paciente = Paciente.new
  	get_doctores_nutricion
  end

  def create
  	@consulta = ConsultaNutricionalPediatrica.new(consulta_params)
    #@paciente= @nutri_pediatrica.paciente
  	 respond_to do |format|
      if @consulta.save
        flash.now[:notice] = 'Consulta registrada exitosamente'
		format.html {render 'show'}
        format.js { render "show"}
      else
        if @consulta.errors.full_messages.any?
          flash.now[:alert] = @consulta.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Consulta"
        end

        format.html { render "edit"}
        format.js { render "edit"}

      end
    end
  end

  def edit
    get_doctores_nutricion
  end

  def update

  	respond_to do |format|
      if @consulta.update_attributes(consulta_params)
	        flash.now[:notice] = 'Consulta actualizada exitosamente'
    		format.html {render 'show'}
    	    format.js { render "show"}
      else

        if @consulta.errors.full_messages.any?
          flash.now[:alert] = @consulta.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Consulta"
        end
        format.html { render "edit"}
        format.js { render "edit"}
      end
    end
  end

  def show

  end

   def print_consulta
    @consulta = ConsultaNutricionalPediatrica.find params[:consulta_id]

    respond_to do |format|
      format.pdf do
        render :pdf => "Consulta",
        :template => "consultas_nutricionales_pediatricas/print_consulta.pdf.erb",
        :layout => "pdf.html"
      end
    end
  end

  def get_consultas
    @search = ConsultaNutricionalPediatrica.search(params[:q])
    @consultas = @search.result.page(params[:page])
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
    get_consultas
    render 'index'
  end

  def check_paciente_has_ficha
    ficha = FichaNutricionalPediatrica.find_by_paciente_id(params[:paciente_id])

    render json: !(ficha.nil? || ficha.id == params[:id].to_i) ? true : "El Paciente no posee una Ficha aún".to_json
  end

  def set_consulta
  	@consulta= ConsultaNutricionalPediatrica.find(params[:id])
    @paciente= Paciente.find(@consulta.paciente_id)
  end

  def consulta_params
  	params.require(:consulta_nutricional_pediatrica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :sosten_cefalico,
  		 :sento, :paro,:camino, :sigue_luz, :rie_llora, :busca_sonido, :emite_sonido, :habilidades, :mastica_deglute, :otros, :desayuno, :media_manana, :almuerzo,
  		 :merienda, :cena, :cargo_quien, :diarrea, :vomitos, :fiebre, :constipacion, :orina, :sudor, :problemas_respiratorios,
  		 :distension_abdominal, :otros2, :diagnostico, :peso, :talla, :pc, :imc, :cm)
  end
end
