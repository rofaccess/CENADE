class EmpleadosController < ApplicationController
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	# except: :create evita una falla cuando hay error al crear
  load_and_authorize_resource except: :create
	respond_to :html, :js

	def index
		get_empleados
	end

	def new
    @empleado = Empleado.new
    @empleado.build_persona
  end

  def create
    @empleado = Empleado.new(empleado_params)
		respond_to do |format|
			if @empleado.save
			  flash.now[:notice] = t('messages.save_success', resource: 'el empleado')
			  format.html {render 'show'}
			else
				flash.now[:alert] = t('messages.save_error', resource: 'el empleado', errors: @empleado.errors.full_messages.to_sentence)
       	format.html { render "new"}
			end
		end
  end

  def edit
 	end

 	def update
  end

  def show
  end

  def destroy
		if checkCurrentUserEmployee(@empleado)
	     redirect_to empleados_path, alert: "No puedes eliminar tu propio registro de empleado"
		elsif @empleado.destroy
      redirect_to empleados_path, notice: t('messages.delete_success', resource: 'el empleado')
    else
      redirect_to empleados_path, alert: t('messages.delete_error', resource: 'el empleado', errors: @empleado.errors.full_messages.to_sentence)
    end
	end

  	# Si el registro de empleado que se intenta borrar corresponde al
  	# usuario actual, no se lo permite.
  	def checkCurrentUserEmployee(empleado)
  		if current_user.empleado_id == empleado.id
  			return true
  		end
  	end

  	def print_empleado
  		@empleado = Empleado.find params[:empleado_id]
	    respond_to do |format|
	      format.pdf do
	        render pdf: 	 'Registro de Empleado',
	               template: 'empleados/print_empleado.pdf.erb',
	               layout:   'pdf.html',
	               title:    'Registro de Paciente',
	               footer: {
			            center: '[page] de [topage]',
			            right: "#{Formatter.format_datetime(Time.now)}",
			            left: "CI Nº: #{@empleado.persona_ci}"
			        }
      		end
      	end
    end

    def print_empleados
  		get_empleados

	    respond_to do |format|
	      format.pdf do
	        render pdf:         'Lista de Empleados',
	               template:    'empleados/print_empleados.pdf.erb',
	               layout:      'pdf.html',
	               orientation: 'Landscape',
			       title:       'Lista de Empleados',
			       footer: {
			       		center: '[page] de [topage]',
			            right: "#{Formatter.format_datetime(Time.now)}"
			       }
      		end
      	end
    end

  	def set_empleado
      @empleado = Empleado.find(params[:id])
    end

    def get_empleados
    	@search = Empleado.ransack(params[:q])
		  @empleados= @search.result
                         .includes(:persona)
                         .order('personas.nombre')
                         .page(params[:page])
    end

    def check_ci
    	persona = Persona.find_by_ci(params[:ci])

	    render json: (persona.nil? || persona.id == params[:idd].to_i) ? true : "El número de CI especificado ya existe en el Sistema".to_json
    end

  	def empleado_params
      params.require(:empleado).permit(:cargo,:area_id,:type,:abr_profesion,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
    end

end
