class Consulta < ActiveRecord::Base 	
 	acts_as_paranoid
 	paginates_per 20

 	#asociaciones
 	belongs_to :doctor, :foreign_key => :profesional_salud_id
 	belongs_to :user
 	belongs_to :paciente
 	belongs_to :area

 	#validaciones
 	validates :tratamiento , length: { maximum: Domain::DESC600, message: ' soporta un máximo de 600 caracteres' }
 	validates :evaluacion , length: { maximum: Domain::DESC300, message: ' soporta un máximo de 300 caracteres' }
 	validates :motivo_consulta, length: { maximum: Domain::DESC300, message: ' soporta un máximo de 300 caracteres' }
 	validates :observaciones, length: { maximum: Domain::DESC250, message: ' soporta un máximo de 250 caracteres' }
end