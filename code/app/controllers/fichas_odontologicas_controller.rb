class FichasOdontologicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
	before_action :set_odontologica, only: [:show, :edit, :update, :destroy]

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

  	def set_odontologica
	  	@ficha= FichaOdontologica.find(params[:id])
	  	@paciente = Paciente.find(@ficha.paciente_id)
  	end
	def index
		get_fichas
	end

	def get_doctores_odontologia
		area = Area.find_by_nombre('Odontología')
		@doctores = Doctor.where(area_id: area.id)
	end	

  	def get_paciente
  		@paciente= Paciente.find(params[:id])

  	end

	def get_fichas
	  	@search = FichaOdontologica.search(params[:q])
	  	@fichas = @search.result.order('nro_ficha').page(params[:page])
    end	

	# Metodo creado para el filtro
	def buscar
	  	get_fichas
	  	render 'index'
	end

	def new

	end

	def edit

	end

	def show
	  	
	end

	def odontologica_params
		params.require(ficha_odontologica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha,:nombre_tutor,:tel_tutor,:profesion_tutor)
    end
end
