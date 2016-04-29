class TurnosController < ApplicationController
 
  before_action :set_turno, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js 

  def index
  	 @search = Turno.ransack(params[:q])
      @turnos= @search.result.page(params[:page])
  end

  def new
  	@turno= Turno.new
  
  end
  def create
  	@turno = Turno.new(turno_params)

  	 respond_to do |format|
      if @turno.save
        format.html { redirect_to turno_path(@turno.id), notice: 'Turno registrado exitosamente'}
      else
        flash.now[:alert] = @turno.errors.full_messages.first
        @turno_nuevo= true
        format.html { render "new"}
        format.js { render "edit"}
      end
    end
  end

  def edit
    @turno_nuevo= nil
  end

  def update
  	respond_to do |format|
      if @turno.update_attributes(turno_params)

        format.html { redirect_to turno_path, notice: 'Turno actualizado exitosamente'}
      else
        
        flash.now[:alert] = @turno.errors.full_messages.first
        format.html { render action: "edit"}
        format.js { render action: "edit"}
      end
      
    end
  end
  def buscar
    @search = Turno.search(params[:q])
    @turnos = @search.result.page(params[:page])
    render 'index'
  end
  def show
    @empleado= Empleado.find(@turno.doctor_id)
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
  def print_turnos
      
      @turnos = Turno.all

      respond_to do |format|
        format.pdf do
          render :pdf => "Lista de Turnos",
                 :template => "turnos/print_turnos.pdf.erb",
                 :layout => "pdf.html"
          end
        end
    end
 
   def check_paciente
     turno= Turno.find_by(paciente_id: self.paciente_id, fecha_consulta: self.fecha_consulta, area_id: self.area_id)

      render json: (turno.nil? || turno.id == params[:id].to_i) ? true : "El paciente ya tiene un turno para el área y fecha".to_json       
    end 
   def get_paciente
      @paciente= Paciente.find(params[:id])
      
    end
    def update_profesional
    @area= Area.find(params[:id])
    render update_profesional, format: :js
  end
    def cambiar_estado

      @turno= Turno.find(params[:id])
      if (@turno.estado== 'pendiente')

        @turno.update_attribute(:estado, "cancelado")
        flash.now[:notice] = "Turno N° #{@turno.turno} cancelado"

      else
        flash.now[:alert] = "Turno N° #{@turno.turno} no se puede cancelar"
      end
      index
      render 'index'

    end 
    def get_turnos
      @search = Turno.ransack(params[:q])
      
      @turnos= @search.result.page(params[:page])
    end

  def turno_params
      params.require(:turno).permit(:paciente_id, :fecha_expedicion, :fecha_consulta,
      	:area_id, :doctor_id, :estado, :monto, :paga, :nro_factura)
  end
end
