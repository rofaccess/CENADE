class FichasFisioterapeuticasAdultosController < ApplicationController
	before_action :set_submenu, only: [:edit, :new, :show, :index, :test]
	before_action :set_sidebar, only: [:edit, :new, :show, :index, :test]
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
	  	@ficha= FichaFisioterapeuticaAdulto.find(params[:id])
	  	@paciente = Paciente.find(@ficha.paciente_id)
  	end

	def index
		get_fichas
	end

	def new
		@ficha= FichaFisioterapeuticaAdulto.new
		get_doctores_fisioterapia

		# Para renderizar un formulario vacio de datos del paciente
		@paciente = Paciente.new
	end

	def create
		@ficha = FichaFisioterapeuticaAdulto.new(ficha_params)

		respond_to do |format|
			if @ficha.save
				format.html { redirect_to ficha_fisioterapeutica_adulto_path(@ficha), notice: t('messages.save_success', resource: 'la ficha')}
			else
				flash.now[:alert] = t('messages.save_error', resource: 'la ficha', errors: @ficha.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to new_ficha_fisioterapeutica_adulto_path, alert: flash.now[:alert]}
			end
		end
	end

	def edit
		get_doctores_fisioterapia
	end

	def update
		respond_to do |format|
			if @ficha.update_attributes(ficha_params)
				format.html { redirect_to ficha_fisioterapeutica_adulto_path(@ficha), notice: t('messages.update_success', resource: 'la ficha')}
			else
        flash.now[:alert] = t('messages.update_error', resource: 'la ficha', errors: @ficha.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_ficha_fisioterapeutica_adulto_path(@ficha), alert: flash.now[:alert]}
			end

		end
	end

	def show
	end

	def destroy
		respond_to do |format|
			if @ficha.destroy
        format.html { redirect_to fichas_fisioterapeuticas_adultos_path, notice: t('messages.delete_success', resource: 'la ficha')}
      else
          format.html { redirect_to fichas_fisioterapeuticas_adultos_path, alert: t('messages.delete_error', resource: 'la ficha', errors: @ficha.errors.full_messages.to_sentence)}
      end
		end
	end

  def check_paciente_has_ficha
  	ficha = FichaFisioterapeuticaAdulto.find_by_paciente_id(params[:paciente_id])

    render json: (ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  def get_doctores_fisioterapia
		area = Area.find_by_nombre('Fisioterapia')
		@doctores = Doctor.where(area_id: area.id)
	end

  def get_paciente
  	@paciente= Paciente.find(params[:id])

  end

  def get_fichas
  	@search = FichaFisioterapeuticaAdulto.search(params[:q])
  	@fichas = @search.result.order('nro_ficha').page(params[:page])
  end

  # Metodo creado para el filtro
  def buscar
  	get_fichas
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
  			render pdf: "Ficha",
  			template: 	"fichas_fisioterapeuticas_adultos/print_ficha.pdf.erb",
  			layout: 	"pdf.html",
  			title:    	'Ficha de Fisioterapia Adulto',
	        footer: {
			    center: '[page] de [topage]',
			    right: 	"#{Formatter.format_datetime(Time.now)}",
			    left: 	"CI Nº: #{@ficha.paciente_persona_ci}"
			}
  		end
  	end
  end

  def set_consulta
    @consultas= Consulta.where(area_id: @ficha.area_id, paciente_id: @ficha.paciente_id).limit(9).order(id: :desc)
  end

  def ficha_params
  	params.require(:ficha_fisioterapeutica_adulto).permit(:area_id, :paciente_id, :doctor_id, :encargado, :medicamentos,
  		:antecedente_actual, :antecedente_hereditario, :condicion_paciente, :fecha, :nro_ficha)
  end
end
