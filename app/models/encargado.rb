class Encargado < ActiveRecord::Base
	has_one :paciente
end