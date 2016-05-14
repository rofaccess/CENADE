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
	inflect.irregular 'ficha_nutricional_pediatrica', 'fichas_nutricionales_pediatricas'
	inflect.irregular 'paciente', 'pacientes'
	inflect.irregular 'encargado', 'encargados'
	inflect.irregular 'grupo', 'grupos'
	inflect.irregular 'ficha_fisioterapia_nino', 'ficha_fisioterapia_ninos'
	inflect.irregular 'ficha_fonoaudiologica','fichas_fonoaudiologicas'
	inflect.irregular 'ficha_psicopedagogica','fichas_psicopedagogicas'
	inflect.irregular 'ficha_fisioterapeutica_adulto', 'fichas_fisioterapeuticas_adultos'
	inflect.irregular 'ficha_nutricional_adulto', 'fichas_nutricionales_adultos'
	inflect.irregular 'consulta', 'consultas'
	inflect.irregular 'ficha_pediatrica', 'fichas_pediatricas'
	inflect.irregular 'ficha_neurologica', 'fichas_neurologicas'
	inflect.irregular 'ficha_clinico', 'fichas_clinicos'
	inflect.irregular 'consulta_nutricional_pediatrica', 'consultas_nutricionales_pediatricas'
	inflect.irregular 'ficha_nutricional_pediatrica', 'fichas_nutricionales_pediatricas'
	inflect.irregular 'ficha_odontologica','fichas_odontologicas'
	inflect.irregular 'historial_fisioterapeutico', 'historiales_fisioterapeuticos'
end