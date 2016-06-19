class Empleado < ActiveRecord::Base
 	paginates_per 20
 	acts_as_paranoid

  #Asociaciones
 	has_one :user
 	belongs_to :persona, -> { with_deleted }
  belongs_to :area

  accepts_nested_attributes_for :persona

  # Validaciones
  validates :type, length: { maximum: Domain::TIPO_EMPLEADO }
  validates :cargo, length: { maximum: Domain::CARGO_EMPLEADO }
  validates :abr_profesion, length: { maximum: Domain::ABREVIATURA_PROFESION }


  #Callbacks
  after_destroy :destroy_persona, :destroy_user

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

  # Law of Demeter
	delegate :full_name, :nombre, :apellido, :ci,:ruc, :edad, :sexo, :nacionalidad,
           :fecha_nacimiento, :profesion, :telefono, :direccion, :fecha_ingreso,
           :estado_civil_descripcion,:estado_civil_id, :email,
           to: :persona, prefix: true, allow_nil: true

  delegate :nombre, :costo, to: :area, prefix: true, allow_nil: true
end