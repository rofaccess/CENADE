class FichasPediatricasController < ApplicationController
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
	  	@ficha= FichaPediatrica.find(params[:id])
	  	@paciente = Paciente.find(@ficha.paciente_id)
  	end

	def index
		get_fichas
	end

	def new
		@ficha= FichaPediatrica.new
		get_doctores_pediatria

		# Para renderizar un formulario vacio de datos del paciente
		@paciente = Paciente.new
	end

	def create
		@ficha = FichaPediatrica.new(ficha_params)

		respond_to do |format|
			if @ficha.save
				format.html { redirect_to ficha_pediatrica_path(@ficha), notice: t('messages.save_success', resource: 'la ficha')}
			else
				flash.now[:alert] = t('messages.save_error', resource: 'la ficha', errors: @ficha.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to new_ficha_pediatrica_path, alert: flash.now[:alert]}
			end
		end
	end

	def edit
		get_doctores_pediatria
	end

	def update
		respond_to do |format|
			if @ficha.update_attributes(ficha_params)
				format.html { redirect_to ficha_pediatrica_path(@ficha), notice: t('messages.update_success', resource: 'la ficha')}
			else
        flash.now[:alert] = t('messages.update_error', resource: 'la ficha', errors: @ficha.errors.full_messages.to_sentence)
        format.js {render 'compartido/show_message'}
        format.html{redirect_to edit_ficha_pediatrica_path(@ficha), alert: flash.now[:alert]}
			end
		end
	end

	def show

	end

	def destroy
		respond_to do |format|
			if @ficha.destroy
        format.html { redirect_to fichas_pediatricas_path, notice: t('messages.delete_success', resource: 'la ficha')}
      else
        format.html { redirect_to fichas_pediatricas_path, alert: t('messages.delete_error', resource: 'la ficha', errors: @ficha.errors.full_messages.to_sentence)}
      end
		end
	end

  def check_paciente_has_ficha
  	ficha = FichaPediatrica.find_by_paciente_id(params[:paciente_id])
    render json: (ficha.nil? || ficha.id == params[:idd].to_i) ? true : "El Paciente ya posee una Ficha".to_json
  end

  def get_doctores_pediatria
		area = Area.find_by_nombre('Pediatría')
		@doctores = Doctor.where(area_id: area.id)
	end

  def get_paciente
  	@paciente= Paciente.find(params[:id])

  end

  def get_fichas
  	@search = FichaPediatrica.search(params[:q])
  	@fichas = @search.result.order('nro_ficha').page(params[:page])
  end

  # Metodo creado para el filtro
  def buscar
  	get_fichas
  	render 'index'
  end

  def print_ficha
  	@ficha = FichaPediatrica.find params[:ficha_id]
  	respond_to do |format|
  		format.pdf do
  			render pdf: "Ficha",
  			template: 	"fichas_pediatricas/print_ficha.pdf.erb",
  			layout: 	"pdf.html",
  			title:    	'Ficha de Pediatría',
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
  	params.require(:ficha_pediatrica).permit(:area_id, :paciente_id, :doctor_id, :fecha, :nro_ficha,
  		:p,:a,:pc1,:pt1,:pa,:control,:gestacion,:paridad,:abortos,:nacidos_muertos,:partos_anteriores,
  		:gru_san_paciente, :rh_paciente,:coombs,:gru_san_padre,:rh_padre,:fum,:fp,:duracion,:riesgos,
  		:tipo_parto,:anestesia,:analgesia,:neonatal_cianosis,:ictericia_antes,:ictericia_despues,
  		:apgar,:peso1,:talla1,:pc2,:tp,:fontanela,:dubowitz,:parkin,:gru_san2,:rh2,:medicacion,:ccu,
  		:tiempo_internacion,:alta,:peso2,:talla2,:pb,:pt1,:alimentacion_natural,:duracion,
  		:alimentacion_artificial,:bcg,:antisarampionosa,:antigripal,:mmr,:dpt,:dpt1,:dpt2,:dpt3,
  		:dpt_ref1,:dpt_ref2,:dpt_ref3,:dpt_ref4,:sabin,:sabin1,:sabin2,:sabin3,:sabin_ref1,:sabin_ref2,:sabin_ref3,
  		:sabin_ref4,:otras,:app,:apf,:edad_mental,:dpt2,:epl,:dpm,:tto_ant,:epl,:sosten_cefalico,:sedentacion,
  		:mancha)
  end
end
