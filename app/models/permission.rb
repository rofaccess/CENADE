class Permission < ActiveRecord::Base
	has_and_belongs_to_many :roles
	belongs_to :grupo

	def self.agruparRoPermission
  	grupos= Grupo.all
  	grupo= []
 	

     grupos.each do |g|
     grupos_arr = []
       grupos_arr << g.nombre

       subgrupo2 = []

       g.permissions.each do |p|
       	 subgrupo = []
         subgrupo << p.nombre
         subgrupo << p.id
         subgrupo2<< subgrupo
       end
       grupos_arr<<subgrupo2
       grupo <<grupos_arr
     end
 
     grupo

  end

end
