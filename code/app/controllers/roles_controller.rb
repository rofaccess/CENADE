class RolesController < ApplicationController
  before_action :set_submenu, only: [:edit, :new, :show, :index]
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  respond_to :html, :js

  def set_submenu
   @submenu_layout = 'layouts/submenu_configuracion'
  end

  def index
  	get_roles
  end

  def show

  end

  def new
  	@role= Role.new
  end

  def create
  	@role = Role.new(role_params)
  	respond_to do |format|
      if @role.save
      	@role.permission_ids = params[:role][:permission_ids]

        format.html { redirect_to roles_path, flash: {notice: "El rol #{@role.name} fue creado"}}
      else

        flash.now[:alert] = "Ha ocurrido un problema al tratar de guardar el rol"
        format.html { render "new"}
      end
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @role.update_attributes(role_params)
      	@role.permission_ids = params[:role][:permission_ids]

        format.html { redirect_to role_path, notice: 'Rol actualizado correctamente'}
      else

        flash.now[:alert] = "Ha ocurrido un problema al tratar de guardar el rol"
        format.html { render "edit"}
      end

    end
  end

  def destroy
    respond_to do |format|
      if @role.destroy
        format.html { redirect_to roles_url, notice: t('messages.delete_success', resource: 'el rol') }
        format.json { head :no_content }
      else
        format.html { redirect_to roles_url, alert: t('messages.delete_error', resource: 'el rol', errors: @role.errors.full_messages.to_sentence) }
        format.json { head :no_content }
      end
    end
  end

  def check_name
      role = Role.find_by_name(params[:name])

      render json: (role.nil? || role.id == params[:idd].to_i) ? true : "Ya existe el Rol especificado".to_json
  end
  def get_roles
    @search = Role.ransack(params[:q])
    @roles= @search.result.page(params[:page])
  end
  def set_role
     @role = Role.find(params[:id])
  end

  def role_params
      params.require(:role).permit(:name, permission_ids: [])
  end
end
