class ConsultaNutricionalAdulto < ActiveRecord::Base
   paginates_per 20

	#asociaciones
 	belongs_to :doctor, :foreign_key => :doctor_id

 	belongs_to :user

 	belongs_to :ficha_nutricional_adulto , :foreign_key => :ficha_id

 	has_many :controles

 	has_many :recuentos, dependent: :destroy

 	accepts_nested_attributes_for :recuentos, reject_if: :all_blank, allow_destroy: true

 	#carga id area antes de guardar la consulta
 	#before_create :cargar_area_id

 	#carga el area automaticamente
 	#def cargar_area_id
	#	area= Area.where(nombre: 'Nutrición').first.id
	#	self.area_id= area
	#end



	#delegate :nombre, to: :area, prefix: true, allow_nil: true

	delegate :persona_nombre, :persona_apellido, :persona_full_name, :abr_profesion, to: :doctor, prefix: true, allow_nil: true

end
