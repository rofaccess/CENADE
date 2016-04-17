class Paciente < ActiveRecord::Base
	paginates_per 10
	acts_as_paranoid

	# Despues de borrar el registro de paciente, se ejecutan estos métodos
	after_destroy :destroy_persona, :destroy_encargado

	has_many :turnos
	belongs_to :persona
	belongs_to :encargado

	# Permiten guardar persona y encargado en el formulario de paciente
	accepts_nested_attributes_for :persona
	accepts_nested_attributes_for :encargado

	# Se elimina el registro de persona al eliminar el paciente
	def destroy_persona
      persona.destroy
    end

    # Se elimina el registro de encargado al eliminar el paciente
	def destroy_encargado
      if !encargado.blank?
      	encargado.destroy
      end	
    end

	ransack_alias :persona, :persona_nombre_or_persona_apellido_or_persona_ci
end
