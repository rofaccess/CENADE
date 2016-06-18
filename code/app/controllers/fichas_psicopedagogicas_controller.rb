class FichasPsicopedagogicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
	before_action :set_ficha, only: [:show, :edit, :update, :destroy]
	before_action :set_consulta, only: [:show, :edit]
	load_and_authorize_resource
	skip_load_resource :only => [:create]

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

  	def set_ficha
	  	@ficha= FichaPsicopedagogica.find(params[:id])
	  	@paciente = Paciente.find(@ficha.paciente_id)
  	end

  	def set_consulta
   	    @consultas= Consulta.where(area_id: @ficha.area_id, paciente_id: @ficha.paciente_id).limit(9).order(id: :desc)
  	end

	def new
		@ficha= FichaPsicopedagogica.new
		get_doctores_psicopedagogia

		# Para renderizar un formulario vacio de datos del paciente
		@paciente = Paciente.new
	end

	def show

	end

	def index
		get_fichas
	end

	def edit
		get_doctores_psicopedagogia
	end

		def create
		@ficha = FichaPsicopedagogica.new(psicopedagogica_params)

		respond_to do |format|
			if @ficha.save
				format.html { redirect_to ficha_psicopedagogica_path(@ficha), notice: 'Ficha registrada exitosamente'}
			else
				if @ficha.errors.full_messages.any?
					format.html { redirect_to new_ficha_psicopedagogica_path(), notice: @ficha.errors.full_messages.first}
				else
					format.html { redirect_to new_ficha_psicopedagogica_path(), notice: 'No se ha podido guardar la Ficha'}
				end
			end
		end
	end
 	def update
		respond_to do |format|
			if @ficha.update_attributes(psicopedagogica_params)
				format.html { redirect_to ficha_psicopedagogica_path(@ficha), notice: 'Ficha actualizada exitosamente'}
			else

				if @ficha.errors.full_messages.any?
					format.html { redirect_to edit_ficha_psicopedagogicaa_path(@ficha), notice: @ficha.errors.full_messages.first}
				else
					format.html { redirect_to edit_ficha_psicopedagogica_path(@ficha), notice: 'No se ha podido actualizar la Ficha'}
				end
			end

		end
	end

	def destroy
		respond_to do |format|
			if @ficha.destroy
				format.html { redirect_to fichas_psicopedagogica_path, flash: {notice: "Se ha eliminado la ficha de #{@ficha.paciente.persona_full_name}."}}
			else
			   	format.html { redirect_to fichas_psicopedagogica_path, flash: {alert: "No se ha podido eliminar la ficha de #{@ficha.paciente.persona_full_name}."}}
			end
		end
	end

  	def check_paciente_has_ficha
  		ficha = FichaPsicopedagogica.find_by_paciente_id(params[:paciente_id])
  	  render json: (ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente ya posee una Ficha".to_json
    end

 	def get_doctores_psicopedagogia
		area = Area.find_by_nombre('Psicopedagogía')
		@doctores = Doctor.where(area_id: area.id)
	end

  	def get_paciente
  		@paciente= Paciente.find(params[:id])

  	end

  	def get_fichas
	  	@search = FichaPsicopedagogica.search(params[:q])
	  	@fichas = @search.result.order('nro_ficha').page(params[:page])
 	 end

	# Metodo creado para el filtro
	def buscar
	  get_fichas
	  render 'index'
	end

  	def print_ficha
  		@ficha = FichaPsicopedagogica.find params[:ficha_id]
	  	respond_to do |format|
	  		format.pdf do
	  			render pdf: "Ficha",
	  			template: 	"fichas_psicopedagogicas/print_ficha.pdf.erb",
	  			layout: 	"pdf.html",
	  			title:    	'Ficha Psicopedagogía'
	  		end
	  	end
  	end


	def psicopedagogica_params
  		params.require(:ficha_psicopedagogica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha, :escolaridad, :escuela)

  	end
end