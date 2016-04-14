class Empleado < ActiveRecord::Base
 	paginates_per 2
 	acts_as_paranoid
 	after_destroy :destroy_persona
    
 	has_one :user
 	belongs_to :persona
 	accepts_nested_attributes_for :persona

 	has_one :horario

 	def destroy_persona
      persona.destroy
    end

    ransack_alias :persona, :persona_nombre_or_persona_apellido_or_persona_ci

end