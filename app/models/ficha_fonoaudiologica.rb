class FichaFonoaudiologica < ActiveRecord::Base
  paginates_per 20
  belongs_to :paciente
  belongs_to :area
end
