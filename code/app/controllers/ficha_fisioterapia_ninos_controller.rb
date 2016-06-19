class FichaFisioterapiaNinosController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
  before_action :set_fisionino, only: [:show, :edit, :update]
  before_action :set_consulta, only: [:show, :edit]
  load_and_authorize_resource
  skip_load_resource :only => [:create]

  def set_submenu
   @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
   @sidebar_layout = 'layouts/sidebar_fichas'
  end

  def index
  	get_ficha_fisioterapia_ninos
  end

  def new
  	@fisio_nino= FichaFisioterapiaNino.new
    @paciente = Paciente.new
  end

   def create
  	@fisio_nino = FichaFisioterapiaNino.new(fisio_nino_params)
    @paciente= @fisio_nino.paciente
  	 respond_to do |format|
      if @fisio_nino.save
        format.html { redirect_to ficha_fisioterapia_nino_path(@fisio_nino), notice: t('messages.save_success', resource: 'la ficha')}
      else
        flash.now[:alert] = t('messages.save_error', resource: 'la ficha', errors: @fisio_nino.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to new_ficha_fisioterapia_nino_path, alert: flash.now[:alert]}
      end
    end
  end

  def edit
    @paciente= @fisio_nino.paciente
  end

  def update
    @paciente= @fisio_nino.paciente
  	respond_to do |format|
      if @fisio_nino.update_attributes(fisio_nino_params)
        format.html { redirect_to ficha_fisioterapia_nino_path, notice: t('messages.update_success', resource: 'la ficha')}
      else
        flash.now[:alert] = t('messages.update_error', resource: 'la ficha', errors: @fisio_nino.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_ficha_fisioterapia_nino_path(@ficha), alert: flash.now[:alert]}
      end
    end
  end

  def show
    @paciente= @fisio_nino.paciente
  end

  # Checkea que un paciente ya no tenga una ficha en Fisio Niños
  def check_paciente_id
    fisio_nino = FichaFisioterapiaNino.find_by_paciente_id(params[:paciente_id])

    render json: (fisio_nino.nil? || fisio_nino.id == params[:idd].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= Paciente.find(params[:idd])

  end

  #Trae la fichas segun la busqueda y página
  def get_ficha_fisioterapia_ninos
    @search = FichaFisioterapiaNino.ransack(params[:q])
    @fisio_ninos= @search.result.order('nro_ficha').page(params[:page])
  end

  #metodo creado para el filtro
  def buscar
    get_ficha_fisioterapia_ninos
    render 'index'
  end

  def print_ficha
      @ficha = FichaFisioterapiaNino.find params[:ficha_id]
      respond_to do |format|
        format.pdf do
          render :pdf => "Ficha",
          :template => "ficha_fisioterapia_ninos/print_ficha.pdf.erb",
          :layout => "pdf.html"
        end
      end
    end
  def set_fisionino
  	@fisio_nino= FichaFisioterapiaNino.find(params[:id])
    @paciente = Paciente.find(@fisio_nino.paciente_id)
  end
  def set_consulta
    @consultas= Consulta.where(area_id: @fisio_nino.area_id, paciente_id: @fisio_nino.paciente_id).limit(9).order(id: :desc)
  end

  def fisio_nino_params
  	params.require(:ficha_fisioterapia_nino).permit(:area_id, :paciente_id, :doctor_id, :control_embarazo, :edad_gestacional,
     				:tipo_parto, :peso_nacer, :apgar, :antecedentes_familiares, :condicion_general,:fecha, :nro_ficha)
  end
end
