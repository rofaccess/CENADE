class EmpleadosController < ApplicationController

	before_action :set_submenu, only: [:index,:new, :show]
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	#load_and_authorize_resource #Conflicto con check_ci
	respond_to :html, :js

	def set_submenu
		@submenu_layout = 'layouts/submenu_personal'
	end

	def index
		get_empleados
	end

	def new
    	@empleado = Empleado.new
    	@empleado.build_persona
  	end

  	#Setea un empleado  Funcionario o Doctor dependiendo de si tiene o no area
  	def set_empleado_per_type(empleado_params)
  		if empleado_params[:area_id].blank?
  			Funcionario.new(empleado_params)
  		else
  			Doctor.new(empleado_params)
  		end
    end

  	def create
	  	@empleado = set_empleado_per_type(empleado_params)
		respond_to do |format|
			if @empleado.save
				set_submenu
			    flash.now[:notice] = "Se ha guardado el empleado #{@empleado.persona_full_name}."
			    format.html {render 'show'}
			else
				set_submenu
				flash.now[:alert] = "No se ha podido guardar el empleado #{@empleado.persona_full_name}."
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
		respond_to do |format|
			if checkCurrentUserEmployee(@empleado)
	      		format.html { redirect_to empleados_path, flash: {alert: "No puedes eliminar tu propio registro de empleado"}}

			elsif @empleado.destroy
				format.html { redirect_to empleados_path, flash: {notice: "Se ha eliminado el empleado #{@empleado.persona_full_name}."}}
			else
			   	format.html { redirect_to empleados_path, flash: {alert: "No se ha podido eliminar el empleado #{@empleado.persona_full_name}."}}
			end
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
  		# //- También se puede imprimir una lista filtrada, no esta implementado
  		#@search = Empleado.ransack(params[:q])
  		#@empleados= @search.result
  		@empleados = Empleado.all

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
		@empleados= @search.result.page(params[:page])
    end

    def check_ci
    	persona = Persona.find_by_ci(params[:ci])

	    render json: (persona.nil? || persona.id == params[:id].to_i) ? true : "El número de CI especificado ya existe en el Sistema".to_json
    end

  	def empleado_params
      params.require(:empleado).permit(:cargo,:area_id,:type,:abr_profesion,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
    end

end
