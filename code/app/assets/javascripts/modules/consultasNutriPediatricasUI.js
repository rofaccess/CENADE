var consultasNutriPediatricasUI = (function(){
  return {
    getPaciente: function(options){
      $(options.element).on("change", function(){
        $.ajax({

                  url: "/consultas_nutricionales_pediatricas/get_paciente",
                  type: 'get',
                  data: {
                    id : $(this).val(),
                    root: options.root
                  },
                  success: function(resp){

                  }

                });
      });
    },

    initScript: function(){
        //consultasNutriPediatricasUI.initConsultasTab();
      /* Script globales */
        APP.initDatepicker();
        APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'})
        APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});
        APP.initSelect2({element: '.select-area', placeholder: 'Seleccione un Área'});

        //pacientesUI.initBuscarPaciente('.select-paciente');
        //empleadosUI.initBuscarDoctor('.select-doctor');

        consultasNutriPediatricasUI.getPaciente({element: '.select-paciente', root: 'consultas_nutricionales_pediatricas'});

      /* Valida el formulario antes de enviarlo */
      $('.nueva-consulta').validate();
    }
  };
}());