# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections(:en) do |inflect|

	inflect.irregular 'estado_civil', 'estados_civiles'
	inflect.irregular 'persona', 'personas'
	inflect.irregular 'especialidad', 'especialidades'
	inflect.irregular 'cargo', 'cargos'
	inflect.irregular 'horario', 'horarios'
	inflect.irregular 'empleado', 'empleados'
	inflect.irregular 'doctor', 'doctores'
	inflect.irregular 'funcionario', 'funcionarios'
	inflect.irregular 'configuracion', 'configuraciones'
	inflect.irregular 'permissions_rol', 'permissions_roles'
	inflect.irregular 'fecha', 'fechas'
	inflect.irregular 'turno', 'turnos'
	inflect.irregular 'paciente', 'pacientes'
	inflect.irregular 'encargado', 'encargados'

end