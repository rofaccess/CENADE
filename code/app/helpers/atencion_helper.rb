module AtencionHelper

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