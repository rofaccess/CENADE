var consultasOdontologicasUI = (function(){
  return {
    getPaciente: function(options){
      $(options.element).on("change", function(){
        $.ajax({

                  url: "/consultas_odontologicas/get_paciente",
                  type: 'get',
                  data: {
                    idd : $(this).val(),
                    root: options.root
                  },
                  success: function(resp){

                  }

                });
      });
    },


    initScript: function(){

      /* Script globales */
        APP.initDatepicker();
        APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'})
        APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});
        APP.initSelect2({element: '.select-area', placeholder: 'Seleccione un Área'});

        //pacientesUI.initBuscarPaciente('.select-paciente');
        //empleadosUI.initBuscarDoctor('.select-doctor');

        consultasOdontologicasUI.getPaciente({element: '.select-paciente', root: 'consultas_odontologicas'});

      /* Valida el formulario antes de enviarlo */
      $('.nueva-consulta').validate();
    }
  };
}());