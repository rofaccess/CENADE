class EmpleadosController < ApplicationController
	
	before_action :set_submenu, only: [:index]

	def set_submenu
		@submenu_layout = 'layouts/submenu_personal'
	end

	def index
		@empleados= Empleado.all
	end

	def new
    	@empleado = Empleado.new
  	end
end
