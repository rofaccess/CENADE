class Doctor < Empleado
 	 	
 	belongs_to :especialidad
 	belongs_to :area
 	has_many :turnos
 	has_many :ficha_fisioterapia_ninos	

end