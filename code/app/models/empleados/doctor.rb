class Doctor < Empleado
 	 	
 	belongs_to :especialidad
 	belongs_to :area
 	has_many :turnos
 	has_many :ficha_fisioterapia_ninos
 	has_many :fichas_fonoaudiologicas
 	has_many :fichas_psicopedagogicas	

 	has_many :consultas

end