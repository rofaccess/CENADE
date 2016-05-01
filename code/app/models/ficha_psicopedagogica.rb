class FichaPsicopedagogica < ActiveRecord::Base
  #asociaciones
  belongs_to :paciente
  belongs_to :area
  belongs_to :doctor, :foreign_key => :doctor_id
end
