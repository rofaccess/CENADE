# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.create(username: 'admin', 
					password: 'MyAdmin123', 
					password_confirmation: 'MyAdmin123', 
				
					email: "juanjose@gmail.com")

configuracion = Configuracion.create(empresa_nombre: 'CENADE', 
	                      empresa_direccion: 'Samu´u c/ Ruta 1 km 3,5 - Barrio: Ka´aguy Rory Encarnación', 
	                      empresa_tel: '(71) 207881',
	                      empresa_email: ' ',
	                      empresa_horario_atencion: 'De lunes a viernes 7:00-11:00, 13:00-17:00',
	                      empresa_web: 'http://www.cenade.org/',
	                      empresa_logo: 'C:\Users\USER\Documents\8vo semestre\CenadeNuevo\files')
