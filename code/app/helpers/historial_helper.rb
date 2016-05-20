module HistorialHelper
   # Nota: La h se refiere a que es exlusivo para el show e imprimir de historial clínico

   # Define un panel reutilizable para los historiales
   def h_panel(panel_title)
      html = ""
      html << "<div class='panel-historial panel-folding'>"
         html << "<div class='panel-heading'> #{panel_title} </div>"
         html << "<div class='panel-body'>"
      html.html_safe
   end

   # Panel con título, pero sin contenido
   def h_panel_head(panel_title)
      html = ""
         html << "<div class='panel-historial'>"
            html << "<div class='panel-heading'>#{panel_title}</div>"
         html << "</div>"
      html.html_safe
   end
   # Se encarga de cerrar los div abiertos en h_panel
   def h_panel_end()
      html = ""
         html << "</div>"
         html << "</div>"
      html.html_safe
   end

   # Para los datos que tal vez tengan un borde inferior, todos o ningun borde
   # Muestra la información de un campo, arriba el label y debajo el dato
   # label : El identificador del dato mostrado
   # data  : El dato a mostrar
   # width : El ancho que debe tener el conjunto label-data
   def h_data(label,data,width)
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
   def h_data_text(label,data,width)
      html = ""
      html << "<div class='form-group #{width}'>"
         html << "<label class='control-label'> #{label} </label>"
         html << "<div class='all-border'> #{data} </div>"
      html << "</div>"
      html.html_safe
   end
end