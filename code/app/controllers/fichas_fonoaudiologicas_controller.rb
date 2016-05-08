class FichasFonoaudiologicasController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index]
	before_action :set_sidebar, only: [:edit, :new, :show, :index]
	before_action :set_ficha, only: [:show, :edit, :update, :destroy]

	def set_submenu
  		@submenu_layout = 'layouts/submenu_fichas_consultas'
  	end

  	def set_sidebar
   		@sidebar_layout = 'layouts/sidebar_fichas'
  	end

  	def set_ficha
	  	@ficha= FichaFonoaudiologica.find(params[:id])
	  	@paciente = Paciente.find(@ficha.paciente_id)
  	end

	def new
		@ficha= FichaFonoaudiologica.new
		get_doctores_fonoaudiologia

		# Para renderizar un formulario vacio de datos del paciente
		@paciente = Paciente.new
	end

	def show

	end

	def index
		get_fichas
	end

	def edit
		get_doctores_fonoaudiologia
	end

		def create
		@ficha = FichaFonoaudiologica.new(fonoaudiologica_params)

		respond_to do |format|
			if @ficha.save
				format.html { redirect_to ficha_fonoaudiologica_path(@ficha), notice: 'Ficha registrada exitosamente'}
			else
				if @ficha.errors.full_messages.any?
					format.html { redirect_to new_ficha_fonoaudiologica_path(), notice: @ficha.errors.full_messages.first}
				else
					format.html { redirect_to new_ficha_fonoaudiologica_path(), notice: 'No se ha podido guardar la Ficha'}
				end
			end
		end
	end
 	def update
		respond_to do |format|
			if @ficha.update_attributes(fonoaudiologica_params)
				format.html { redirect_to ficha_fonoaudiologica_path(@ficha), notice: 'Ficha actualizada exitosamente'}
			else

				if @ficha.errors.full_messages.any?
					format.html { redirect_to edit_ficha_fonoaudiologica_path(@ficha), notice: @ficha.errors.full_messages.first}
				else
					format.html { redirect_to edit_ficha_fonoaudiologica_path(@ficha), notice: 'No se ha podido actualizar la Ficha'}
				end
			end

		end
	end


  	def check_paciente_has_ficha
  		ficha = FichaFonoaudiologica.find_by_paciente_id(params[:paciente_id])
  		render json: (ficha.nil? || ficha.id == params[:id].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  	end

 	def get_doctores_fonoaudiologia
		area = Area.find_by_nombre('Fonoaudiología')
		@doctores = Doctor.where(area_id: area.id)
	end

  	def get_paciente
  		@paciente= Paciente.find(params[:id])

  	end

  	def get_fichas
	  	@search = FichaFonoaudiologica.search(params[:q])
	  	@fichas = @search.result.order('nro_ficha').page(params[:page])
 	 end

	# Metodo creado para el filtro
	def buscar
	  get_fichas
	  render 'index'
	end

  	def print_ficha
  	@ficha = FichaFonoaudiologica.find params[:ficha_id]
  	respond_to do |format|
  		format.pdf do
  			render pdf: "Ficha",
  			template: 	"fichas_fonoaudiologicas/print_ficha.pdf.erb",
  			layout: 	"pdf.html",
  			title:    	'Ficha de Fonoaudiología',
	        footer: {
			    center: '[page] de [topage]',
			    right: 	"#{Formatter.format_datetime(Time.now)}",
			    left: 	"CI Nº: #{@ficha.paciente_persona_ci}"
			}
  		end
  	end
  end


	def fonoaudiologica_params
  		params.require(:ficha_fonoaudiologica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha, :escolaridad, :escuela)

  	end
end