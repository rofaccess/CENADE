class FichasFonoaudiologicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

	def index
		@search = FichaFonoaudiologica.ransack(params[:q])
    	@fonoaudiologicas= @search.result.page(params[:page])
	end

	def create
	  	@fonoaudiologica = FichaFonoaudiologica.new(fonoaudiologica_params)
		    respond_to do |format|
	     		if @fonoaudiologica.save
		        flash.now[:notice] = 'Ficha registrada exitosamente'
				    format.html {render 'show'}
	        else
		        flash.now[:alert] = "No se ha podido guardar la Ficha"
		        format.html { render "new"}
		        format.js { render "new"}
	      	end
   	  end
 	end
 	  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= Paciente.find(params[:paciente_id])
  
  end

    # Checkea que un paciente ya no tenga una ficha en Fonoaudiologia
  def check_paciente_id
    fonoaudiologica = FichaFonoaudiologica.find_by_paciente_id(params[:paciente_id])
      
    render json: (fonoaudiologica.nil? || fonoaudiologica.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end
 	
	def show

	end

	def new
		@fonoaudiologica= FichaFonoaudiologica.new

	end

	def edit

	end
	def fonoaudiologica_params
  		params.require(:fichas_fonoaudiologicas).permit(:area_id, :paciente_id, :doctor_id, :fecha, :escolaridad, :escuela)
     				
  	end 


end