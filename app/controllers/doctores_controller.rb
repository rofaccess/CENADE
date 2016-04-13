class DoctoresController < EmpleadosController		
 	
 	def update
    if @empleado.update(empleado_params)
        flash.notice= "Se ha actualizado el empleado #{@empleado.persona.nombre}
        #{@empleado.persona.apellido}."       
    else
        flash.alert = "No se ha podido actualizar el empleado #{@empleado.persona.nombre} 
        #{@empleado.persona.apellido}."
    end 
    update_list   
  end
  	
  def set_empleado
  	super
  end

  def empleado_params
      params.require(:doctor).permit(:cargo,:especialidad_id,:type,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estado_civil_id,:direccion,:telefono,:email])
   end   
end