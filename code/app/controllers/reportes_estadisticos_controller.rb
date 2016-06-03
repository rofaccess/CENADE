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

  def print_reporte_anuales
      @reportes = ReporteEstadistico.select("reportes_estadisticos.area_id, reportes_estadisticos.doctor_id, SUM(cantidad) as cantidad_por_anho, SUM(cant_pend) as cantidad_por_aten, anho").group("reportes_estadisticos.area_id, reportes_estadisticos.doctor_id, anho")

      respond_to do |format|
        format.pdf do
          render pdf:   'Reporte Anual',
          template:     'reportes_estadisticos/print_reporte_anuales.pdf.erb',
          layout:       'pdf.html',
          orientation:  'Landscape',
          title:        'Reporte Anual',
          footer: {
            center: '[page] de [topage]',
            right: "#{Formatter.format_datetime(Time.now)}"
          }
          #disposition:  'attachment' # Ya descarga el pdf en la pc
        end
      end
    end

  def print_reporte_mensuales
      @reportes = ReporteEstadistico.all

      respond_to do |format|
        format.pdf do
          render pdf:   'Reporte Mensual',
          template:     'reportes_estadisticos/print_reporte_mensuales.pdf.erb',
          layout:       'pdf.html',
          orientation:  'Landscape',
          title:        'Reporte Mensual',
          footer: {
            center: '[page] de [topage]',
            right: "#{Formatter.format_datetime(Time.now)}"
          }
          #disposition:  'attachment' # Ya descarga el pdf en la pc
        end
      end
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
    @reporte = ReporteEstadistico.select("reportes_estadisticos.area_id, reportes_estadisticos.doctor_id, SUM(cantidad) as cantidad_por_anho, SUM(cant_pend) as cantidad_por_aten, anho").group("reportes_estadisticos.area_id, reportes_estadisticos.doctor_id, anho")
    @search= @reporte.search(params[:q])
    @reportes= @search.result.page(params[:page])
  end

  def get_reportes_por_mes
    @search = ReporteEstadistico.search(params[:q])
    @reportes = @search.result.page(params[:page])
  end
end
