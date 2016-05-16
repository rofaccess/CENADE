class ControlesController < ApplicationController
  before_action :set_control, only: [:show, :edit, :update]
	#load_and_authorize_resource
  #before_action :set_sidebar, only: [:edit, :new, :show, :index]

  before_action :set_submenu, only: [:edit, :update, :show, :index, :new]

  respond_to :html, :js

  def set_submenu
   @submenu_layout = 'layouts/submenu_fichas_consultas'
  end
  def index
  	get_controles
  end

  def new
  	@control= Control.new
    @area= Area.find(params[:area_id])
    get_doctores
    get_controles
  end

  def create
  	@control = Control.new(control_params)
  	respond_to do |format|
		if @control.save

			flash.now[:notice] = "Se ha guardado el control de #{@control.paciente_persona_full_name}."
			format.html {render 'show'}
      		format.js { render "show"}

		else
	      if @control.errors.full_messages.any?
	          flash.now[:alert] = @control.errors.full_messages.first
	      else
	          flash.now[:alert] = "No se ha podido guardar la Control."
	      end
			format.html { render "new"}
      		format.js { render "new"}
		end
	end
  end

  def edit
    get_doctores
    get_controles
  end

  def update
  	respond_to do |format|
   		if @control.update(control_params)
   			flash.now[:notice] = "Se ha actualizado el control de #{@control.paciente_persona_full_name}."
   			format.html {render 'show'}
        	format.js { render "show"}
   		else
        if @control.errors.full_messages.any?
          flash.now[:alert] = @control.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido actualizar la Control."
        end

   			format.html { render "edit"}
        	format.js { render "edit"}
   		end
   	end

  end

  def show

  end

  def get_doctores
  	@paciente= Paciente.find(params[:paciente])
    @doctores = Doctor.where(area_id: @area.id)
  end

  #obtiene el paciente
   def get_paciente
    @paciente= Paciente.find(params[:id])
  end

  def set_control
  	@control = Control.find(params[:id])
  end

  def get_controles

    @search = Control.where(area_id: params[:area_id], paciente_id: params[:paciente]).ransack(params[:q])
    @controles= @search.result.page(params[:page])

  end

  #Busca las Controles segun los datos puestos para filtrar
  def buscar
    get_controles
    render 'index'
  end



  def control_params
    params.require(:control).permit(:paciente_id, :area_id, :doctor_id, :fecha, :tratamiento, :observaciones)
  end
end
