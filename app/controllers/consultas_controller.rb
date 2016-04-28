class ConsultasController < ApplicationController
	before_action :set_consulta, only: [:show, :edit, :update]
	#load_and_authorize_resource 
	respond_to :html, :js


  def index
  	get_consultas
  end

  def new
  	@consulta= Consulta.New
  end

  def create
  	respond_to do |format|

		@consulta = Consulta.new(consulta_params)       
		if @paciente.save		    
			flash.now[:notice] = "Se ha guardado la consulta de #{@paciente.persona.nombre}."
			format.html {render 'show'}
		else
			flash.now[:alert] = "No se ha podido guardar la Consulta."
			format.html { render action: "new"}	
		end 
	end
  end

  def edit

  end

  def update
  	respond_to do |format|       
   		if @consulta.update(consulta_params)
   			flash.now[:notice] = "Se ha actualizado la consulta de #{@paciente.persona.nombre}."
   			format.html {render 'show'}   
   		else
   			flash.now[:alert] = "No se ha podido actualizar la consulta."
   			format.html { render action: "edit"}        
   		end 
   	end 

  end

  def show

  end

  def set_consulta
  	@consulta = Consulta.find(params[:id])
  end

  def get_consultas
      @search = Consulta.ransack(params[:q])
      
      @consultas= @search.result.page(params[:page])
    end

  #Busca las Consultas segun los datos puestos para filtrar
  def buscar
    @search = Consulta.search(params[:q])
    @consultas = @search.result.page(params[:page])
    render 'index'
  end

  def consulta_params
      params.require(:consulta).permit(:paciente_id, :area_id, :profesional_salud_id, :fecha, 
      									:motivo_consulta, :evaluacion, :tratamiento, :observaciones)
  end
end
