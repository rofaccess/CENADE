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
    	#@paciente.build_encargado
    end

    def create	
    	respond_to do |format|
    		if @paciente.save		    
    			flash.now[:notice] = "Se ha guardado el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
    			format.html {render 'show'}
    		else
    			flash.now[:alert] = "No se ha podido guardar el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
    			format.html { render action: "new"}	
    		end 
    	end
    end

    def edit
    end

    def update	
    	respond_to do |format|
	      if @paciente.update(paciente_params)
	        flash.now[:notice] = "Se ha actualizado el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
	        format.html {render 'show'}   
	      else
	        flash.now[:alert] = "No se ha podido actualizar los datos del paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
	        format.html { render action: "new"}        
	      end 
    	end   		
    end

    def show
    end

    def destroy    		
		respond_to do |format|					
			if @paciente.destroy							         
				format.html { redirect_to pacientes_path, flash: {notice: "Se ha eliminado el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."}}
			else
			   	format.html { redirect_to pacientes_path, flash: {alert: "No se ha podido eliminar el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."}}	      		
			end			
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
  		params.require(:paciente).permit(:lugar_nacimiento,:fecha_ingreso,:profesion, :lugar_trabajo,
  			persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
  				:sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
  	end

  end
