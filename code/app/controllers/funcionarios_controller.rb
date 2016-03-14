class FuncionariosController < EmpleadosController	
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	respond_to :html, :js
	
	def edit		
	end
 	
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
  	
  	def set_empleado
      @empleado = Funcionario.find(params[:id])
    end

  	def empleado_params
      params.require(:funcionario).permit(:cargo_id,:especialidad_id,
      persona_attributes: [:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
      	                   :sexo,:estad_civil,:direccion,:telefono,:email])
    end   
end
