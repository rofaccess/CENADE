module HistorialHelper
   def panel_h(panel_title)
      html = ""
      html << "<div class='panel panel-default panel-historial panel-folding'>"
         html << "<div class='panel-heading'> #{panel_title} </div>"
         html << "<div class='panel-body'>"
      html.html_safe
   end

   def panel_head_h(panel_title)
      html = ""
         html << "<div class='panel panel-default panel-historial'>"
            html << "<div class='panel-heading'>#{panel_title} (No tiene)</div>"
         html << "</div>"
      html.html_safe
   end

   def panel_end_h()
      html = ""
         html << "</div>"
         html << "</div>"
      html.html_safe
   end

   # La h se refiere a que es exlusivo para el show e imprimir de historial clínico

   # Para los datos que tal vez tengan un borde inferior, todos o ningun borde
   # Muestra la información de un campo, arriba el label y debajo el dato
   # label : El identificador del dato mostrado
   # data  : El dato a mostrar
   # width : El ancho que debe tener el conjunto label-data
   def data_h(label,data,width)
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
   def data_text_h(label,data,width)
      html = ""
      html << "<div class='form-group #{width}'>"
         html << "<label class='control-label'> #{label} </label>"
         html << "<div class='all-border'> #{data} </div>"
      html << "</div>"
      html.html_safe
   end
end