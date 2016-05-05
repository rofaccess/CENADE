var psicopedagogicasUI = (function(){
	return {		
		checkPACIENTE: function(checkFichaPsicopedagogicaPacienteUrl){
      $.validator.addClassRules({
          uniquePACIENTE: {
              remote: {
                  url: checkFichaPsicopedagogicaPacienteUrl,
                  type: "get",
                  data: {
                      paciente_id: function() {
                          return $( "#paciente_id" ).val();
                      },
                      id: function() {
                          return $('#psicopedagogica_id').val();
                      }
                  }
              }
          }
      });
    },

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
                 
                  url: "/fichas_psicopedagogicas/get_paciente",
                  type: 'get',
                  data: {
                   id : $(this).val()
                  },
                  success: function(resp){
                      
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

		initScript: function(checkFichaPsicopedagogicaPacienteUrl){
			    psicopedagogicasUI.checkPACIENTE(checkFichaPsicopedagogicaPacienteUrl);

          psicopedagogicasUI.advancedSearchControl();
            
          psicopedagogicasUI.selectControl();
            
            
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