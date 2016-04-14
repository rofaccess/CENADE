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
persona3 = Persona.create(ci: '89855656', 
						  nombre: 'Jonas',
						  apellido: 'Stuart',
						  direccion: 'Av. Carlos Antonio Lopez c/ Mscal. Francisco Solano Lopez',
	                      telefono: '071 203 454',
	                      ruc: '14-3544d',
	                      fecha_nacimiento: DateTime.now,
	                      sexo: 'Masculino',
	                      edad: '35', 
						  estado_civil_id: soltero.id, 
						  email: "josddddd@gmail.com")

persona3 = Persona.create(ci: '3425464', 
						  nombre: 'Maria Diana',
						  apellido: 'Martinez White',
						  direccion: 'Av Mscal. Francisco Solano Lopez',
	                      telefono: '071 203 346',
	                      ruc: '14-3244d',
	                      fecha_nacimiento: DateTime.now,
	                      sexo: 'Femenino',
	                      edad: '45', 
						  estado_civil_id: casado.id, 
						  email: "maria.diana@gmail.com")
persona4 = Persona.create(ci: '578674', 
						  nombre: 'Litani',
						  apellido: 'Miranda Vazquez',
						  direccion: 'Av. Carlos Antonio Lopez',
	                      telefono: '0985 343 456',
	                      ruc: '23-3544d',
	                      fecha_nacimiento: DateTime.now,
	                      sexo: 'Femenino',
	                      edad: '25', 
						  estado_civil_id: soltero.id, 
						  email: "litami@gmail.com")

persona5 = Persona.create(ci: '6787894', 
						  nombre: 'Homero J.',
						  apellido: 'Simpson',
						  direccion: 'Av. Siempre Vive',
	                      telefono: '071 345 453',
	                      ruc: '14-3223d',
	                      fecha_nacimiento: DateTime.now,
	                      sexo: 'Masculino',
	                      edad: '43', 
						  estado_civil_id: casado.id, 
						  email: "homerojey@gmail.com")


psicologia = Especialidad.create(descripcion: 'Psicologia')
fisioterapeuta = Especialidad.create(descripcion: 'Fisioterapeuta')


funcionario1 = Funcionario.create(persona_id: persona1.id,
							      cargo: 'Gerente General')
funcionario3 = Funcionario.create(persona_id: persona3.id,
							      cargo: 'Secretaria')
funcionario4 = Funcionario.create(persona_id: persona4.id,
							      cargo: 'Contador')

doctor1 = Doctor.create(persona_id: persona2.id,  
	                    cargo: 'Jefe del Area de Pediatria', 
	                    especialidad_id: psicologia.id)

horario1 = Horario.create(empleado_id: funcionario1.id)
horario2 = Horario.create(empleado_id: doctor1.id)


admin = User.create(username: 'admin', 
					password: 'MyAdmin123', 
					password_confirmation: 'MyAdmin123', 
					empleado_id: funcionario1.id,
					email: "juanjose@gmail.com")

configuracion1 = Configuracion.create(empresa_nombre: 'CENADE', 
	                      empresa_direccion: 'Samu´u c/ Ruta 1 km 3,5 - Barrio: Ka´aguy Rory Encarnación', 
	                      empresa_tel: '(71) 207881',
	                      empresa_email: 'cenade@gmail.com',
	                      empresa_horario_atencion: 'De lunes a viernes 7:00-11:00, 13:00-17:00',
	                      empresa_web: 'http://www.cenade.org/',

	                      )
administrador = Role.create!(name: 'Administrador')
admin.add_role :Administrador
Permission.create([{nombre: 'Usuarios', model: 'User', grupo:'Configuracion'},
                     {nombre: 'Datos de la empresa', model: 'Configuracion', grupo:'Configuracion'},
                     {nombre: 'Empleados', model: 'Empleado', grupo:'Personal'},
                     {nombre: 'Roles', model: 'Role', grupo:'Configuracion'}])

 Permission.all.each do |p|
        PermissionsRole.create(role_id: 1, permission_id: p.id)
 end
paciente= Paciente.create(persona_id: persona5.id, fecha_ingreso: '07/05/1995')
paciente2= Paciente.create(persona_id: persona4.id, fecha_ingreso: '07/05/1995')
area= Area.create(nombre: 'Odontologia', costo: 5000)

