class Doctor < Empleado
 	 	
 	belongs_to :especialidad
 	belongs_to :area	

 	has_many :consultas

end