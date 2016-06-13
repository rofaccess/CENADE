class DoctoresController < EmpleadosController

 	def update
   respond_to do |format|
      if @empleado.update(empleado_params)
        flash.now[:notice] = "Se ha actualizado el empleado #{@empleado.persona_full_name}."
        format.html {render 'show'}
      else
        flash.now[:alert] = "No se ha podido actualizar los datos del empleado #{@empleado.persona_full_name}."
        format.html { render "new"}
      end
    end
  end

  def set_empleado
  	super
  end

  # Buscador de doctores
  def buscar
    @search = Doctor.ransack(params[:q])
    @doctores= @search.result.includes(:persona).order('personas.nombre')
    render json: {items: @doctores.as_json(:only => [:id],
                                              :methods => [:full_name, :area_nombre],
                                            )}
  end

  def empleado_params
      params.require(:doctor).permit(:cargo,:area_id,:type,:abr_profesion,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
                           :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
   end
end