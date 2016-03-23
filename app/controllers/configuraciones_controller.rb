class ConfiguracionesController < ApplicationController
  
  before_action :set_submenu, only: [:edit]

  def set_submenu
   @submenu_layout = 'layouts/submenu_configuracion'
  end 
  def edit
   @configuracion = Configuracion.find(params[:id])
  end

  def update
    @configuracion = Configuracion.find(params[:id])
    respond_to do |format|
      if @configuracion.update_attributes(configuracion_params)
        flash.now[:notice] = "Configuraciones actualizados correctamente"
        format.html { render action: "edit"}
      else
        @error = true
        @message = "Ha ocurrido un problema al tratar de guardar la configuracion"
      end
    end
  end
  def new
  end 
  def create
  end 
  def show
    @configuracion = Configuracion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @configuracion }
    end
  end
 
  private

  def configuracion_params
      params.require(:configuracion).permit(:empresa_nombre, :empresa_direccion, :empresa_tel, :empresa_email, :empresa_horario_atencion,:empresa_web, :empresa_logo)
  end
 end