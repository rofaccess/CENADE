class FuncionariosController < EmpleadosController

  def index
    super
  end

  def create
    super
  end

  def update
    respond_to do |format|
      if @empleado.update(empleado_params)
        flash.now[:notice] = t('messages.update_success', resource: 'el empleado')
        format.html {render 'show'}
      else
        flash.now[:alert] = t('messages.update_error', resource: 'el empleado', errors: @empleado.errors.full_messages.to_sentence)
        format.html { render "new"}
      end
    end
  end

  def set_empleado
  	super
   end

  def empleado_params
      params.require(:funcionario).permit(:cargo,:area_id,:type,:abr_profesion,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
                           :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
   end
end
