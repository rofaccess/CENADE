class UsuariosController < ApplicationController
	
	before_action :set_submenu, only: [:index]
	before_action :set_usuario, only: [:show, :edit, :update, :destroy]
	respond_to :html, :js

	def set_submenu
		@submenu_layout = 'layouts/submenu_configuracion'
	end

	def new 
	    @usuario = User.new   	
    	@empleados = Empleado.all
  	end

    def set_usuario
      	@usuario = User.find(params[:id])
    end

	def index
	   	@usuarios= User.all
	end

	def create
		@usuario = User.new(usuario_params)
	    @usuario.password_confirmation = @usuario.password
	    @usuario.email = "a@gmail.com"
  
		if @usuario.save
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

	def show
			respond_to do |format|
	       	format.js { render 'show' }	      
	    end
	end

  	def get_empleado
      @empleado = Empleado.find(params[:id])
      @usuario = User.new
      render partial:'get_empleado', formats:'html'
    end

	def usuario_params
      params.require(:user).permit(:username, :password,:empleado_id, :rol)
      
    end

end
