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
     html <<"<div class = 'form-group #{width}'>"
     html <<"<div class = 'checkbox'>"
     html<< "<label><input type='checkbox'#{checked}>#{label}</label>"
     html <<"</div>"
     html << "</div>"
     html.html_safe
  end

  # Muestra un mensaje
  # message: el mensaje a mostrar
  # type   : tipo de mensaje, danger, warning, info
  def message(message,type)
    icon = ""
    case type
    when "info"
      icon="info-circle"
    when "warning"
      icon="warning"
    else
      icon = ""
    end

    html =""
    html << "<div class='message message-#{type}'>"
      html << "<span class='fa fa-#{icon} icon-left'></span>"
      html << "<div class='message-content'>#{message}</div>"
      html << "<span class='glyphicon glyphicon-remove close-message'></span>"
    html << "</div>"
    html.html_safe
  end

  # Define un panel reutilizable
   def panel_begin(panel_title)
      html = ""
      html << "<div class='panel-custom panel-folding'>"
         html << "<div class='panel-heading'><span class='fa fa-caret-right'></span> #{panel_title} </div>"
         html << "<div class='panel-body'>"
      html.html_safe
   end

   # Panel con título, pero sin contenido
   def panel_head(panel_title)
      html = ""
         html << "<div class='panel-custom'>"
            html << "<div class='panel-heading panel-empty'>#{panel_title}</div>"
         html << "</div>"
      html.html_safe
   end
   # Se encarga de cerrar los div abiertos en panel_begin
   def panel_end()
      html = ""
         html << "</div>"
         html << "</div>"
      html.html_safe
   end


  # # Define la cabecera del tab
  #  # id    : identificador para la cabecera del tab
  #  # active: true si esta activo, caso contrario false
  #  def tab_head(id,title,active)
  #     html = ""
  #     html << "<li class=#{active ? 'active' : ''}>"
  #        html << "<a href='##{id}' data-toggle='tab' aria-expanded='true'>#{title}</a>"
  #     html << "</li>"
  #     html.html_safe
  #  end

  #  # Define el cuerpo del tab
  #  # id    : identificador para la cabecera del tab
  #  # active: true si esta activo, caso contrario false
  #  def tab_body(id,active)
  #     html = ""
  #     html << "<div id='#{id}' class='tab-pane fade #{active ? 'in active': ''}'>"
  #     html.html_safe
  #  end

  #  # Cierra el div abierto en tab_body
  #  def tab_end
  #     html = ""
  #     html << "</div>"
  #     html.html_safe
  #  end



   # Para los datos que tal vez tengan un borde inferior, todos o ningun borde
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

   # Para los datos de tipo texto largo, que si o si deben tener todos los bordes
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
end
