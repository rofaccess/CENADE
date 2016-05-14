class HistorialesFisioterapeuticosController < ApplicationController
  before_action :set_submenu, only: [:show, :index ]
  before_action :set_sidebar, only: [:show, :index]

  def set_submenu
    @submenu_layout = 'layouts/submenu_fichas_consultas'
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_historiales'
  end

  def index
    get_pacientes
  end

  def show
  end

  # Obtiene los pacientes con fichas de Fisioterapia Pediátrica y/o Adulto
  def get_pacientes
    @search = Paciente.ransack(params[:q])
    @pacientes = @search.result
                        .includes(:persona) # para que order por nombre de persona funcione
                        .joins('LEFT OUTER JOIN fichas_fisioterapeuticas_adultos ON pacientes.id = fichas_fisioterapeuticas_adultos.paciente_id LEFT OUTER JOIN ficha_fisioterapia_ninos ON pacientes.id = ficha_fisioterapia_ninos.paciente_id')
                        .where('pacientes.id = fichas_fisioterapeuticas_adultos.paciente_id OR pacientes.id = ficha_fisioterapia_ninos.paciente_id')
                        .order('personas.nombre')
  end
end
