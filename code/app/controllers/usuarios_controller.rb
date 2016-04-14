class UsuariosController < ApplicationController
	
	before_action :set_submenu, only: [:index,:new, :edit, :show]
	before_action :set_usuario, only: [:show, :edit, :update, :destroy]
	
<<<<<<< HEAD
	
=======
	#load_and_authorize_resource	
>>>>>>> a28e49f0d2011db8b05c94ec24c8910f6eae97f8

	def set_submenu
		@submenu_layout = 'layouts/submenu_configuracion'	
	end

	def new 
	    @usuario = User.new   	
    	@empleados = Empleado.includes(:persona).joins("LEFT JOIN users ON empleados.id = users.empleado_id").where(users: {empleado_id: nil})
    	# Fuente:  http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/
    	# Obtiene los empleados que no tengan ningún usuario
    	#@empleados = Empleado.find_by_sql("SELECT * FROM users FULL OUTER JOIN empleados ON users.empleado_id = empleados.id WHERE users.empleado_id IS null OR empleados.id IS null")    	
  	end

    def set_usuario
      	@usuario = User.find(params[:id])
    end

	def index
	    get_usuarios
	end

	def edit
	end

	def update
		respond_to do |format|
			if params[:user][:pass_reset] == "true"
				@usuario.password = usuario_params[:username]+"ABC123"
				@usuario.password_confirmation =  usuario_params[:username]+"ABC123"	    		
	    	end		

			if @usuario.update(usuario_params)
				@usuario.role_ids = params[:user][:role_ids]		       
		        format.html { redirect_to usuarios_path, flash: {notice: "Se ha actualizado el usuario #{@usuario.empleado.persona.nombre}
		        #{@usuario.empleado.persona.apellido}."}}     
	    	else
		        flash.alert = "No se ha podido actualizar el usuario #{@usuario.empleado.persona.nombre} 
		        #{@usuario.empleado.persona.apellido}."
		        format.html { render action: "edit"}
	    	end 
	    end	   
	end

	def create
		@usuario = User.new(usuario_params)
	    @usuario.password_confirmation =  @usuario.username+"ABC123"
	    @usuario.password = @usuario.username+"ABC123"
		respond_to do |format|
			if @usuario.save
				@usuario.role_ids = params[:user][:role_ids]	
				format.html { redirect_to usuarios_path, flash: {notice: "Se ha guardado el usuario #{@usuario.username}"}}       
			else
			    flash.alert = "No se ha podido guardar el usuario #{@usuario.username}"
			    format.html { render action: "new"}
			end 
		end								
	end

	def update_list
    	index
    	render partial: 'update_list', format: 'js'
  	end

  	def destroy  
	    if @usuario.destroy
		  flash.notice = "Se ha eliminado el usuario #{@usuario.username}."	        
	    else
	      flash.alert = "No se ha podido eliminar el usuario #{@usuario.username}."
	    end
	    
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
      
      render json: (user.nil? || user.id == params[:id].to_i) ? true : "Ya existe el Nombre de Usuario especificado".to_json     
  	end 

	def usuario_params
      params.require(:user).permit(:username,:empleado_id, :rol)
      
    end

end
