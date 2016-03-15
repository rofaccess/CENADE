class UsuariosController < ApplicationController
	
	before_action :set_submenu, only: [:index]

	def set_submenu
		@submenu_layout = 'layouts/submenu_configuracion'
	end

	def index
		@usuarios= User.all
	end

	def new
		@usuario = User.new

    end

    def user_params
  	  params.require(:user).permit(:username,:password)
	end

	def create
		@user = User.new(params[:user])
	end
end
