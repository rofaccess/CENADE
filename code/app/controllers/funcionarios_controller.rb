class FuncionariosController < EmpleadosController		
 	
 	def update	
 		super
  	end
  	
  	def set_empleado
  		super
    end

  	def empleado_params
       params.require(:funcionario).permit(:cargo_id,:especialidad_id,
       persona_attributes: [:id,:nombre,:apellido,:ci,:ruc,:fecha_nacimiento,:edad,
       	                   :sexo,:estado_civil_id,:direccion,:telefono,:email])
    end   
end
