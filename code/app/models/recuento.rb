class Recuento < ActiveRecord::Base
	acts_as_paranoid

	belongs_to :consulta_nutricional_adulto, :foreign_key => :consulta_id
end
