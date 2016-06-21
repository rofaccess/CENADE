class Encargado < ActiveRecord::Base
	acts_as_paranoid

  #Asociaciones
	has_one :paciente, -> { with_deleted }

  #Validaciones
  validates :padre_nombre, length: {in: 3..Domain::NOM_APE}, allow_blank: true
  validates :padre_edad, length: {maximum: Domain::EDAD}, number_only: true, allow_blank: true
  validates :padre_prof_act_ant, length: {in: 2..Domain::PROF_ACT_ANT}, allow_blank: true
  validates :madre_nombre, length: {in: 3..Domain::NOM_APE}, allow_blank: true
  validates :madre_edad, length: {maximum: Domain::EDAD}, number_only: true, allow_blank: true
  validates :madre_num_hijos, length: {maximum: Domain::NUM_HIJOS}, number_only: true, allow_blank: true
  validates :madre_prof_act_ant, length: {in: 2..Domain::PROF_ACT_ANT}, allow_blank: true
  validates :encargado_nombre, length: {in: 3..Domain::NOM_APE}, allow_blank: true
  validates :encargado_edad, length: {maximum: Domain::EDAD}, number_only: true, allow_blank: true
  validates :encargado_prof_act_ant, length: {in: 2..Domain::PROF_ACT_ANT}, allow_blank: true
end