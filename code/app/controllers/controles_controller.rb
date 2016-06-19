class ControlesController < ApplicationController
  before_action :set_control, only: [:show, :edit, :update]
	#load_and_authorize_resource
  #before_action :set_sidebar, only: [:edit, :new, :show, :index]

  before_action :set_submenu, only: [:edit, :update, :show, :index, :new]
  before_action :set_doctores, only: [:edit]
  before_action :set_controles, only: [:show]
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
  			format.html { redirect_to control_path(@control), notice: t('messages.save_success', resource: 'el control')}
  		else
  	    flash.now[:alert] = t('messages.save_error', resource: 'el control', errors: @control.errors.full_messages.to_sentence)
  		  format.js {render 'compartido/show_message'}
      end
	  end
  end

  def edit
    set_doctores
    get_controles
  end

  def update
  	respond_to do |format|
   		if @control.update(control_params)
   			format.html { redirect_to control_path(@control), notice:  t('messages.update_success', resource: 'el control')}
      else
        flash.now[:alert] = t('messages.update_error', resource: 'el control', errors: @control.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
   		end
   	end
  end

  def show

  end

  def get_doctores
  	@paciente= Paciente.find(params[:paciente])
    @doctores = Doctor.where(area_id: @area.id)
  end

  def set_doctores
    @doctores = Doctor.where(area_id: @control.area.id)
  end

  #obtiene el paciente
   def get_paciente
    @paciente= Paciente.find(params[:id])
  end

  def set_control
  	@control = Control.find(params[:id])
  end

  def set_controles

    @search = Control.where(area_id: @control.area_id, paciente_id: @control.paciente_id).ransack(params[:q])
    @controles= @search.result.page(params[:page])

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
