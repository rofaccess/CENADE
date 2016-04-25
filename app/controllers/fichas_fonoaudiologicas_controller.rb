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
		@search = FichasFonoaudiologica.ransack(params[:q])
    	@fonoaudiologicas= @search.result.page(params[:page])
	end

	def create
	  	@fonoaudiologica = FichasFonoaudiologica.new(fonoaudiologica_params)
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
 	
	def show

	end

	def new
		@fonoaudiologica= FichasFonoaudiologica.new

	end

	def edit

	end
	def fonoaudiologica_params
  		params.require(:fichas_fonoaudiologicas).permit(:area_id, :paciente_id, :escolaridad, :escuela)
     				
  	end 


end