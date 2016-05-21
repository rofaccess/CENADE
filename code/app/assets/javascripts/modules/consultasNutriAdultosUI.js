var consultasNutriAdultosUI = (function(){
  return {
    getPaciente: function(options){
      $(options.element).on("change", function(){
        $.ajax({

                  url: "/consultas_nutricionales_adultos/get_paciente",
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
    initScript: function(){
        //consultasNutriPediatricasUI.initConsultasTab();
      /* Script globales */

        APP.initDatepicker();
        APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'})
        APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

        //pacientesUI.initBuscarPaciente('.select-paciente');
        //empleadosUI.initBuscarDoctor('.select-doctor');

        consultasNutriAdultosUI.getPaciente({element: '.select-paciente', root: 'consultas_nutricionales_adultos'});
        consultasNutriAdultosUI.showHiden();
      /* Valida el formulario antes de enviarlo */
      $('.nueva-consulta').validate();
    }
  };
}());