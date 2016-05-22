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

  	# Da un formato dd/mm/aaaa a la fecha especificada
  	def date(date)
    	(date != NIL) ? date.strftime("%d/%m/%Y") : NIL
  	end

  	def checkbox(label,data,width)
  		if data == '1'
  			checked ='checked'
  		else
  			checked = ''
  		end
  		html =""
  			html <<"<div class = 'form-group col-md-2'>"
  			html <<"<div class = 'checkbox'>"
  				html<< "<label><input type='checkbox'#{checked}>#{label}</label>"
  		html <<"</div>"
  		html << "</div>"
  		html.html_safe
  	end


end
