class ReportesEstadisticosController < ApplicationController

  before_action :set_sidebar, only: [:index, :por_mes, :por_ano]

  def index
  	get_reportes
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_reportes'
  end

  def por_mes
    get_reportes
  end

  def por_anho
    @search = ReporteEstadistico.group(:area_id).search(params[:q])
    @reportes= @search.result.page(params[:page])
  end

  def get_turnos
    @search = Turno.search(params[:q])
    @turnos = @search.result.page(params[:page])
  end

  def get_reportes
    @search = ReporteEstadistico.search(params[:q])
    @reportes= @search.result.page(params[:page])
  end
end
