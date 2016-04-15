class Empleado < ActiveRecord::Base
 	paginates_per 2
 	acts_as_paranoid
 	after_destroy :destroy_persona, :destroy_user
    
 	has_one :user
 	belongs_to :persona
 	accepts_nested_attributes_for :persona

 	has_one :horario

 	# Se elimina el registro de persona al eliminar el empleado
 	def destroy_persona
      persona.destroy
    end

    # Al borrar el empleado se borra su usuario del sistema
    def destroy_user
    	if !user.blank?	
      		user.destroy
      	end	
    end

    ransack_alias :persona, :persona_nombre_or_persona_apellido_or_persona_ci

end