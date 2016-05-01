class FichasFonoaudiologicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
	before_action :set_fonoaudiologica, only: [:show, :edit, :update, :destroy]

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

  	def new
		@fonoaudiologica= FichaFonoaudiologica.new
	end

	def index
		@search = FichaFonoaudiologica.ransack(params[:q])
    	@fonoaudiologicas= @search.result.page(params[:page])
	end

	def create
	  	@fonoaudiologica = FichaFonoaudiologica.new(fonoaudiologica_params)
	  	@paciente= @fonoaudiologica.paciente
	  	 respond_to do |format|
	      if @fonoaudiologica.save
	        flash.now[:notice] = 'Ficha registrada exitosamente'
			    format.html {render 'show'}
	        format.js { render "show"}
	      else
	        if @fonoaudiologica.errors.full_messages.any?
	          flash.now[:alert] = @fonoaudiologica.errors.full_messages.first
	        else
	          flash.now[:alert] = "No se ha podido guardar la Ficha"
	        end
	        @paciente= @fonoaudiologica.paciente
	        format.html { render "edit"}
	        format.js { render "edit"}

	      end
	    end
 	end
 	def update
 	  @paciente= @fonoaudiologica.paciente
  	  respond_to do |format|
	      if @fonoaudiologica.update_attributes(fonoaudiologica_params)

	        format.html { redirect_to ficha_fonoaudiologica_path, notice: 'Ficha actualizado exitosamente'}
	      else
	        
	        if @fonoaudiologica.errors.full_messages.any?
	          flash.now[:alert] = @fonoaudiologica.errors.full_messages.first
	        else
	          flash.now[:alert] = "No se ha podido guardar la Ficha"
	        end
		        format.html { render action: "edit"}
		        format.js { render action: "edit"}
	      	end 
    	end
  	end

	# Checkea que un paciente ya no tenga una ficha en Fonoaudiologia
	def check_paciente_id
	    fonoaudiologica = FichaFonoaudiologica.find_by_paciente_id(params[:paciente_id]) 
	    render json: (fonoaudiologica.nil? || fonoaudiologica.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
	end

	#busca el paciente seleccionado en la base de datos
	def get_paciente
    @paciente= Paciente.find(params[:id])
      
  	end
 	
	def show
	 @fonoaudiologica = FichaFonoaudiologica.find(params[:id])
	end
	  #Trae la fichas segun la busqueda y página
	def get_fichas_fonoaudiologicas
	    @search = FichaFonoaudiologica.ransack(params[:q])
	    @fonoaudiologicas= @search.result.page(params[:page])
	end 

	#metodo creado para el filtro
	def buscar
	    @search = FichaFonoaudiologica.search(params[:q])
	    @fonoaudiologicas = @search.result.page(params[:page])
	    render 'index'
  	end
  	def print_ficha
      @ficha = FichaFonoaudiologica.find params[:ficha_id]      
      respond_to do |format|
        format.pdf do
          render :pdf => "Ficha",
          :template => "fichas_fonoaudiologicas/print_ficha.pdf.erb",
          :layout => "pdf.html"
        end
      end
    end
  	def set_fonoaudiologica
  	  @fonoaudiologica= FichaFonoaudiologica.find(params[:id])
    end 

	def edit
		@paciente= @fonoaudiologica.paciente
	end
	def fonoaudiologica_params
  		params.require(:ficha_fonoaudiologica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha, :escolaridad, :escuela)
     				
  	end 
end