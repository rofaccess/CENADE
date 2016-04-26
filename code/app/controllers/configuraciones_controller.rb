class ConfiguracionesController < ApplicationController
  #load_and_authorize_resource
  before_action :set_submenu, only: [:edit, :update, :show]

  def set_submenu
   @submenu_layout = 'layouts/submenu_configuracion'
  end 
  def edit
   @configuracion = Configuracion.find(params[:id])
   @usuarios = User.all 
  
  end

  def update
    @configuracion = Configuracion.find(params[:id])
    @usuarios = User.all
      if @configuracion.update_attributes(configuracion_params)
        flash.now[:notice] = "Configuraciones actualizadas correctamente"
      else
        #@error = true
        #@message = "Ha ocurrido un problema al tratar de guardar la configuracion"
        flash.now[:alert] = "Ha ocurrido un problema al tratar de guardar la configuracion"
      end
      redirect_to action: 'edit' 
  end

  def new  

  end 

  def create
  end 
  # def show
  #   @configuracion = Configuracion.find(params[:id])

  #   respond_to do |format|
  #     #format.html # show.html.erb
  #     format.html { render action: "edit"}
  #     format.json { render json: @configuracion }
  #   end
  # end
 
  private

  def configuracion_params
      params.require(:configuracion).permit(:empresa_nombre, :empresa_direccion, :empresa_tel, :empresa_email,:empresa_web,:hora_inicio_mañana,
                     :hora_fin_mañana,:hora_inicio_tarde,:hora_fin_tarde,:usuario_admin,:dias_atencion, :empresa_logo)
  end
 end