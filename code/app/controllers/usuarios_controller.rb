class UsuariosController < ApplicationController

	before_action :set_submenu, only: [:index,:new, :edit, :show]
	before_action :set_usuario, only: [:show, :edit, :update, :destroy]

	respond_to :html, :js

	#layout false, only: [:new]

	load_and_authorize_resource :class => User
	skip_load_resource :only => [:create]

	def set_submenu
		@submenu_layout = 'layouts/submenu_configuracion'
	end

	def new
		@roles = Role.all
	    @usuario = User.new
	    @role_id = 0
    	@empleados = Empleado.includes(:persona).joins("LEFT JOIN users ON empleados.id = users.empleado_id").where(users: {empleado_id: nil})

  	end

    def set_usuario
      	@usuario = User.find(params[:id])
    end

	def index
	    get_usuarios
	end

	def edit
		@roles = Role.all
		@usuario = User.find(params[:id])
    	@role_id = UsersRole.where("user_id =?", @usuario.id).first.role_id
    	@empleados = Empleado.includes(:persona).joins("LEFT JOIN users ON empleados.id = users.empleado_id").where(users: {empleado_id: nil})
	end

	def update
		respond_to do |format|
			if params[:user][:pass_reset] == "true"
				@usuario.password = usuario_params[:username]
				@usuario.password_confirmation =  usuario_params[:username]
	    	end

			if @usuario.update(usuario_params.except(:role_id, :pass_reset))
				UsersRole.where("user_id =?", @usuario.id).update_all({role_id: usuario_params[:role_id]})
		        flash.now[:notice]= t('messages.update_success', resource: 'el usuario')
	    		set_submenu
          format.html { render "show"}
	    	else
		        flash.now[:alert]  = t('messages.update_error', resource: 'el usuario', errors: @usuario.errors.full_messages.to_sentence)
		        format.html { render "edit"}
	    	end

	    end
	end

	def create
		@roles = Role.all
		@usuario = User.new(usuario_params.except(:role_id))
	    @usuario.password_confirmation =  @usuario.username
	    @usuario.password = @usuario.username
	    @empleados = Empleado.includes(:persona).joins("LEFT JOIN users ON empleados.id = users.empleado_id").where(users: {empleado_id: nil})
		respond_to do |format|
			if @usuario.save
				set_submenu
				UsersRole.create(user_id: @usuario.id, role_id: usuario_params[:role_id])
				flash.now[:notice] = t('messages.save_success', resource: 'el usuario')
				format.html { render "show"}
			else
				set_submenu
			    flash.now[:alert] = t('messages.save_error', resource: 'el usuario', errors: @usuario.errors.full_messages.to_sentence)
			    format.html { render "new"}
			end
		end
	end

	def update_list
    	index
    	render partial: 'update_list', format: 'js'
  	end

  	def destroy
	    if @usuario.destroy
		  flash.notice = t('messages.delete_success', resource: 'el usuario')
	    else
	      flash.alert = t('messages.delete_error', resource: 'el usuario', errors: @usuario.errors.full_messages.to_sentence)
	    end
       set_submenu
	    if request.xhr?
  			# Do the ajax stuff
  			update_list
		else
  			# Do normal stuff
  			get_usuarios
  			render 'index'
		end
  	end

	def show
	end

  	 def get_usuarios
    	@search = User.ransack(params[:q])
		@usuarios= @search.result.page(params[:page])
    end

    def check_username
      user = User.find_by_username(params[:username])

      render json: (user.nil? || user.id == params[:idd].to_i) ? true : "Ya existe el Nombre de Usuario especificado".to_json
  	end

	def usuario_params
      params.require(:user).permit(:username,:empleado_id, :role_id, :pass_reset)

    end

end
