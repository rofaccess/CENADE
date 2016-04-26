# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Estados civiles
soltero = EstadoCivil.create(descripcion: 'Soltero')
EstadoCivil.create(descripcion: 'Casado')
EstadoCivil.create(descripcion: 'Divorciado')
EstadoCivil.create(descripcion: 'Viudo')
EstadoCivil.create(descripcion: 'Menor')

# Personas
Fabricator(:persona) do
  ci 				{ Faker::Number.number(10) }
  nombre 			{ Faker::Name.first_name }
  apellido 			{ Faker::Name.last_name }
  direccion 		{ Faker::Address.street_address }
  telefono 			{ Faker::PhoneNumber.cell_phone }
  ruc 				{ Faker::Company.ein }
  fecha_nacimiento	{ Faker::Time.between(10.days.ago, Date.today, :all)}
  sexo				{ %w(Masculino Femenino).sample }
  edad				{ Faker::Number.positive(1, 95) }
  estado_civil_id   { Faker::Number.positive(1, 5) }
  email             { Faker::Internet.email }
end

50.times {
  begin
    Fabricate(:persona)
  rescue
    next
  end
}

# Areas
Area.create(nombre: 'Psicologia')
Area.create(nombre: 'Fisioterapia')
Area.create(nombre: 'Psicopedagogía')
Area.create(nombre: 'Nutrición')
Area.create(nombre: 'Fonoaudiologia')
Area.create(nombre: 'Pediatría')
Area.create(nombre: 'Odontología')
Area.create(nombre: 'Neurología')
Area.create(nombre: 'Clínico')

# Funcionarios
for i in 1..15
	Funcionario.create(persona_id: i, cargo: Faker::Name.title )
end

# Doctores
for i in 16..30
	Doctor.create(persona_id: i, cargo: Faker::Name.title, area_id: Faker::Number.positive(1, 9))
end

# Pacientes
for i in 31..50
	Paciente.create(persona_id: i, fecha_ingreso: '07/05/1995', lugar_nacimiento: Faker::Address.city, profesion: Faker::Company.profession)
end

# Usuario Admin
admin = User.create(username: 'admin', 
					password: 'admin', 
					password_confirmation: 'admin', 
					empleado_id: 1)

# Usuario User
user = User.create(username: 'user', 
					password: 'user', 
					password_confirmation: 'user', 
					empleado_id: 16)

# Configuración
configuracion1 = Configuracion.create(empresa_nombre: 'CENADE', 
	                      empresa_direccion: 'Samu´u c/ Ruta 1 km 3,5 - Barrio: Ka´aguy Rory Encarnación', 
	                      empresa_tel: '(71) 207881',
	                      empresa_email: 'cenade@gmail.com',
	                      empresa_web: 'http://www.cenade.org/',
	                 
	                      hora_inicio_mañana: '07:00',
	                      hora_fin_mañana: '11:00',	                      
	                      hora_inicio_tarde:'13:00',
	                      hora_fin_tarde: '17:00',
	                      dias_atencion:'De Lunes a Viernes',
	                      usuario_admin: admin.id)

# Roles y permisos
administrador = Role.create!(name: 'Administrador')
admin.add_role :Administrador

user.add_role :Administrador

Grupo.create([{nombre: 'Configuraciones'}, {nombre: 'Pacientes'}, {nombre: 'Turnos'}, {nombre: 'Personal'}])
Permission.create([{nombre: 'Usuarios', model: 'User', grupo_id: 1},
                     {nombre: 'Datos de la empresa', model: 'Configuracion', grupo_id:1},
                     {nombre: 'Empleados', model: 'Empleado', grupo_id:4},
                     {nombre: 'Roles', model: 'Role', grupo_id:1},
                     {nombre: 'Paciente', model: 'Paciente', grupo_id:2},
                     {nombre: 'Turno', model: 'Turno', grupo_id:3}])

Permission.all.each do |p|
        PermissionsRole.create(role_id: 1, permission_id: p.id)
end

# Turnos
turno= Turno.create(paciente_id: 31, fecha_expedicion: '07/05/2015',
					fecha_consulta: '07/05/2015', area_id: 1, doctor_id: 16, 
					estado: 'pendiente', monto: '5000', paga: true, nro_factura: '33-445-gh',
					turno: 1)



