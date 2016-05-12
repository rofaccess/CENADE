var consultasUI = (function(){
	return {

    /* Inicia la funcionalidad de los tabs en el show de las fichas */
    initConsultasTab: function(){
      var tabs;
      jQuery(function($) {
        tabs = $('.tabscontent').tabbedContent({loop: true}).data('api');


                // Next and prev actions
                $('.controls a').on('click', function(e) {
                  var action = $(this).attr('href').replace('#', '');
                  tabs[action]();
                  e.preventDefault();
                });
              });
    },

    selectControl: function(){
      $(".paciente_select").select2({
        placeholder: "Seleccione un paciente",
        language: "es",
        theme: "bootstrap"

      }).on("select2:select",function(){
        $(this).valid();
        id = $(this).val();

        $.ajax({

          url: "/consultas/get_paciente",
          type: 'get',
          data: {
           id : $(this).val()
         },
         success: function(resp){
                      //alert("Data");
                    }

                  });
      });
      $(".profesional_select2").select2({
        placeholder: "Seleccione un Profesional",
        language: "es",
        theme: "bootstrap"

      }).on('change', function () {
        $(this).valid();

      });
      $(".area_select").select2({
        placeholder: "Seleccione un Área",
        theme: "bootstrap",
        language: "es"

      }).on('change', function () {
        $(this).valid();
        id = $(this).val();

        $.ajax({

          url: "/consultas/recarga_profesional",
          type: 'get',
          data: {
           id : $(this).val()
         },
         success: function(resp){
                          //alert("Data");
                        }

                      });
      });

    },

		// Inicia el script en el formulario
		initScript: function(){
			consultasUI.selectControl();

      // Script globales
      APP.initDatepicker();

		  //Valida el formulario antes de enviarlo
      $('.nueva-consulta').last().validate();
     }
   };
 }());

