class Funcionario < Empleado
	belongs_to :area

	# Law of Demeter
	delegate :nombre, :costo, to: :area, prefix: true, allow_nil: true
end