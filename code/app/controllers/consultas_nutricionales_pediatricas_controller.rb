class ConsultasNutricionalesPediatricasController < ApplicationController

  before_action :set_consulta, only: [:show, :edit, :update]
	load_and_authorize_resource
  before_action :set_sidebar, only: [:edit, :new, :show, :index, :create, :update]
  before_action :set_submenu, only: [:edit, :update, :show, :index, :new, :create]
  before_action :set_controles, only: [:show, :edit]
  before_action :set_paciente, only: [:from_ficha]
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
		    format.html { redirect_to consulta_nutricional_pediatrica_path(@consulta), notice: t('messages.save_success', resource: 'la consulta')}
      else
        format.html{redirect_to new_consulta_nutricional_pediatrica_path, alert: t('messages.save_error', resource: 'la consulta', errors: @consulta.errors.full_messages.to_sentence)}
      end
    end
  end

  def edit
    get_doctores_nutricion
  end
  #paciente para la llamada remota desde la ficha
  def set_paciente
     @paciente= FichaNutricionalPediatrica.find(params[:ficha]).paciente
  end
  #autocompleta campos como area y paciente si se llama a nuevo desde alguna ficha
  def from_ficha
    ficha = FichaNutricionalPediatrica.find(params[:ficha])
    @paciente= ficha.paciente
    @area= Area.find_by_nombre('Nutrición')
    @consulta= ConsultaNutricionalPediatrica.new
    get_doctores_nutricion
  end

  def update
  	respond_to do |format|
      if @consulta.update_attributes(consulta_params)
    		  format.html { redirect_to consulta_nutricional_pediatrica_path(@consulta), notice: t('messages.update_success', resource: 'la consulta')}
      else
        flash.now[:alert] = t('messages.update_error', resource: 'la consulta', errors: @consulta.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_consulta_nutricional_pediatrica_path(@consulta), alert: flash.now[:alert]}
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
        :layout => "pdf.html",
        title:      'Consulta Nutricional Pediátrica',
          footer: {
          center: '[page] de [topage]',
          right:  "#{Formatter.format_datetime(Time.now)}",
          left:   "CI Nº: #{@consulta.ficha_nutricional_pediatrica.paciente_persona_ci}"
      }
      end
    end
  end

  def get_consultas
    @search = ConsultaNutricionalPediatrica.search(params[:q])
    @consultas = @search.result.page(params[:page])
  end

  #obtiene los doctores de nutrición
  def get_doctores_nutricion
	@area = Area.find_by_nombre('Nutrición')
	@doctores = Doctor.where(area_id: @area.id)
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= FichaNutricionalPediatrica.find(params[:idd]).paciente
  end

  #metodo creado para el filtro
  def buscar
    get_consultas
    render 'index'
  end
  #controles donde el area es nutricion y el paciente especificado
  def set_controles
    @controles= Control.where(area_id: @consulta.area_id, paciente_id: @consulta.ficha_nutricional_pediatrica.paciente_id).limit(9).order(id: :desc)
  end

  def check_paciente_has_ficha
    ficha = FichaNutricionalPediatrica.find_by_paciente_id(params[:paciente_id])

    render json: !(ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente no posee una Ficha aún".to_json
  end

  def set_consulta
  	@consulta= ConsultaNutricionalPediatrica.find(params[:id])
    @paciente= @consulta.ficha_nutricional_pediatrica.paciente
  end

  def consulta_params
  	params.require(:consulta_nutricional_pediatrica).permit(:area_id,:ficha_nutri_ped_id, :paciente_id, :doctor_id, :fecha, :encargado, :sosten_cefalico,
  		 :sento, :paro,:camino, :sigue_luz, :rie_llora, :busca_sonido, :emite_sonido, :habilidades, :mastica_deglute, :otros, :desayuno, :media_manana, :almuerzo,
  		 :merienda, :cena, :cargo_quien, :diarrea, :vomitos, :fiebre, :constipacion, :orina, :sudor, :problemas_respiratorios,
  		 :distension_abdominal, :otros2, :diagnostico, :peso, :talla, :pc, :imc, :cm)
  end
end
