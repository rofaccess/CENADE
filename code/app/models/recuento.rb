class Recuento < ActiveRecord::Base
	belongs_to :consulta_nutricional_adulto, :foreign_key => :consulta_id
end
