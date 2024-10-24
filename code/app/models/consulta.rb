class Consulta < ActiveRecord::Base
 	paginates_per 20

 	#asociaciones
 	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
 	belongs_to :paciente, -> { with_deleted },:foreign_key => :paciente_id
 	belongs_to :area

 	#validaciones
  validates :paciente, presence: true
  validates :doctor, presence: true
  validates :fecha, presence: true, date_less_system_date: true

 	validates :tratamiento , length: { maximum: Domain::DESC600, message: ' soporta un máximo de 600 caracteres' }
 	validates :evaluacion , length: { maximum: Domain::DESC300, message: ' soporta un máximo de 300 caracteres' }
 	validates :motivo_consulta, length: { maximum: Domain::DESC300, message: ' soporta un máximo de 300 caracteres' }
 	validates :observaciones, length: { maximum: Domain::DESC250, message: ' soporta un máximo de 250 caracteres' }
  validate  :paciente_has_not_ficha

  def paciente_has_not_ficha
    if Consulta.get_ficha(area.nombre, paciente.id).nil?
      errors.add(:base, I18n.t('activerecord.errors.messages.paciente_has_not_ficha'))
    end
  end

  # Obtiene la ficha del area correspondiente
  def self.get_ficha(area_nombre, paciente_id)
    case area_nombre
    when "Clínico"
      FichaClinico.find_by_paciente_id(paciente_id)
    when "Fisioterapia"
      ficha_ped = FichaFisioterapiaNino.find_by_paciente_id(paciente_id)
      ficha_ad = FichaFisioterapeuticaAdulto.find_by_paciente_id(paciente_id)
      if ficha_ped.blank?
        ficha_ad
      else
        ficha_ped
      end
    when "Fonoaudiología"
      FichaFonoaudiologica.find_by_paciente_id(paciente_id)
    when "Neurología"
      FichaNeurologica.find_by_paciente_id(paciente_id)
    when "Nutrición Adulto"
        FichaNutricionalAdulto.find_by_paciente_id(paciente_id)
    when "Nutrición Pediatría"
      FichaNutricionalPediatrica.find_by_paciente_id(paciente_id)
    when "Odontología"
      FichaOdontologica.find_by_paciente_id(paciente_id)
    when "Pediatría"
      FichaPediatrica.find_by_paciente_id(paciente_id)
    when "Psicopedagogía"
      FichaPsicopedagogica.find_by_paciente_id(paciente_id)
    else
    end
  end

 	# Law of Demeter
	delegate :persona_nombre, :persona_apellido, :persona_estado_civil_descripcion, :persona_full_name,
			 :persona_edad,:persona_sexo, :persona_ci, :persona_nacionalidad,
			 :persona_fecha_nacimiento,:persona_telefono, :persona_direccion, :id,
			 to: :paciente, prefix: true, allow_nil: true


	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

	delegate :nombre, to: :area, prefix: true, allow_nil: true

  delegate :full_name, to: :doctor, prefix: true, allow_nil: true

end