var psicopedagogicasUI = (function(){
	return {		
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
        },

		initScript: function(){
			    /* Script globales */
        APP.initDatepicker();
        APP.initSelect2({element: '.profesional_select', placeholder: 'Seleccione un Profesional'});         
        APP.initSelect2({element: '.profesional_select', placeholder: 'Seleccione un Profesional'});

        //psicopedagogicasUI.checkPACIENTE(checkFichaPsicopedagogicaPacienteUrl);
        psicopedagogicasUI.selectControl();
            
            
           
		   	//Valida el formulario antes de enviarlo
		  	$('.nueva-ficha').validate();
		}
	};
}()); 