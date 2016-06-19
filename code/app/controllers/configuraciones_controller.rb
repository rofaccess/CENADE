class ConfiguracionesController < ApplicationController
  load_and_authorize_resource
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
        redirect_to edit_configuracion_path(@configuracion), notice: t('messages.save_success', resource: 'la configuración')
      else
         redirect_to edit_configuracion_path(@configuracion), alert: t('messages.save_error', resource: 'la configuración', errors: @configuracion.errors.full_messages.to_sentence)
      end

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