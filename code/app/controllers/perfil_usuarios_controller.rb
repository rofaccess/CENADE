class PerfilUsuariosController < ApplicationController

	respond_to :html, :js

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
		respond_to do |format|
			if @usuario.update(@usuario_u) && @persona.update(@persona_u)      
		        format.html { redirect_to perfil_usuarios_edit_path, flash: {notice: "Se ha actualizado el usuario #{@usuario.empleado.persona.nombre}
		        #{@usuario.id}."}}     
	    	else
		        flash.alert = "No se ha podido actualizar el usuario #{@usuario} 
		        #{@usuario.id}."
		        format.html { render action: "edit"}
	    	end 
	    end

	end

	def usuario_params
      params.require(:user).permit(:username,:empleado_id, :rol, :password, :password_confirmation, :profile_foto, :direccion, :telefono, :email)
      
    end
end