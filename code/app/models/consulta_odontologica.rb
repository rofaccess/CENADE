class ConsultaOdontologica < ActiveRecord::Base
  belongs_to :area
  belongs_to :paciente
  belongs_to :doctor,    :foreign_key => :profesional_salud_id
  belongs_to :ficha_odontologica


  # Law of Demeter
  delegate :persona_nombre, :persona_apellido, :persona_full_name,
           :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
           :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :persona_estado_civil_descripcion,
           to: :paciente, prefix: true, allow_nil: true

  delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true
end
