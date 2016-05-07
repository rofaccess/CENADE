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
		@paciente.build_encargado
	end

	def create	
		respond_to do |format|

			@paciente = Paciente.new(paciente_params)       
			if @paciente.save		    
				flash.now[:notice] = "Se ha guardado el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
				format.html {render 'show'}
			else
				flash.now[:alert] = "No se ha podido guardar el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
				format.html { render action: "new"}	
			end 
		end
	end 
	
	def recarga_paciente      

		@paciente = Paciente.new(paciente_params)       
		if @paciente.save       
			flash.now[:notice] = "Se ha guardado el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
			
		else
			flash.now[:alert] = "No se ha podido guardar el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."
			
		end
		render 'recarga_paciente', format: :js 		
	end

	def new_paciente_modal
		@paciente = Paciente.new
		@paciente.build_persona
    @paciente.build_encargado
		render 'new_paciente_modal', format: :js
	end 
  
  # Por ahora especifico para ficha fisioterapia adulto
  def recarga_paciente2  
    @paciente = Paciente.new(paciente_params)       
    if @paciente.save       
      flash.now[:notice] = "Se ha guardado el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."      
    else
      flash.now[:alert] = "No se ha podido guardar el paciente #{@paciente.persona.nombre} #{@paciente.persona.apellido}."      
    end
    render 'recarga_paciente2', format: :js    
  end

  # Por ahora especifico para ficha fisioterapia adulto
  def new_modal
    @paciente = Paciente.new
    @paciente.build_persona
    @paciente.build_encargado
    render 'new_modal', format: :js
  end 
  
	def edit
      # Cuando el paciente a editar no tiene encargado, el field_for para encargado, no muestra los campos
      # es necesario hacer un build cuando el paciente no tiene encargado, para poder mostrar los campos
      if @paciente.encargado_id.blank?
      	@paciente.build_encargado
      end
   end

   def update	
   	respond_to do |format|       
   		if @paciente.update(paciente_params)

   			destroy_encargado(params[:paciente][:borrar_encargado], @paciente)

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

    # Si en el form de edición de paciente se desactiva el checkbox, se ejecutará el contenido de esta función para eliminar
    # los datos del encargado, se usa un borrado osioso.
    def destroy_encargado(condicion, paciente)
    	if condicion == "true" && !paciente.encargado_id.nil?

    		if paciente.destroy_encargado
    			paciente.update(encargado_id: nil)
    		else 
    			flash.now[:alert] = "No se ha podido eliminar los encargados del paciente #{paciente.persona.nombre} #{paciente.persona.apellido}."
    			format.html { render action: "new"} 
    		end 
    	end
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

    def print_paciente
    	@paciente = Paciente.find params[:paciente_id]      
    	respond_to do |format|
    		format.pdf do
    			render pdf:  'Registro de Paciente',
    			template:    'pacientes/print_paciente.pdf.erb',
    			layout:      'pdf.html',
          title:       'Registro de Paciente',
          footer: { 
            center: '[page] de [topage]',
            left: "#{Formatter.format_datetime(Time.now)}" 
          }     
    		end
    	end
    end

    def print_pacientes
    	@pacientes = Paciente.all

    	respond_to do |format|
    		format.pdf do
    			render pdf:   'Lista de Pacientes',
    			template:     'pacientes/print_pacientes.pdf.erb',
    			layout:       'pdf.html',
          orientation:  'Landscape',
          title:        'Lista de Pacientes',            
          footer: { 
            center: '[page] de [topage]',
            left: "#{Formatter.format_datetime(Time.now)}" 
          }                            
          #disposition:  'attachment' # Ya descarga el pdf en la pc
    		end
    	end
    end

    def set_paciente
    	@paciente = Paciente.find(params[:id])
    end

    # Buscador de pacientes
    def buscar
      @search = Paciente.ransack(params[:q])
      @pacientes= @search.result
      render json: {items: @pacientes.as_json(:only => [:id, :profesion,:lugar_trabajo,:lugar_nacimiento,:fecha_ingreso],                                              
                                              :methods => [:persona_full_name, :persona_ci],
                                            )}      
    end  

    def get_pacientes
    	@search = Paciente.ransack(params[:q])
    	@pacientes= @search.result.page(params[:page])
    end

    def get_paciente
      @paciente= Paciente.find(params[:id])
      render params[:root].to_s()+'/get_paciente', format: :js  
    end

    def check_ci
    	persona = Persona.find_by_ci(params[:ci])
    	render json: (persona.nil? || persona.id == params[:persona_id].to_i) ? true : "El número de CI especificado ya existe en el Sistema".to_json   		
    end	

    def paciente_params
    	params.require(:paciente).permit(:lugar_nacimiento,:fecha_ingreso,:profesion, :lugar_trabajo, :encargado_id,
    		persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
    			:sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad],
    			encargado_attributes: [:id,:padre_nombre, :padre_edad, :padre_prof_act_ant, :madre_nombre, :madre_edad, :madre_num_hijos,
    				:madre_prof_act_ant, :encargado_nombre, :encargado_edad, :encargado_prof_act_ant])
    end

 end
