var fisioNinosUI = (function(){
	return {

    /* si se usa pacientesUI.checkPacienteHasFicha("<%=fichas_fonoaudiologicas_check_paciente_id_path%>");
     en tu form de ficha, todo esta funcion ya no es necesaria
     checkPacienteHasFicha se define una sola vez y se puede utilizar en todas los form de fichas
     */
    checkPACIENTE: function(checkFisioNinoPacienteUrl){
            $.validator.addClassRules({
                uniquePACIENTE: {
                    remote: {
                        url: checkFisioNinoPacienteUrl,
                        type: "get",
                        data: {
                            paciente_id: function() {
                                return $( "#paciente_id" ).val();
                            },
                            idd: function() {
                                return $('#ficha_fisioterapia_nino_id').val();
                            }
                        }
                    }
                }
            });
        },

        /* Lo siguiente ya se inicia globalmente en application.js con initAdvancedSearch
      Por lo que se puede eliminar esta funcion, nota: en los comentarios de initAdvancedSearch se
      explica como utilizarlo
      - En vez de usar la clase show en el boton de busqueda avanzada deben establecer un id show-advanced-search al boton
      - El div que contiene los campos de busqueda debe tener un id advanced-search y no la clase to-hide
      el div debe tener style = 'display:none;'
    */
        advancedSearchControl: function(){
          $(".to-hide").hide();

             $(document).ready(function(){
              var show=true;
              $("#show").click(function(){
               if(show){
                  $("#advanced-search").show();
                  show=false;
               }else{
                  $("#advanced-search").hide();
                  show=true;
               }

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

                  url: "/ficha_fisioterapia_ninos/get_paciente",
                  type: 'get',
                  data: {
                   id : $(this).val()
                  },
                  success: function(resp){
                      //alert("Data");
                   }

                 });
              });

              //Se puede usar esto
              APP.initSelect2({element: '.profesional_select', placeholder: 'Seleccione un Profesional'});

              //en vez de esto
              /*
              $(".profesional_select").select2({
                placeholder: "Seleccione un Profesional",
                language: "es",
                theme: "bootstrap"

                }).on('change', function () {
                    $(this).valid();
                });
              */

              //Se puede usar esto
              APP.initSelect2({element: '.area_select', placeholder: 'Seleccione un Profesional'});

              //en vez de esto
              //Leslie esto creo que no se usa luego en el form de ficha fisioterapia niños
              /*
            $(".area_select").select2({
                placeholder: "Seleccione un Área",
                theme: "bootstrap",
                language: "es"

                }).on('change', function () {
                    $(this).valid();
                });
                */
        },

		initScript: function(checkFisioNinoPacienteUrl){

		       //var tabs;

           fisioNinosUI.selectControl();

           APP.initDatepicker();
           /*//Este script se llama en show asi: consultasUI.initConsultasTab();
            jQuery(function($) {
                tabs = $('.tabscontent').tabbedContent({loop: true}).data('api');


                // Next and prev actions
                $('.controls a').on('click', function(e) {
                    var action = $(this).attr('href').replace('#', '');
                    tabs[action]();
                    e.preventDefault();
                });
            });*/
		  	$('.form-ficha').validate();
		}
	};
}());