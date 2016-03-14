class DoctoresController < EmpleadosController
	
	respond_to :html, :js
	
 	def update	
  		if empleado_params[:especialidad_id].blank?    
	    	@empleado.type = 'Funcionario'
	    else
	    	@empleado.type = 'Doctor'
	    end			
		if @empleado.update(empleado_params)
		    flash.notice= "Se ha actualizado el empleado #{@empleado.persona.nombre}
		    #{@empleado.persona.apellido} con Cédula Nº #{@empleado.persona.ci}."		    
		else
		    flash.alert = "No se ha podido actualizar el empleado #{@empleado.persona.nombre} 
		    #{@empleado.persona.apellido} con Cédula Nº #{@empleado.persona.ci}.."
		end 
		update_list  
  	end
  	
  	def funcionario_params
      params.require(:empleado).permit(:cargo_id,:especialidad_id,
      persona_attributes: [:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estad_civil,:direccion,:telefono,:email])
    end

end
