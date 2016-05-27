class ReportesEstadisticosController < ApplicationController
  def index
  	get_turnos
  end

  def get_turnos
    @search = Turno.search(params[:q])
    @turnos = @search.result.page(params[:page])
  end

   def por_mes
   	get_turnos
  end

   def por_ano
   	get_turnos
  end
end
