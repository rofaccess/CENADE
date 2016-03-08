class WelcomeController < ApplicationController
	#before_action :set_submenu, only: [:index]

	def set_submenu
    	@submenu_layout = 'layouts/submenu_historial_clinico'
  	end

	def index
	end
end