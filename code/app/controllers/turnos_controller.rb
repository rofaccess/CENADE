class TurnosController < ApplicationController
 
  before_action :set_turno, only: [:show, :edit, :update, :destroy]
  def index
  	@search = Turno.ransack(params[:q])
    @turnos= @search.result.page(params[:page])
  end

  def new
  	@turno= Turno.new
  end
  def create
  	
  end

  def edit
  end

  def update
  end

  def show
  end

  def 
  end
end
