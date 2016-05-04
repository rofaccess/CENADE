class FichaOdontologica < ActiveRecord::Base
  #asociaciones
  belongs_to :paciente_id
  belongs_to :area_id
  belongs_to :doctor, :foreign_key => :doctor_id
end
