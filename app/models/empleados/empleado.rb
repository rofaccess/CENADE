class Empleado < ActiveRecord::Base
 	acts_as_paranoid
 	after_destroy :destroy_persona
    
 	has_one :user
 	belongs_to :persona
 	accepts_nested_attributes_for :persona

 	has_one :horario
 	belongs_to :cargo

 	def destroy_persona
      persona.destroy
    end

end