var empleadosUI = (function(){
	return {		

		init: function(){	
			$('body').on('click', '.show-empleado', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		},		

		//Muestra la especialidad si es doctor
		mostrarEspecialidad: function(){
			
			if ($(".checkbox-doctor").is(":checked")){
				empleadosUI.esDoctor();
			}else{
				empleadosUI.esFuncionario();
			} 
		    	
		    
		    $(".checkbox-doctor").change(function() {
			    if(this.checked) {
			    	empleadosUI.esDoctor();
			    }else{
			    	empleadosUI.esFuncionario();
			    }
			});
		},

		esDoctor: function(){
			$('.to-hide').show();
			
			$('.empleado-select').addClass('required');
			$('.empleado-select').attr("disabled",false);
			
			$('.tipo-empleado').attr("value","Doctor");
			
			$('.especialidad-id').attr("disabled",true);

		},

		esFuncionario: function(){
			$('.to-hide').hide();
			
			$('.empleado-select').removeClass('required');
			$('.empleado-select').attr("disabled",true);

			$('.tipo-empleado').attr("value","Funcionario");	

			$('.especialidad-id').attr("disabled",false);
		},
		
		checkCI: function(checkEmpleadoCIUrl){
			$.validator.addClassRules({
                uniqueEmpleadoCI: {
                    remote: {
                        url: checkEmpleadoCIUrl,
                        type: "get",
                        data: {
                            ci: function() {
                                return $( ".ci" ).val();
                            },
                            id: function() {
                                return $('.empleado-id').val();
                            }
                        }
                    }
                }
            });
		},
		
		// Inicia el script en el formulario
		initScript: function(checkEmpleadoCIUrl){
			empleadosUI.checkCI(checkEmpleadoCIUrl);

			empleadosUI.mostrarEspecialidad();

			$('.ruc').inputmask('Regex', { regex: "[0-9\-a-z]+" });

			$('.ci').inputmask('Regex', { regex: "[0-9\.]+" });

			$('.telefono').inputmask('Regex', { regex: "[0-9\-\(\),]+" });
			
			$('.edad').inputmask('Regex', { regex: "[0-9]+" });

			$('.date').inputmask('Regex', { regex: "[0-9]{2}\/[0-9]{2}\/[0-9]{4}" });
			
		   	//Valida el formulario antes de enviarlo
		  	$('.nuevo-empleado').last().validate();
		}
	};
}());

$(function(){
	empleadosUI.init();
});