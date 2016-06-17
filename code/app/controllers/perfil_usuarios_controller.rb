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
		        redirect_to perfil_usuarios_edit_path, notice: t('messages.update_success', resource: 'el usuario')
	    	else
	    		redirect_to perfil_usuarios_edit_path, alert: t('messages.update_error', resource: 'el usuario', errors: @usuario.errors.full_messages.to_sentence)
	    	end

	end

	def usuario_params
      params.require(:user).permit(:username,:empleado_id, :rol, :password, :password_confirmation, :profile_foto, :direccion, :telefono, :email)

    end
end