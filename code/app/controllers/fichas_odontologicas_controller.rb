class FichasOdontologicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
	before_action :set_ficha, only: [:show, :edit, :update]
	before_action :set_consulta, only: [:show, :edit]
	before_action :set_Titulo, only: [:show, :create, :update, :edit, :new, :print_ficha]

	def set_Titulo
   	 @titulos_largos= TituloLargo.all
  	end

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

  	def set_ficha
	  	@ficha= FichaOdontologica.find(params[:id])
	  	@paciente = Paciente.find(@ficha.paciente_id)
  	end

  	def set_consulta
   	 @consultas= ConsultaOdontologica.where(ficha_odontologica_id: @ficha.id).limit(9).order(id: :desc)
 	end

	def new
		@ficha= FichaOdontologica.new
		get_doctores_odontologia

		# Para renderizar un formulario vacio de datos del paciente
		@paciente = Paciente.new
	end

	def create
		@ficha = FichaOdontologica.new(ficha_params)

		respond_to do |format|
			if @ficha.save
				format.html { redirect_to ficha_odontologica_path(@ficha), notice: 'Ficha registrada exitosamente'}
			else
				if @ficha.errors.full_messages.any?
					format.html { redirect_to new_ficha_odontologica_path(), notice: @ficha.errors.full_messages.first}
				else
					format.html { redirect_to new_ficha_odontologica_path(), notice: 'No se ha podido guardar la Ficha'}
				end
			end
		end
	end

	def destroy
		respond_to do |format|
			if @ficha.destroy
				format.html { redirect_to fichas_fonoaudiologicas_path, flash: {notice: "Se ha eliminado la ficha de #{@ficha.paciente.persona_full_name}."}}
			else
			   	format.html { redirect_to fichas_fonoaudiologicas_path, flash: {alert: "No se ha podido eliminar la ficha de #{@ficha.paciente.persona_full_name}."}}
			end
		end
	end

	def update
		respond_to do |format|
			if @ficha.update_attributes(ficha_params)
				format.html { redirect_to ficha_odontologica_path(@ficha), notice: 'Ficha actualizada exitosamente'}
			else

				if @ficha.errors.full_messages.any?
					format.html { redirect_to edit_ficha_odontologica_path(@ficha), notice: @ficha.errors.full_messages.first}
				else
					format.html { redirect_to edit_ficha_odontologica_path(@ficha), notice: 'No se ha podido actualizar la Ficha'}
				end
			end

		end
	end

	def index
		get_fichas
	end

	def edit
		get_doctores_odontologia
	end

	def get_doctores_odontologia
		area = Area.find_by_nombre('Odontología')
		@doctores = Doctor.where(area_id: area.id)
	end

  	def get_paciente
  		@paciente= Paciente.find(params[:id])

  	end

  	def check_paciente_has_ficha
  	ficha = FichaOdontologica.find_by_paciente_id(params[:paciente_id])
  	render json: (ficha.nil? || ficha.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
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

	def show

	end

	def print_ficha
  	@ficha = FichaOdontologica.find params[:ficha_id]
  	respond_to do |format|
  		format.pdf do
  			render :pdf => "Ficha",
  			:template => "fichas_odontologicas/print_ficha.pdf.erb",
  			:layout => "pdf.html"
  		end
  	end
  end

	def ficha_params
		params.require(:ficha_odontologica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha,:nombre_tutor,:tel_tutor)
    end
end
