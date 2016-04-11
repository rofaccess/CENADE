class EmpleadosController < ApplicationController
	
	before_action :set_submenu, only: [:index,:new]
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	respond_to :html, :js

	def set_submenu
		@submenu_layout = 'layouts/submenu_personal'
	end

	def index
		get_empleados		
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
		    flash.notice= "Se ha guardado el empleado #{@empleado.persona.nombre}
		    #{@empleado.persona.apellido}."		    
		else
		    flash.alert = "No se ha podido guardar el empleado #{@empleado.persona.nombre} 
		    #{@empleado.persona.apellido}."
		end 

		show		  
  	end

  	def edit
 	end

 	def update	 		
  	end

  	def show
	    respond_to do |format|
	      format.js { render 'show' }	      
	    end
  	end

  	def update_list
    	index
    	render partial: 'update_list', format: 'js'
  	end

  	def destroy  
	    if @empleado.destroy
		  flash.notice = "Se ha eliminado el empleado #{@empleado.persona.nombre} 
		  #{@empleado.persona.apellido}."	        
	    else
	      flash.alert = "No se ha podido eliminar el empleado #{@empleado.persona.nombre} 
	      #{@empleado.persona.apellido}."
	    end

	    if request.xhr?
  			# Do the ajax stuff
  			update_list
		else
  			# Do normal stuff
  			get_empleados
  			render 'index'
		end

  	end

  	def set_empleado
      @empleado = Empleado.find(params[:id])
    end

    def get_empleados
    	@search = Empleado.ransack(params[:q])
		@empleados= @search.result.page(params[:page])
    end
     
    def check_ci
    	persona = Persona.find_by_ci(params[:ci])

	    render json: (persona.nil? || persona.id == params[:id].to_i) ? true : "El número de CI especificado ya existe en el Sistema".to_json   		
    end	

  	def empleado_params
      params.require(:empleado).permit(:cargo_id,:especialidad_id,:type,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estado_civil_id,:direccion,:telefono,:email])
    end

end
