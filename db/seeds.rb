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

persona1 = Persona.create(ci: '4563123', nombre: 'Jose Juan', apellido: 'Gonzalez Benitez', estado_civil_id: soltero.id, email: "juanjose@gmail.com")
persona2 = Persona.create(ci: '8987456', nombre: 'Jhon', apellido: 'Smith', estado_civil_id: casado.id, email: "josmith@gmail.com")

psicologia = Especialidad.create(descripcion: 'Psicologia')
fisioterapeuta = Especialidad.create(descripcion: 'Fisioterapeuta')

cargo1 = Cargo.create(descripcion: 'Gerente General')
cargo2 = Cargo.create(descripcion: 'Jefe de Pediatria')

horario1 = Horario.create
horario2 = Horario.create

funcionario1 = Funcionario.create(persona_id: persona1.id, horario_id: horario1.id, cargo_id: cargo1.id)
doctor1 = Doctor.create(persona_id: persona2.id, horario_id: horario2.id, cargo_id: cargo2.id, especialidad_id: psicologia.id)

admin = User.create(username: 'admin', password: 'MyAdmin123', password_confirmation: 'MyAdmin123', empleado_id: funcionario1.id, email: "juanjose@gmail.com")
