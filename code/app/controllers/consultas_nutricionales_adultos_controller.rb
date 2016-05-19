class ConsultasNutricionalesAdultosController < ApplicationController

  before_action :set_consulta, only: [:show, :edit, :update]
	#load_and_authorize_resource
  before_action :set_sidebar, only: [:edit, :new, :show, :index, :create, :update]
  before_action :set_submenu, only: [:edit, :update, :show, :index, :new, :create]
  before_action :set_controles, only: [:show, :edit]
  before_action :set_paciente, only: [:from_ficha]

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
  	@consulta= ConsultaNutricionalAdulto.new
    # Para renderizar un formulario vacio de datos del paciente
    @paciente = Paciente.new
    @consulta.build_recuento
  	get_doctores_nutricion
  end

  def create
  	@consulta = ConsultaNutricionalAdulto.new(consulta_params)

  	 respond_to do |format|
      if @consulta.save
		    format.html { redirect_to consulta_nutricional_adulto_path(@consulta), notice: 'Consulta registrada exitosamente'}
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
  #paciente para la llamada remota desde la ficha
  def set_paciente
     @paciente= FichaNutricionalAdulto.find(params[:ficha]).paciente
  end
  #autocompleta campos como area y paciente si se llama a nuevo desde alguna ficha
  def from_ficha
     new
  end

  def update

  	respond_to do |format|
      if @consulta.update_attributes(consulta_params)
	        #flash.now[:notice] = 'Consulta actualizada exitosamente'
    		  format.html { redirect_to consulta_nutricional_adulto_path(@consulta), notice: 'Consulta actualizada exitosamente'}
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
    @consulta = ConsultaNutricionalAdulto.find params[:consulta_id]

    respond_to do |format|
      format.pdf do
        render :pdf => "Consulta",
        :template => "consultas_nutricionales_adultos/print_consulta.pdf.erb",
        :layout => "pdf.html"
      end
    end
  end

  def get_consultas
    @search = ConsultaNutricionalAdulto.search(params[:q])
    @consultas = @search.result.page(params[:page])
  end

  #obtiene los doctores de nutrición
  def get_doctores_nutricion
	@area = Area.find_by_nombre('Nutrición')
	@doctores = Doctor.where(area_id: @area.id)
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= FichaNutricionalAdulto.find(params[:id]).paciente
  end

  #metodo creado para el filtro
  def buscar
    get_consultas
    render 'index'
  end
  #controles donde el area es nutricion y el paciente especificado
  def set_controles
    @controles= Control.where(area_id: @consulta.area_id, paciente_id: @consulta.ficha_nutricional_adulto.paciente).limit(9).order(id: :desc)
  end

  def check_paciente_has_ficha
    ficha = FichaNutricionalAdulto.find_by_paciente_id(params[:paciente_id])

    render json: !(ficha.nil? || ficha.id == params[:id].to_i) ? true : "El Paciente no posee una Ficha aún".to_json
  end

  def set_consulta
  	@consulta= ConsultaNutricionalAdulto.find(params[:id])
    @paciente= @consulta.ficha_nutricional_adulto.paciente
  end

  def consulta_params
  	params.require(:consulta_nutricional_adulto).permit(:ficha_nutricional_adulto_id, :doctor_id, :fecha,
  		:motivo_consulta, :actuales, :dx, :peso_actual, :peso_ideal, :peso_deseable, :talla, :biotipo,
  		:cir_muneca, :circ_brazo, :circ_cintura, :imc, :evaluacion, :medicamentos, :suplementos, :apetito,
  		:factores_apetito, :alergia_intolerancia, :cae_cabello, :estado_bucal, :orina_bien, :ir_cuerpo,
  		:actividades_fisicas, :tipo, :hs_act_fisicas, :frecuencia, :actividad_laboral, :horas_laborales,
  		:vive_con, :quien_prepara, :que_elementos, :toma_agua, :mastica_deglute, :hora_acuesta, :habilidades,
  		:tratamientos_cenade, :indicaciones, recuento_attributes: [:id, :consulta_nutricional_adulto_id,
  			:comidas_turnos, :hora, :alimentos, :cantidad, :modo_preparacion, :lugar_consumo]))
  end
end

