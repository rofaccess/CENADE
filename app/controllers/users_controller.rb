class UsersController < ApplicationController
	
	before_action :set_submenu, only: [:index]

	def set_submenu
		@submenu_layout = 'layouts/submenu_configuracion'
	end

	def index
		@users= User.all
	end
end
