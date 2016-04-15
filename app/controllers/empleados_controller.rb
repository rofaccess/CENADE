class EmpleadosController < ApplicationController
	
	before_action :set_submenu, only: [:index,:new, :show]
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	#load_and_authorize_resource #Conflicto con check_ci
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
	  	if empleado_params[:area_id].blank?    
		   	@empleado = Funcionario.new(empleado_params)
		else
		   	@empleado = Doctor.new(empleado_params)
		end	
		respond_to do |format|
			if @empleado.save
				set_submenu			    
			    flash.now[:notice] = "Se ha guardado el empleado #{@empleado.persona.nombre} #{@empleado.persona.apellido}."
			    format.html {render 'show'}
			else
				set_submenu
				flash.now[:alert] = "No se ha podido guardar el empleado #{@empleado.persona.nombre} #{@empleado.persona.apellido}."
       			format.html { render action: "new"}	      		
			end 
		end			  
  	end

  	def edit
 	end

 	def update	 		
  	end

  	def show	    
  	end  

  	def destroy    		
		respond_to do |format|
			if checkCurrentUserEmployee(@empleado)		
	      		format.html { redirect_to empleados_path, flash: {alert: "No puedes eliminar tu propio registro de empleado"}}

			elsif @empleado.destroy							         
				format.html { redirect_to empleados_path, flash: {notice: "Se ha eliminado el empleado #{@empleado.persona.nombre} #{@empleado.persona.apellido}."}}
			else
			   	format.html { redirect_to empleados_path, flash: {alert: "No se ha podido eliminar el empleado #{@empleado.persona.nombre} #{@empleado.persona.apellido}."}}	      		
			end			
		end	
	end

  	# Si el registro de empleado que se intenta borrar corresponde al 
  	# usuario actual, no se lo permite.
  	def checkCurrentUserEmployee(empleado)
  		if current_user.empleado_id == empleado.id 
  			return true
  		end
  	end	

  	def print_empleado
  		@empleado = Empleado.find params[:empleado_id]  		
	    respond_to do |format|
	      format.pdf do
	        render :pdf => "Empleado",
	               :template => "empleados/print_empleado.pdf.erb",
	               :layout => "pdf.html"
      		end
      	end
    end

    def print_empleados
  		#@search = Empleado.ransack(params[:q]) 	
  		#@empleados= @search.result
  		@empleados = Empleado.all

	    respond_to do |format|
	      format.pdf do
	        render :pdf => "Lista de Empleados",
	               :template => "empleados/print_empleados.pdf.erb",
	               :layout => "pdf.html"
      		end
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
      params.require(:empleado).permit(:cargo,:area_id, :costo,:type,:abr_profesion,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
    end

end
