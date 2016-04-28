var fisioNinosUI = (function(){
	return {		
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
                            id: function() {
                                return $('#ficha_fisioterapia_nino_id').val();
                            }
                        }
                    }
                }
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
              $(".profesional_select").select2({
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
                });
           
        },

		initScript: function(checkFisioNinoPacienteUrl){
		   fisioNinosUI.checkPACIENTE(checkFisioNinoPacienteUrl);
            
           fisioNinosUI.selectControl();

            $('.datepicker').datepicker({
                format: "dd/mm/yyyy",
                language: "es",
                autoclose: true,
                orientation: "bottom"
                }).on('change', function() {
                    $(this).valid();
                });
		   	//Valida el formulario antes de enviarlo
		  	$('.nueva-ficha').validate();
		}
	};
}()); 