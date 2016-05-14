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
    @pacientes_adultos = @search.result
                        .includes(:ficha_fisioterapeutica_adulto)
                        .joins(:ficha_fisioterapeutica_adulto)


    @pacientes_ninos =  @search.result
                        .includes(:ficha_fisioterapia_nino)
                        .joins(:ficha_fisioterapia_nino)

    @pacientes = @pacientes_adultos + @pacientes_ninos

    end
end
