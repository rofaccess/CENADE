var fichasUI = (function(){
  return {

    initScript: function(){

      /* Script globales */
        APP.initDatepicker();
        pacientesUI.initBuscarPaciente('.select-paciente');
        APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

      /* Valida el formulario antes de enviarlo */
      $('.form-ficha').validate();
    }
  };
}());