class PerfilUsuariosController < ApplicationController

	

	def edit
		@persona = Persona.find(Empleado.find(current_user.empleado_id).persona_id)
	end

	def update
		@usuario = User.find(current_user.id)
		@usuario_u = usuario_params.except(:direccion, :telefono, :email)
		@persona = Persona.find(Empleado.find(@usuario.empleado_id).persona_id)
		@persona_u = usuario_params.slice(:direccion, :telefono, :email)
		if usuario_params[:password].blank?
			@usuario_u = usuario_params.except(:direccion, :telefono, :email,:password,:password_confirmation)
		end

			if @usuario.update(@usuario_u) && @persona.update(@persona_u)      
		        flash.now[:notice] = "Se ha actualizado el usuario #{@usuario.username}."   
	    	else
		        flash.now[:alert] = "No se ha podido actualizar el usuario #{@usuario.username}."
	    	end 
	    	render action: 'edit'


	end

	def usuario_params
      params.require(:user).permit(:username,:empleado_id, :rol, :password, :password_confirmation, :profile_foto, :direccion, :telefono, :email)
      
    end
end