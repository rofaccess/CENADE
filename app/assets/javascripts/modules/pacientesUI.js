var pacientesUI = (function(){
	return {		

		/* Muestra el show de paciente al hacer click en el registro de la lista de pacientes (Actualmente no esta en uso) */
		init: function(){	
			$('body').on('click', '.show-paciente', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});			
		},			
			
		//Muestra los inputs para encargados dependiendo del checkbox
		mostrarEncargados: function(){
			
			if ($(".checkbox-encargado").is(":checked")){
				pacientesUI.tieneEncargados();
			}else{
				pacientesUI.sinEncargados();
			} 
		    	
		    
		    $(".checkbox-encargado").change(function() {
			    if(this.checked) {
			    	pacientesUI.tieneEncargados();
			    }else{
			    	pacientesUI.sinEncargados();
			    }
			});
		},

		//

		tieneEncargados: function(){
			$('.to-hide').show();			
			$('.dato-encargado').attr("disabled",false);	

			//Setea el atributo borrar_encargado definido en el formulario	
			$('.borrar-encargado').attr("value","false"); 		
		},

		sinEncargados: function(){
			$('.to-hide').hide();			
			$('.dato-encargado').attr("disabled",true);	

			$('.borrar-encargado').attr("value","true");	
		},
		
		checkCI: function(checkPacienteCIUrl){
			$.validator.addClassRules({
                uniquePacienteCI: {
                    remote: {
                        url: checkPacienteCIUrl,
                        type: "get",
                        data: {
                            ci: function() {
                                return $( ".ci" ).val();
                            },
                            id: function() {
                                return $('.paciente-id').val();
                            }
                        }
                    }
                }
            });
		},
		
		// Inicia el script en el formulario
		initScript: function(checkPacienteCIUrl){
			pacientesUI.checkCI(checkPacienteCIUrl);

			pacientesUI.mostrarEncargados();

			$('.ruc').inputmask('Regex', { regex: "[0-9\-a-z]+" });

			$('.ci').inputmask('Regex', { regex: "[0-9]+" });

			$('.num').inputmask('Regex', { regex: "[0-9]+" });

			$('.costo').inputmask('Regex', { regex: "[0-9]+" });

			$('.telefono').inputmask('Regex', { regex: "[0-9\-\(\),]+" });
			
			$('.edad').inputmask('Regex', { regex: "[0-9]+" });

			APP.initDatepicker('.datepicker') //Definido en application.js
			
		   	//Valida el formulario antes de enviarlo
		  	$('.form-paciente').last().validate();
		}
	};
}());

$(function(){
	pacientesUI.init();
});