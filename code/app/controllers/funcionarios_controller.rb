class FuncionariosController < EmpleadosController		
 	
 	def update
    respond_to do |format|
      if @empleado.update(empleado_params)
          flash.notice= "Se ha actualizado el empleado #{@empleado.persona.nombre}
          #{@empleado.persona.apellido}." 
          format.js {render action: "show"}    
      else
          flash.alert = "No se ha podido actualizar el empleado #{@empleado.persona.nombre} 
          #{@empleado.persona.apellido}."
          format.html { redirect_to empleados_path}  
          # Lo ideal es mostrar el mensaje en el mismo formulario 
      end 
    end  
  end
  	
  def set_empleado
  	super
   end

  def empleado_params
      params.require(:funcionario).permit(:cargo,:area_id, :costo,:type,:abr_profesion,
      persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
                           :sexo,:estado_civil_id,:direccion,:telefono,:email,:nacionalidad])
   end   
end
