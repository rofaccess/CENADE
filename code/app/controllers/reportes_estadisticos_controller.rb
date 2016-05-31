class ReportesEstadisticosController < ApplicationController

  before_action :set_sidebar, only: [:index, :por_mes, :por_anho]

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
    get_reportes
  end

  def get_turnos
    @search = Turno.search(params[:q])
    @turnos = @search.result.page(params[:page])
  end

  def get_reportes
    @reporte = ReporteEstadistico.select("area_id, doctor_id, SUM(cantidad) as cantidad_por_anho, anho").group("area_id, doctor_id, anho")
    @search= @reporte.search(params[:q])
    @reportes= @search.result.page(params[:page])
  end
end
