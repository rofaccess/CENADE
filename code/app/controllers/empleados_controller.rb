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
    	@empleado = Empleado.new
    	@empleado.build_persona
  	end

  	def create	
  		if empleado_params[:especialidad_id].blank?    
	    	@empleado = Funcionario.new(empleado_params)
	    else
	    	@empleado = Doctor.new(empleado_params)
	    end			
		if @empleado.save
		    flash.notice= "Se ha guardado el empleado #{@empleado.persona.nombre}."
		    update_list
		else
		    flash.alert = "No se ha podido guardar el empleado #{@empleado.persona.nombre}."
		end   
  	end

  	def update_list
    	index
    	render partial: 'update_list', format: 'js'
  	end

  	def empleado_params
      params.require(:empleado).permit(:cargo_id,:especialidad_id,
      persona_attributes: [:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estad_civil,:direccion,:telefono,:email])
    end

end
