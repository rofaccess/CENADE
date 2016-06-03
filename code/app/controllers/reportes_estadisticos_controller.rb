class ReportesEstadisticosController < ApplicationController

  before_action :set_sidebar, only: [:index, :por_mes, :por_anho]

  def index
  	get_reportes
  end

  def set_sidebar
    @sidebar_layout = 'layouts/sidebar_reportes'
  end

  def por_mes
    get_reportes_por_mes
  end

  def por_anho
    get_reportes
  end

  def buscar
    get_reportes_por_mes
    render 'por_mes'
  end
  def buscar_anho
    get_reportes
    render 'por_anho'
  end

  def get_reportes
    @reporte = ReporteEstadistico.select("area_id, doctor_id, SUM(cantidad) as cantidad_por_anho, SUM(cant_pend) as cantidad_por_aten, anho").group("area_id, doctor_id, anho")
    @search= @reporte.search(params[:q])
    @reportes= @search.result.page(params[:page])
  end

  def get_reportes_por_mes
    @search = ReporteEstadistico.search(params[:q])
    @reportes = @search.result.page(params[:page])
  end
end
