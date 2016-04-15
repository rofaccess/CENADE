var pacientesUI = (function(){
	return {		

		init: function(){	
			$('body').on('click', '.show-paciente', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});			
		},			
			
		//Muestra los encargados si es menor
		mostrarEncargados: function(){
			
			if ($(".checkbox-menor").is(":checked")){
				pacientesUI.esDoctor();
			}else{
				pacientesUI.esFuncionario();
			} 
		    	
		    
		    $(".checkbox-doctor").change(function() {
			    if(this.checked) {
			    	pacientesUI.esDoctor();
			    }else{
			    	pacientesUI.esFuncionario();
			    }
			});
		},

		esDoctor: function(){
			$('.to-hide').show();
			
			$('.empleado-select').addClass('required');
			$('.empleado-select').attr("disabled",false);
			$('.costo').attr("disabled",false);
			
			$('.tipo-empleado').attr("value","Doctor");
			
			$('.area-id').attr("disabled",true);

		},

		esFuncionario: function(){
			$('.to-hide').hide();
			
			$('.empleado-select').removeClass('required');
			$('.empleado-select').attr("disabled",true);
			$('.costo').attr("disabled",true);

			$('.tipo-empleado').attr("value","Funcionario");	

			$('.area-id').attr("disabled",false);
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

			//pacientesUI.mostrarEncargados();

			$('.ruc').inputmask('Regex', { regex: "[0-9\-a-z]+" });

			$('.ci').inputmask('Regex', { regex: "[0-9]+" });

			$('.costo').inputmask('Regex', { regex: "[0-9]+" });

			$('.telefono').inputmask('Regex', { regex: "[0-9\-\(\),]+" });
			
			$('.edad').inputmask('Regex', { regex: "[0-9]+" });

			$('.date').inputmask('Regex', { regex: "[0-9]{2}\/[0-9]{2}\/[0-9]{4}" });
			
		   	//Valida el formulario antes de enviarlo
		  	$('.form-paciente').last().validate();
		}
	};
}());

$(function(){
	pacientesUI.init();
});