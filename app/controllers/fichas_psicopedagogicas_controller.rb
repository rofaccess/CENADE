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

  	def new
		@psicopedagogica= FichaPsicopedagogica.new
	end

	def show
	end

	def edit
	end

	def set_psicopedagogica
		@psicopedagogica = FichaPsicopedagogica.find(params[:id])
	end

	def psicopedagogica_params
		params.require(:ficha_psicopedagogica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha, :escolaridad, :escuela)
     				
  	end
end