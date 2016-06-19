class ConsultaNutricionalAdulto < ActiveRecord::Base
  paginates_per 20

	#Asociaciones
 	belongs_to :doctor, -> { with_deleted }, :foreign_key => :doctor_id
  belongs_to :paciente, -> { with_deleted }
  belongs_to :area
 	belongs_to :ficha_nutricional_adulto , :foreign_key => :ficha_nutricional_adulto_id

 	has_many :controles
 	has_many :recuentos, dependent: :destroy

 	accepts_nested_attributes_for :recuentos, reject_if: :all_blank, allow_destroy: true

  #Validaciones
  validates :paciente, presence: true
  validates :doctor, presence: true
  validates :fecha, presence: true, date_less_system_date: true
  validate  :paciente_has_not_ficha

  def paciente_has_not_ficha
    if Consulta.get_ficha(area.nombre + ' Adulto', paciente.id).nil?
      errors.add(:base, I18n.t('activerecord.errors.messages.paciente_has_not_ficha'))
    end
  end
 	#carga id area antes de guardar la consulta
 	#before_create :cargar_area_id

 	#carga el area automaticamente
 	#def cargar_area_id
	#	area= Area.where(nombre: 'Nutrición').first.id
	#	self.area_id= area
	#end



	#delegate :nombre, to: :area, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion,:full_name, to: :doctor, prefix: true, allow_nil: true

end
