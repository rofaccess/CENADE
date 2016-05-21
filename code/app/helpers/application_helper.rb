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

	# Muestra la información de un campo, arriba el label y debajo el dato
	# label : El identificador del dato mostrado
	# data  : El dato a mostrar
	# width : El ancho que debe tener el conjunto label-data
	def data(label,data,width)
	   html = ""
	   html << "<div class='form-group #{width}'>"
	      html << "<label class='control-label'> #{label} </label>"
	    	html << "<div class='all-border'> #{data} </div>"
	   html << "</div>"
	   html.html_safe
  	end

  	# Muestra la información de un campo, arriba el label y debajo el dato
	# label : El identificador del dato mostrado
	# data  : El dato a mostrar
	# width : El ancho que debe tener el conjunto label-data
	def data_text(label,data,width)
	   html = ""
	   html << "<div class='form-group #{width}'>"
	      html << "<label class='control-label'> #{label} </label>"
	    	html << "<div class='all-border'> #{data} </div>"
	   html << "</div>"
	   html.html_safe
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
