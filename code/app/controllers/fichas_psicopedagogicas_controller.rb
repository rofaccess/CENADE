class FichasPsicopedagogicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
	before_action :set_psicopedagogica, only: [:show, :edit, :update, :destroy]

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

  	def index
  		@search = FichaPsicopedagogica.ransack(params[:q])
    	@psicopedagogicas= @search.result.page(params[:page])
  	end

  	def new
		@psicopedagogica= FichaPsicopedagogica.new
	end

	def create
	  	@psicopedagogica = FichaPsicopedagogica.new(psicopedagogica_params)
	  	@paciente= @psicopedagogica.paciente
	  	 respond_to do |format|
	      if @psicopedagogica.save
	        flash.now[:notice] = 'Ficha registrada exitosamente'
			format.html {render 'show'}
	        format.js { render "show"}
	      else
	        if @psicopedagogica.errors.full_messages.any?
	          flash.now[:alert] = @psicopedagogica.errors.full_messages.first
	        else
	          flash.now[:alert] = "No se ha podido guardar la Ficha"
	        end
	        @paciente= @psicopedagogica.paciente
	        format.html { render "edit"}
	        format.js { render "edit"}

	      end
	    end
 	end

 	def update
 	  @paciente= @psicopedagogica.paciente
  	  respond_to do |format|
	      if @psicopedagogica.update_attributes(psicopedagogica_params)

	        format.html { redirect_to ficha_psicopedagogica_path, notice: 'Ficha actualizado exitosamente'}
	      else
	        
	        if @psicopedagogica.errors.full_messages.any?
	          flash.now[:alert] = @psicopedagogica.errors.full_messages.first
	        else
	          flash.now[:alert] = "No se ha podido guardar la Ficha"
	        end
		        format.html { render action: "edit"}
		        format.js { render action: "edit"}
	      	end 
    	end
  	end


	def show
		@psicopedagogica = FichaPsicopedagogica.find(params[:id])
	end

	def edit
		@paciente= @psicopedagogica.paciente
	end

		# Checkea que un paciente ya no tenga una ficha en Psicopedagogia
	def check_paciente_id
	    psicopedagogica = FichaPsicopedagogica.find_by_paciente_id(params[:paciente_id]) 
	    render json: (psicopedagogica.nil? || psicopedagogica.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
	end

	#busca el paciente seleccionado en la base de datos
	def get_paciente
    	@paciente= Paciente.find(params[:id])
  	end

  	#Trae la fichas segun la busqueda y página
	def get_fichas_psicopedagogicas
	    @search = FichaPsicopedagogica.ransack(params[:q])
	    @psicopedagogicas= @search.result.page(params[:page])
	end 

  	#Metodo creado para el filtro
	def buscar
	    @search = FichaPsicopedagogica.search(params[:q])
	    @psicopedagogicas = @search.result.page(params[:page])
	    render 'index'
  	end

  	def print_ficha
      @ficha = FichaPsicopedagogica.find params[:ficha_id]      
      respond_to do |format|
        format.pdf do
          render :pdf => "Ficha",
          :template => "fichas_psicopedagogicas/print_ficha.pdf.erb",
          :layout => "pdf.html"
        end
      end
    end

	def set_psicopedagogica
		@psicopedagogica = FichaPsicopedagogica.find(params[:id])
	end

	def psicopedagogica_params
		params.require(:ficha_psicopedagogica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha, :escolaridad, :escuela)
     				
  	end
end