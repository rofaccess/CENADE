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

    /*
      Verifica si un paciente posee o no una ficha
      .paciente-id        : es la clase del elemento (input) que contiene el id del paciente
      .ficha-id       : es la clase del elemento (input) que contiene el id de la persona relacionada al paciente
      checkPacienteHasNotFichaUrl: la url del controlador y acción de consultas correspondiente
    */
      checkPacienteHasNotFicha: function(checkPacienteHasNotFichaUrl){
            $.validator.addClassRules({
                pacienteHasNotFicha: {
                    remote: {
                        url: checkPacienteHasNotFichaUrl,
                        type: "get",
                        data: {
                            paciente_id: function() {
                                return $( '.paciente-id' ).val();
                            },
                        }
                    }
                }
            });
        },

    showHiden: function(options){
      $(".hide_actividades").hide();
      $('input[type="radio"]').click(function(){

          if(this.value == 'true' && this.checked){
              $(".hide_actividades").show();
          }
          else{
              $(".hide_actividades").hide();
          }
      });
    },

    // Inicia el script en el formulario
    initScript: function(){
      // Script globales
      APP.initDatepicker();

      pacientesUI.initBuscarPaciente('.select-paciente');
      APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

      //Valida el formulario antes de enviarlo
      $('.form-consulta').last().validate();
    }
  };
}());
