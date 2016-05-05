module ApplicationHelper
	def current_menu(path)
		path.each do |p|
			return "active" if request.url.include?(p)
		end
	end
		
	def current_submenu(path)
		current_menu(path)
	end	

	def current_sidebar(path)
		current_menu(path)
	end	
end
