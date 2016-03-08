class HomeController < ApplicationController
	before_action :set_submenu, only: [:index]

	def set_submenu
    	@submenu_layout = 'layouts/historial_clinico_submenu'
  	end

	def index
	end
end