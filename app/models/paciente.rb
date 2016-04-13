class Paciente < ActiveRecord::Base
	paginates_per 1
	acts_as_paranoid

	has_many :turnos
	belongs_to :persona

	accepts_nested_attributes_for :persona

	def destroy_persona
      persona.destroy
    end

	ransack_alias :persona, :persona_nombre_or_persona_apellido_or_persona_ci
end
