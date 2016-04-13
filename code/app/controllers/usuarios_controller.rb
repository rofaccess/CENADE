class UsuariosController < ApplicationController
	
	before_action :set_submenu, only: [:index]
	before_action :set_usuario, only: [:show, :edit, :update, :destroy]
	respond_to :html, :js

	layout false, only: [:new]
	
	load_and_authorize_resource

	def set_submenu
		if(!params[:l])
			@submenu_layout = 'layouts/submenu_configuracion'
		end
	end

	def new 
	    @usuario = User.new   	
    	@empleados = Empleado.includes(:persona, :cargo).joins("LEFT JOIN users ON empleados.id = users.empleado_id").where(users: {empleado_id: nil})
    	# Fuente:  http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/
    	# Obtiene los empleados que no tengan ningún usuario
    	#@empleados = Empleado.find_by_sql("SELECT * FROM users FULL OUTER JOIN empleados ON users.empleado_id = empleados.id WHERE users.empleado_id IS null OR empleados.id IS null")
    	respond_to do |format|
	   		format.html { }	

	   	
	   	end
  	end

    def set_usuario
      	@usuario = User.find(params[:id])
    end

	def index
	    @search = User.ransack(params[:q])
 		@usuarios= @search.result.page(params[:page])
	end

	def edit
		@usuario = User.find(params[:id])
	end

	def update
		if @usuario.update(usuario_params)
			@usuario.role_ids = params[:user][:role_ids]
	        flash.notice= "Se ha actualizado el usuario #{@usuario.empleado.persona.nombre}
	        #{@usuario.empleado.persona.apellido}."       
    else
        flash.alert = "No se ha podido actualizar el usuario #{@usuario.empleado.persona.nombre} 
        #{@usuario.empleado.persona.apellido}."
    end 
    update_list
	end

	def create
		@usuario = User.new(usuario_params)
	    @usuario.password_confirmation =  @usuario.username+"ABC123"
	    @usuario.password = @usuario.username+"ABC123"
		if @usuario.save
			@usuario.role_ids = params[:user][:role_ids]
		    flash.notice= "Se ha guardado el usuario #{@usuario.username}"		    
		else
		    flash.alert = "No se ha podido guardar el usuario #{@usuario.username}"
		end 
		update_list  
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
	    index
  	end

	def show
		@usuario = User.find(params[:id])
		@empleado= Empleado.where("id=?",@usuario.empleado_id).first
	end

  	# def get_empleado
   #    @empleado = Empleado.find(params[:id])
   #    @usuario = User.new
   #    render partial:'get_empleado', formats:'html'
   #  end

	def usuario_params
      params.require(:user).permit(:username,:empleado_id, :rol)
      
    end

end
