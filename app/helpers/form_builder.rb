include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::FormHelper
include ActionView::Helpers::FormOptionsHelper
module FormBuilder

  # Opciones admisibles
  # f : Es el identificador del formulario
  # field : Es el identificador del campo
  # label_text  : El texto que va a mostrar el label
  # label_class : La clase que se aplica al label
  #               Normalmente lo usamos para establecer el largo del elemento label con col-md-xx
  # field_class : La clase que se aplica al div que contiene al input
  #               Normalmente lo usamos para establecer el largo del elemento div con col-md-xx
  # input_class : La clase que se aplica al input
  # input_value : Valor por defecto del input
  # placeholder : Valor del placeholder del input
  # disabled    : Activa o desactiva el input (por defecto false)
  # readonly    : Bloquea o desbloquea el input (por defecto false)
  # maxLenght   : El maximo de caracteres que acepta el input (por defecto 150)
  # autofocus   : Especifica si se enfoca en este input o no (por defecto false)
  # btn_mas     : Muestra un boton + al lado del input si se lo especifica como option
  # btn_menos   : Muestra un boton - al lado del input si se lo especifica como option
  def self.text_field_h(f, field, option)
      html = ""
      html << "<div class='form-group'>"
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}", 
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'col-md-2'}")

        html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
          
          html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}", 
                                      value: "#{option.key?(:input_value) ? option[:input_value] : ''}", 
                                      placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", 
                                      disabled: option.key?(:disabled) ? option[:disabled] : false, 
                                      readonly: option.key?(:readonly) ? option[:readonly] : false, 
                                      maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", 
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
        html << "</div>"
       
        if option.key?(:btn_mas)
          html << "<div class='col-md-2'><a href='#{option[:btn_mas]}' data-remote='true' data-url='' class='btn btn-default btn-block'><i class='glyphicon glyphicon-plus'></i></a></div>"
        end
       
        if option.key?(:btn_menos)
          html << "<div class='col-md-2'><a href='#' onclick='#{option[:onclick]}' class='btn btn-default btn-block #{option[:btn_menos]}'><i class='glyphicon glyphicon-minus'></i></a></div>"
        end
      html << "</div>"

      html.html_safe

  end

  def self.password_field(f, field, option)
    html = ""
    html << "<div class='form-group'>"
      html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}", class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'col-md-2'}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-4'}'>"
        html << f.password_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}", placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", minLength: "#{option.key?(:min_length) ? option[:min_length] : '3'}")
      html << "</div>"
    html << "</div>"

    html.html_safe
  end

  # Opciones extra a los anteriores
  # col-class : Establece clases para el div que contiene al label y al input
  #             Normalmente lo usamos para establecer el largo del elemento div con col-md-xx
  # Nota: btn_menos no admisible
  # La diferencia con text_field_h es que el input no esta contenido en un div aqui
  # Se pone un if para el input_value, porque de algún modo los formularios de edicion no muestran
  # nada si no se hace así cuando se usa fields_for 
  def self.text_field_v(f, field, option)
    html = ""
      html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
        html << f.label(field,"#{option.key?(:label_text) ? option[:label_text] : ''}", 
                              class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'titulos-campos'}")
        if option.key?(:input_value)
          html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                                      value: "#{option.key?(:input_value) ? option[:input_value] : ''}", 
                                      placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", 
                                      disabled: option.key?(:disabled) ? option[:disabled] : false, 
                                      readonly: option.key?(:readonly) ? option[:readonly] : false, 
                                      maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", 
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
        else
          html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                                      placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", 
                                      disabled: option.key?(:disabled) ? option[:disabled] : false, 
                                      readonly: option.key?(:readonly) ? option[:readonly] : false, 
                                      maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", 
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
        end
        if option.key?(:btn_mas)
          html << "<div class='col-md-2'><a href='#{option[:btn_mas]}' data-remote='true' data-url='' class='btn btn-default btn-block'><i class='glyphicon glyphicon-plus'></i></a></div>"
        end
      html << "</div>"
    html.html_safe
  end    

  # Permite sleccionar los datos de un modelo especificado
  # Opciones extra a los anteriores
  # prompt : Es el mensaje que te muestra Ej.: Seleccione una opción
  def self.collection_select_h(f, field, collection, value, text,option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
          html << select_tag(field, options_from_collection_for_select(collection, value, text, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                           disabled: option.key?(:disabled) ? option[:disabled] : false,
                           readonly: option.key?(:readonly) ? option[:readonly] : false,
                           autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
        html << "</div>"
      else
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
          html << f.collection_select(field, collection, value, text,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                      class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                      disabled: option.key?(:disabled) ? option[:disabled] : false,
                                      readonly: option.key?(:readonly) ? option[:readonly] : false,
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
        html << "</div>"
      end
      if option.key?(:btn_mas)
        html << "<div class='col-md-2'><a href='#{option[:btn_mas]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  # Permite sleccionar los datos de un modelo especificado
  # La diferencia con collection_select_h es que el select y label estan en un mismo div
  def self.collection_select_v(f, field, collection, value, text,option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << select_tag(field, options_from_collection_for_select(collection, value, text, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                           disabled: option.key?(:disabled) ? option[:disabled] : false,
                           readonly: option.key?(:readonly) ? option[:readonly] : false,
                           autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      else
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << f.collection_select(field, collection, value, text,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                     class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                     disabled: option.key?(:disabled) ? option[:disabled] : false,
                                     readonly: option.key?(:readonly) ? option[:readonly] : false,
                                     autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      end
      if option.key?(:btn_mas)
        html << "<div class='col-md-2'><a href='#{option[:btn_mas]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end
  
  # Permite establecer tus propios valores en el select Ej.: Pendiente, Pagado, etc.
  def self.select_h(f, field, collection, option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << select_tag(field, options_for_select(collection, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                           disabled: option.key?(:disabled) ? option[:disabled] : false,
                           readonly: option.key?(:readonly) ? option[:readonly] : false,
                           autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      else
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << f.select(field, collection,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                     class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                     disabled: option.key?(:disabled) ? option[:disabled] : false,
                                     readonly: option.key?(:readonly) ? option[:readonly] : false,
                                     autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      end
      if option.key?(:btn)
        html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  # Permite establecer tus propios valores en el select Ej.: Pendiente, Pagado, etc.
  # La diferencia con select_h es que el select esta contenido en un div aqui
  def self.select_v(f, field, collection, option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
    if f.nil?
      html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : ''}'>"
        html << select_tag(field, options_for_select(collection, 
                           option.key?(:selected) ? option[:selected] : nil),
                           {multiple: option.key?(:multiple) ? option[:multiple] : false,
                            prompt: option.key?(:prompt) ? option[:prompt] : '',
                            class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                            disabled: option.key?(:disabled) ? option[:disabled] : false,
                            readonly: option.key?(:readonly) ? option[:readonly] : false,
                            autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      html << "</div>"
    else
      html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'titulos-campos'}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : ''}'>"
        html << f.select(field, collection,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                     class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                     disabled: option.key?(:disabled) ? option[:disabled] : false,
                                     readonly: option.key?(:readonly) ? option[:readonly] : false,
                                     autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      html << "</div>"
    end
    if option.key?(:btn_mas)
      html << "<div class='col-md-2'><a href='#{option[:btn_mas]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
    end
    html << "</div>"

    html.html_safe
  end

  


end

