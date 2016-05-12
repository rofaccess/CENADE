var consultasNutriPediatricasUI = (function(){
  return {

    initScript: function(){

      /* Script globales */
        APP.initDatepicker();
        APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'})
        APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});
        APP.initSelect2({element: '.select-area', placeholder: 'Seleccione un Área'});

        //pacientesUI.initBuscarPaciente('.select-paciente');
        //empleadosUI.initBuscarDoctor('.select-doctor');

        pacientesUI.getPaciente({element: '.select-paciente', root: 'consultas_nutricionales_pediatricas'});

      /* Valida el formulario antes de enviarlo */
      $('.nueva-consulta').validate();
    }
  };
}());