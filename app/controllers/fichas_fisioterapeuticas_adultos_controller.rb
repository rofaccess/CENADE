class FichasFisioterapeuticasAdultosController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index, :test]
	before_action :set_sidebar, only: [:edit, :new, :show, :index, :test]
	before_action :set_fisioadulto, only: [:show, :edit, :update, :destroy]

	def set_submenu
		@submenu_layout = 'layouts/submenu_fichas_consultas'
	end

	def set_sidebar
		@sidebar_layout = 'layouts/sidebar_fichas'
	end

	def index
		@search = FichaFisioterapeuticaAdulto.ransack(params[:q])
		@fisio_adultos= @search.result.page(params[:page])
	end

	def new
		@fisio_adulto= FichaFisioterapeuticaAdulto.new
		get_doctores_fisioterapia
		@paciente = Paciente.find(1)
	end

	def get_doctores_fisioterapia
		area = Area.find_by_nombre('Fisioterapia')
		@doctores = Doctor.where(area_id: area.id)
	end	

	def create
		@fisio_adulto = FichaFisioterapeuticaAdulto.new(fisio_adulto_params)

		respond_to do |format|
			if @fisio_adulto.save
				flash.now[:notice] = 'Ficha registrada exitosamente'
				format.html {render 'show'}
				format.js { render "show"}
			else
				if @fisio_adulto.errors.full_messages.any?
					flash.now[:alert] = @fisio_adulto.errors.full_messages.first
				else
					flash.now[:alert] = "No se ha podido guardar la Ficha"
				end
				@fisio_adulto_nuevo= true
				format.html { render "edit"}
				format.js { render "edit"}

			end
		end
	end

	def edit
		@fisio_adulto_nuevo= nil
	end

	def update
		respond_to do |format|
			if @fisio_adulto.update_attributes(fisio_adulto_params)

				format.html { redirect_to fichas_fisioterapeuticas_adultos_path, notice: 'Ficha actualizado exitosamente'}
			else

				if @fisio_adulto.errors.full_messages.any?
					flash.now[:alert] = @fisio_adulto.errors.full_messages.first
				else
					flash.now[:alert] = "No se ha podido guardar la Ficha"
				end
				format.html { render action: "edit"}
				format.js { render action: "edit"}
			end

		end
	end

	def show

	end
  # Checkea que un paciente ya no tenga una Ficha de Fisioterapia Adulto
  def check_paciente_id
  	fisio_adulto = FichaFisioterapeuticaAdulto.find_by_paciente_id(params[:paciente_id])

  	render json: (fisio_adulto.nil? || fisio_adulto.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  # Busca el paciente seleccionado en la base de datos
  def get_paciente
  	@paciente= Paciente.find(params[:id])

  end

  # Metodo creado para el filtro
  def buscar
  	@search = FichaFisioterapeuticaAdulto.search(params[:q])
  	@fisio_adultos = @search.result.page(params[:page])
  	render 'index'
  end

  # Método para testear el select 2
  def test
  	new 	
  end

  def print_ficha
  	@ficha = FichaFisioterapeuticaAdulto.find params[:ficha_id]      
  	respond_to do |format|
  		format.pdf do
  			render :pdf => "Ficha",
  			:template => "fichas_fisioterapeuticas_adultos/print_ficha.pdf.erb",
  			:layout => "pdf.html"
  		end
  	end
  end

  def set_fisioadulto
  	@fisio_adulto= FichaFisioterapeuticaAdulto.find(params[:id])
  end 

  def fisio_adulto_params
  	params.require(:ficha_fisioterapeutica_adulto).permit(:area_id, :paciente_id, :doctor_id, :encargado, :medicamentos,
  		:antecedente_actual, :antecedente_hereditario, :condicion_paciente, :fecha, :nro_ficha)
  end 
end
