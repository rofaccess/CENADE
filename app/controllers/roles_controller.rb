class RolesController < ApplicationController
  before_action :set_submenu, only: [:edit, :new, :show, :index]
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  #load_and_authorize_resource #Conflicto con check_name

  def set_submenu
   @submenu_layout = 'layouts/submenu_configuracion'
  end 

  def index
  	@search = Role.ransack(params[:q])
    @roles= @search.result.page(params[:page])
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
        format.html { render action: "new"}
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
        format.html { render action: "edit"}
      end
      
    end
  end
   def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end
  def check_name
      role = Role.find_by_name(params[:name])
      
      render json: (role.nil? || role.id == params[:id].to_i) ? true : "Ya existe el Rol especificado".to_json     
  end 
  
  def set_role
     @role = Role.find(params[:id])
  end

  def role_params
      params.require(:role).permit(:name, permission_ids: [])
  end
end
