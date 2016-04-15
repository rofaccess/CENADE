class PacientesController < ApplicationController
		
	before_action :set_paciente, only: [:show, :edit, :update, :destroy]
	#load_and_authorize_resource #Conflicto con check_ci
	respond_to :html, :js	

	def index
		get_pacientes		
	end

	def new    	
    	@paciente = Paciente.new
    	@paciente.build_persona
    	@encargado = Encargado.new
  	end

  	def create	
  		respond_to do |format|
	  		if paciente_params[:es_menor] == "true"
				if not @encargado.save
					flash.notice= "No se ha podido guardar el/los encargados, ni el paciente #{@paciente.persona.nombre}
			    	#{@paciente.persona.apellido}."	
			    	format.html { redirect_to pacientes_path} #Lo ideal es mostrar el mensaje en el mismo formulario			    	
				end	    		
		    end		

			if @paciente.save
			    flash.notice= "Se ha guardado el paciente #{@paciente.persona.nombre}
			    #{@paciente.persona.apellido}."	
			    format.html { redirect_to pacientes_path}
			    #format.js {render action: "show"} #Es mejor: Mostrar o Listar?
			else
			    flash.alert = "No se ha podido guardar el paciente #{@paciente.persona.nombre} 
			    #{@paciente.persona.apellido}."
			    format.html { redirect_to pacientes_path} #Lo ideal es mostrar el mensaje en el mismo formulario	
			end 
		end					  
  	end

  	def edit
 	end

 	def update	 		
  	end

  	def show
  	end

  	def update_list
    	index
    	render partial: 'update_list', format: 'js'
  	end

  	def destroy  
	    if @paciente.destroy
		  flash.notice = "Se ha eliminado el paciente #{@paciente.persona.nombre} 
		  #{@paciente.persona.apellido}."	        
	    else
	      flash.alert = "No se ha podido eliminar el paciente #{@paciente.persona.nombre} 
	      #{@paciente.persona.apellido}."
	    end

	    if request.xhr?
  			# Do the ajax stuff
  			update_list
		else
  			# Do normal stuff
  			get_pacientes
  			render 'index'
		end

  	end
    def new_paciente_modal
    	new
    	render partial: 'new_paciente_modal', format: 'js'
    end 
  	def set_paciente
      @paciente = Paciente.find(params[:id])
    end

    def get_pacientes
    	@search = Paciente.ransack(params[:q])
		@pacientes= @search.result.page(params[:page])
    end
     
    def check_ci
    	persona = Persona.find_by_ci(params[:ci])

	    render json: (persona.nil? || persona.id == params[:id].to_i) ? true : "El número de CI especificado ya existe en el Sistema".to_json   		
    end	

  	def paciente_params
      params.require(:paciente).permit(:cargo,:especialidad_id,:type,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
    end

end
