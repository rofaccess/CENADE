class ReportesEstadisticosController < ApplicationController
  def index
  	get_turnos
  end

  def get_turnos
    @search = Turnos.search(params[:q])
    @turnos = @search.result.page(params[:page])
  end
end
