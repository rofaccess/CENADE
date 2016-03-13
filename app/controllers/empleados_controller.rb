class EmpleadosController < ApplicationController
	
	before_action :set_submenu, only: [:index]
	respond_to :html, :js

	def set_submenu
		@submenu_layout = 'layouts/submenu_personal'
	end

	def index
		@empleados= Empleado.all
	end

	def new
    	@persona = Persona.new
    	@empleado = Empleado.new
  	end

  	def create
  		#@persona = @empleado.persona.new(empleado_params[:persona])
	    
	    #@empleado = Empleado.new(empleado_params)
	    #if @empleado.save
	     # flash.notice= "Se ha guardado el empleado #{@empleado.nombre}."
	      #update_list
	    #else
	     # flash.alert = "No se ha podido guardar el empleado #{@empleado.nombre}."
	    #end
  	end

  	def empleado_params
      params.require(:empleado).permit(:persona,:cargo_id, :especialidad_id)
    end

end
