class ConsultaOdontologica < ActiveRecord::Base

  paginates_per 20

  belongs_to :area
  belongs_to :paciente, -> { with_deleted }
  belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
  belongs_to :ficha_odontologica, :foreign_key => :ficha_odontologica_id

  #carga id area antes de guardar la consulta
  before_create :cargar_area_id

  #carga el area automaticamente
  def cargar_area_id
    area= Area.where(nombre: 'Odontología').first.id
    self.area_id= area
  end

  # Law of Demeter
  delegate :persona_nombre, :persona_apellido, :persona_full_name,
           :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
           :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :persona_estado_civil_descripcion,
           to: :paciente, prefix: true, allow_nil: true

  delegate :nombre, to: :area, prefix: true, allow_nil: true

  delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true
end
