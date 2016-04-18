class Encargado < ActiveRecord::Base
	acts_as_paranoid

	has_one :paciente
end