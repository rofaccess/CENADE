# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Estados civiles
EstadoCivil.create(descripcion: 'Soltero')
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
  telefono 			{ Faker::Number.number(10) }
  ruc 				{ Faker::Company.ein }
  fecha_nacimiento	{ Date.today }
  sexo				{ %w(Masculino Femenino).sample }
  edad				{ Faker::Number.positive(1, 95) }
  estado_civil_id   { Faker::Number.positive(1, 5) }
  email             { Faker::Internet.email }
end

1.times {
  begin
    Fabricate(:persona)
  rescue
    next
  end
}

# Areas
Area.create(nombre: 'Clínico')
Area.create(nombre: 'Fisioterapia')
Area.create(nombre: 'Fonoaudiología')
Area.create(nombre: 'Neurología')
Area.create(nombre: 'Nutrición')
Area.create(nombre: 'Odontología')
Area.create(nombre: 'Pediatría')
Area.create(nombre: 'Psicopedagogía')


# Funcionario
Funcionario.create(persona_id: 1, cargo: Faker::Name.title, abr_profesion: 'Lic. ' )

# Usuario Admin
admin = User.create(username: 'admin',
          password: 'admin',
          password_confirmation: 'admin',
          empleado_id: 1)

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

Grupo.create([{nombre: 'Configuraciones'}, {nombre: 'Pacientes'}, {nombre: 'Turnos'}, {nombre: 'Personal'},
			{nombre: 'Fichas y Consultas'},{nombre: 'Atencion Profesional (De Todas la Areas)'},{nombre: 'Reportes'}, {nombre: 'Historial Médico (Todas las Áreas)'}])

Permission.create([{nombre: 'Usuarios', model: 'User', grupo_id: 1},
                     {nombre: 'Datos de la empresa', model: 'Configuracion', grupo_id:1},
                     {nombre: 'Empleados', model: 'Empleado', grupo_id:4},
                     {nombre: 'Roles', model: 'Role', grupo_id:1},
                     {nombre: 'Paciente', model: 'Paciente', grupo_id:2},
                     {nombre: 'Turno', model: 'Turno', grupo_id:3},
                     {nombre: 'Clínico', model: 'FichaClinico', grupo_id:5},
                     {nombre: 'Fisioterapia Adulto', model: 'FichaFisioterapeuticaAdulto', grupo_id:5},
                     {nombre: 'Fisioterapia Pediátrica', model: 'FichaFisioterapiaNino', grupo_id:5},
                     {nombre: 'Fonoaudiología', model: 'FichaFonoaudiologica', grupo_id:5},
                     {nombre: 'Neurología', model: 'FichaNeurologica', grupo_id:5},
                     {nombre: 'Nutrición Adulto', model: 'FichaNutricionalAdulto', grupo_id:5},
                     {nombre: 'Nutrición Pediátrica', model: 'FichaNutricionalPediatrica', grupo_id:5},
                     {nombre: 'Odontología', model: 'FichaOdontologica', grupo_id:5},
                     {nombre: 'Pediatría', model: 'FichaPediatrica', grupo_id:5},
                     {nombre: 'Psicopedagogía', model: 'FichaPsicopedagogica', grupo_id:5},
                     {nombre: 'Reporte Estadístico', model: 'ReporteEstadistico', grupo_id:7},
                     {nombre: 'Historial Médico', model: 'Area', grupo_id:8},
                     {nombre: 'Atención Profesional', model: 'Area', grupo_id:6}])
					#pongo estado civil para evitar errores
Permission.all.each do |p|
        PermissionsRole.create(role_id: 1, permission_id: p.id)
end

TituloLargo.create([{titulo: '¿Tuvo algún problema en el embarazo?'},
          {titulo: '¿Realizó controles prenatales?¿Cuántos?'},
          {titulo: '¿Cómo fué su alimentación durante el embarazo?¿Tomó vitaminas/minerales?'},
          {titulo: '¿Tuvo asfixia postnatal?¿Lloró enseguida el bebé?¿Estuvo internado después del nacimiento?'},
          {titulo: '¿Tomó pecho materno?¿Cuánto tiempo tomo solo pecho materno?¿Qué clase de leche tomó?'},
          {titulo: '¿Cuando inició la alimentación complementaria?'},
          {titulo: '¿Tuvo hemorragias anormales?'},
          {titulo: '¿Presentó algún problema serio asociado con el tratamiento odontológico?'},
          {titulo: '¿Sufre de alguna enfermedad cardiovascular?'},
          {titulo: 'Ha sido hospitalizado alguna vez?'}
          ])






