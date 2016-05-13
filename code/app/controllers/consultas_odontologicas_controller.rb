class ConsultasOdontologicasController < ApplicationController

  before_action :set_consulta, only: [:show, :edit, :update]
	#load_and_authorize_resource
  before_action :set_submenu, only: [:edit, :update, :show, :index, :new]
  before_action :set_Titulo, only: [:show, :create, :update, :edit, :new, :print_ficha]
  respond_to :html, :js

  def set_submenu
   @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_Titulo
    @titulos_largos= TituloLargo.all
  end

  def index
  	get_consultas
  end

  def new
  	@consulta= ConsultaOdontologica.new
    # Para renderizar un formulario vacio de datos del paciente
    @paciente = Paciente.new
  	get_doctores_odontologia
  end

  def create
  	@consulta = ConsultaOdontologica.new(consulta_params)
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
    get_doctores_odontologia
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

   def print_ficha
    @consulta = ConsultaOdontologica.find params[:consulta_id]

    respond_to do |format|
      format.pdf do
        render :pdf => "Consulta",
        :template => "consultas_odontologicas/print_ficha.pdf.erb",
        :layout => "pdf.html"
      end
    end
  end

  def check_paciente_has_ficha
     ficha = FichaOdontologica.find_by_paciente_id(params[:paciente_id])

     render json: !(ficha.nil? || ficha.id == params[:id].to_i) ? true : "El Paciente no posee una Ficha aún".to_json
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
    @paciente= Paciente.find(params[:id])
  end

  #metodo creado para el filtro
  def buscar
    get_consultas
    render 'index'
  end


  def set_ficha_odontologica
  	@consulta= ConsultaOdontologica.find(params[:id])
    @paciente= Paciente.find(@consulta.paciente_id)
  end

  def consulta_params
  	params.require(:consulta_odontologica).permit(:area_id, :paciente_id, :profesional_salud_id, :fecha,
      :motivo_consulta, :observaciones,:servicio_cenade,:medicacion_actual, :anestesico,:penicilina, :otros_medicamentos,
      :hemorragias,:problema_tratamiento,:enfermedad_cardiovascular,:diabetes,:hepatitis,:enfermedades_renales,:artritis,
      :tuberculosis,:enfermedades_venereas,:enfermedades_sanguineas,:fumador,:enfemedades_neurologicas,:menstruacion,
      :embarazada,:tiene_hijos,:cantidad_hijos,:amamanta,:hospitalizado,:causa_hospitalizado,:ecg,:tac,:rx,:laboratorios,:otros_examenes,:tratamiento)
  end
end