# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

casado = EstadoCivil.create(descripcion: 'Casado')
soltero = EstadoCivil.create(descripcion: 'Soltero')
divorciado = EstadoCivil.create(descripcion: 'Divorciado')
viudo = EstadoCivil.create(descripcion: 'Viudo')
menor = EstadoCivil.create(descripcion: 'Menor')

persona1 = Persona.create(ci: '4563123', 
	                      nombre: 'Jose Juan', 
	                      apellido: 'Gonzalez Benitez',
	                      direccion: 'Barrio Las Mercedes',
	                      telefono: '0985 323 456',
	                      ruc: '2b-35445c',
	                      fecha_nacimiento: DateTime.now,
	                      sexo: 'Masculino',
	                      edad: '40',
	                      estado_civil_id: casado.id, 
	                      email: "juanjose@gmail.com")
persona2 = Persona.create(ci: '8987456', 
						  nombre: 'Jhon',
						  apellido: 'Smith',
						  direccion: 'Av. Carlos Antonio Lopez c/ Mscal. Francisco Solano Lopez',
	                      telefono: '071 203 454, 0985 343 456',
	                      ruc: '14-3544d',
	                      fecha_nacimiento: DateTime.now,
	                      sexo: 'Masculino',
	                      edad: '35', 
						  estado_civil_id: soltero.id, 
						  email: "josmith@gmail.com")

psicologia = Especialidad.create(descripcion: 'Psicologia')
fisioterapeuta = Especialidad.create(descripcion: 'Fisioterapeuta')

cargo1 = Cargo.create(descripcion: 'Gerente General')
cargo2 = Cargo.create(descripcion: 'Jefe de Pediatria')

funcionario1 = Funcionario.create(persona_id: persona1.id,
							      cargo_id: cargo1.id)
doctor1 = Doctor.create(persona_id: persona2.id,  
	                    cargo_id: cargo2.id, 
	                    especialidad_id: psicologia.id)

horario1 = Horario.create(empleado_id: funcionario1.id)
horario2 = Horario.create(empleado_id: doctor1.id)

admin = User.create(username: 'admin', 
					password: 'MyAdmin123', 
					password_confirmation: 'MyAdmin123', 
					empleado_id: funcionario1.id)

configuracion1 = Configuracion.create(empresa_nombre: 'CENADE', 
	                      empresa_direccion: 'Samu´u c/ Ruta 1 km 3,5 - Barrio: Ka´aguy Rory Encarnación', 
	                      empresa_tel: '(71) 207881',
	                      empresa_email: 'cenade@gmail.com',
	                      empresa_horario_atencion: 'De lunes a viernes 7:00-11:00, 13:00-17:00',
	                      empresa_web: 'http://www.cenade.org/',
	                      


	                      )
