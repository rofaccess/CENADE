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
end
