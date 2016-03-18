class UsuariosController < ApplicationController
	
	before_action :set_submenu, only: [:index]
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	respond_to :html, :js

	def set_submenu
		@submenu_layout = 'layouts/submenu_configuracion'
	end

	def new    	
    	@usuario = User.new
    	@usuario.empleado = Empleado.new
  	end

    def set_empleado
      	@usuario = User.find(params[:id])
    end

	def index
	   	@usuarios= User.all
	end

	def create
		@usuario = User.new(usuario_params)
	end

	def usuario_params
      params.require(:user).permit(:username, :password, empleado_attributes: [:id, :nombre, :apellido, :cargo_id, :email])
    end

end
