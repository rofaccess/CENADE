class FichasNutricionalesPediatricasController < ApplicationController

  before_action :set_submenu, only: [:edit, :new, :show, :index]
  before_action :set_sidebar, only: [:edit, :new, :show, :index]
  before_action :set_ficha_nutri_pediatrica, only: [:show, :edit, :update, :destroy]

  def set_submenu
  	@submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
   	@sidebar_layout = 'layouts/sidebar_fichas'
  end

  def index
  	@search = FichaNuricionalPediatrica.ransack(params[:q])
    @nutri_pediatricas= @search.result.page(params[:page])
  end

  def new
  	@nutri_pediatrica= FichaNuricionalPediatrica.new
  	get_doctores_nutricion
  end

  def create
  	@nutri_pediatrica = FichaNuricionalPediatrica.new(nutri_pediatrica_params)
  
  	 respond_to do |format|
      if @nutri_pediatrica.save
        flash.now[:notice] = 'Ficha registrada exitosamente'
		format.html {render 'show'}
        format.js { render "show"}
      else
        if @nutri_pediatrica.errors.full_messages.any?
          flash.now[:alert] = @nutri_pediatrica.errors.full_messages.first
        else
          flash.now[:alert] = "No se ha podido guardar la Ficha"
        end
        
        format.html { render "edit"}
        format.js { render "edit"}

      end
    end
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @nutri_pediatrica.update_attributes(nutri_pediatrica_params)
	    flash.now[:notice] = 'Ficha actualizada exitosamente'
		format.html {render 'show'}
	    format.js { render "show"}
      else
        
        if @nutri_pediatrica.errors.full_messages.any?
          flash.now[:alert] = @nutri_pediatrica.errors.full_messages.first
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

  def get_doctores_nutricion
	@area = Area.find_by_nombre('Nutrición')
	@doctores = Doctor.where(area_id: @area.id)
  end

  #busca el paciente seleccionado en la base de datos
  def get_paciente
    @paciente= Paciente.find(params[:id])    
  end

  #metodo creado para el filtro
  def buscar
    @search = FichaNuricionalPediatrica.search(params[:q])
    @nutri_pediatricas = @search.result.page(params[:page])
    render 'index'
  end

  def set_ficha_nutri_pediatrica
  	@nutri_pediatrica= FichaNuricionalPediatrica.find(params[:id])
  end

  def nutri_pediatrica_params
  	params.require(:ficha_nutricional_pediatrica).permit(:area_id, :paciente_id, :profesional_salud_id, :fecha, :nro_ficha, 
  		 :problema_embarazo,:control_prenatal,:alimentacion_embarazo,:otros_datos,:parto_vaginal_cesarea, :termino_pretermino, 
  		 :lugar_parto,:como_fue_parto, :peso_nacimiento, :asfixia_lloro, :tomo_pecho, :alimentacion_complementaria, :sosten_cefalico, 
  		 :sento, :paro,:camino, :sigue_luz, :habilidades, :mastica_deglute, :otros, :desayuno, :media_manana, :almuerzo, 
  		 :merienda, :cena, :cargo_quien, :diarrea, :vomitos, :fiebre, :constipacion, :orina, :sudor, :problemas_respiratorios, 
  		 :distension_abdominal, :otros2, :diagnostico, :peso, :talla, :pc, :imc, :cm, :evaluacion, :indicaciones)
  end
end
