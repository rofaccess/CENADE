class FichaFisioterapiaNinosController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
  	before_action :set_fisionino, only: [:show, :edit, :update, :destroy]

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
  end

   def create
  	@fisio_nino = FichaFisioterapiaNino.new(fisio_nino_params)

  	 respond_to do |format|
      if @fisio_nino.save
        flash.now[:notice] = 'Ficha registrada exitosamente'
		    format.html {render 'show'}
        format.js { render "show"}
      else
        if @fisio_nino.errors.full_messages.any?
          flash.now[:alert] = @fisio_nino.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Ficha"
        end
        @fisio_nino_nuevo= true
        format.html { render "edit"}
        format.js { render "edit"}

      end
    end
  end

  def edit
    @fisio_nino_nuevo= nil
  end

  def update
  	respond_to do |format|
      if @fisio_nino.update_attributes(fisio_nino_params)

        format.html { redirect_to ficha_fisioterapia_nino_path, notice: 'Ficha actualizado exitosamente'}
      else
        
        if @fisio_nino.errors.full_messages.any?
          flash.now[:alert] = @fisio_nino.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Ficha"
        end
        format.html { render action: "edit"}
        format.js { render action: "edit"}
      end
      
    end
  end

  def show

  end
  # Checkea que un paciente ya no tenga una ficha en Fisio Niños
  def check_paciente_id
    fisio_nino = FichaFisioterapiaNino.find_by_paciente_id(params[:paciente_id])
      
    render json: (fisio_nino.nil? || fisio_nino.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= Paciente.find(params[:id])
      
  end

  #Trae la fichas segun la busqueda y página
  def get_ficha_fisioterapia_ninos
    @search = FichaFisioterapiaNino.ransack(params[:q])
    @fisio_ninos= @search.result.page(params[:page])
  end 

  #metodo creado para el filtro
  def buscar
    @search = FichaFisioterapiaNino.search(params[:q])
    @fisio_ninos = @search.result.page(params[:page])
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
  end 

  def fisio_nino_params
  	params.require(:ficha_fisioterapia_nino).permit(:area_id, :paciente_id, :doctor_id, :control_embarazo, :edad_gestacional,
     				:tipo_parto, :peso_nacer, :apgar, :antecedentes_familiares, :condicion_general,:fecha, :nro_ficha)
  end 
end
