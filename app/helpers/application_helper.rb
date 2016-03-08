module ApplicationHelper
	 def current_menu(path)
  	path.each do |p|
  		return "active" if request.url.include?(p)
  	end
  end
end
