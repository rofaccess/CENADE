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

    /* Cuando se selecciona otro valor en el element (select) dado se ejecuta la acción
       recarga_profesional del controlador Consultas, para que muestre en el select
       de profesional, solo los profesionales del área especificada

       element: el id o clase del objeto jquery Ej.: #select_profesional, .select-doctor, etc.
    */
    initRecargaProfesional: function(element){
      $(element).on("change", function(){
        $.ajax({
          url: "/consultas/recarga_profesional",
          type: 'get',
          data: {
            id : $(this).val()
          },
          success: function(resp){

          }
        });
      });
    },

		// Inicia el script en el formulario
		initScript: function(){
      consultasUI.initRecargaProfesional('.select-area');

      // Script globales
      APP.initDatepicker();

      APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'});
      APP.initSelect2({element: '.select-area', placeholder: 'Seleccione un Área'});
      APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

      pacientesUI.getPaciente({element: '.select-paciente', root: 'consultas'});

		  //Valida el formulario antes de enviarlo
      $('.form-consulta').last().validate();
    }
  };
}());

