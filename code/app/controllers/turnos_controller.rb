class TurnosController < ApplicationController
 
  before_action :set_turno, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js 

  def index
  	@search = Turno.order(:fecha_expedicion).ransack(params[:q])
    @turnos= @search.result.page(params[:page])
  end

  def new
  	@turno= Turno.new
  end
  def create
  	@turno = Turno.new(turno_params)
  	 respond_to do |format|
      if @turno.save
        format.html { redirect_to turno_path(@turno.id), notice: 'Turno actualizado correctamente'}
      else
       
        flash.now[:alert] = "Ha ocurrido un error al registrar turno"
        format.html { render action: "new"}
      end
    end
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @turno.update_attributes(turno_params)

        format.html { redirect_to turno_path, notice: 'Turno actualizado correctamente'}
      else
        
        flash.now[:alert] = "Ha ocurrido un error al actualizar el turno"
        format.html { render action: "edit"}
      end
      
    end
  end

  def show

  end
  def destroy
    @turno.destroy
    respond_to do |format|
      format.html { redirect_to turnos_url }
      format.json { head :no_content }
    end
  end
  def set_turno
     @turno = Turno.find(params[:id])
  end

   def get_paciente
      @paciente= Paciente.find(params[:id])
      
    end

  def turno_params
      params.require(:turno).permit(:paciente_id, :fecha_expedicion, :fecha_consulta,
      	:area_id, :doctor_id, :estado, :monto, :paga, :nro_factura)
  end
end
