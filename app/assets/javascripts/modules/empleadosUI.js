/* FUNCIONES GLOBALES */

var empleadosUI = (function(){
	return {	
		/* Inicia el buscador del select2 en el element dado, para buscar doctores */
		initBuscarDoctor: function(element) {
			$(element).select2({
				ajax: { 
					url: '/doctores/buscar',
					dataType: 'json',
	                delay:300, //Tiempo de espera, antes de comenzar la búsqueda
	                data: function(params){
	                	return {
	                		q: { doctor_cont: params.term }, 
	                	};
	                },

	                processResults: function (data, params) {
	                	return {
	                		results: $.map( data.items, function(doctor, i) { 
	                			return { 
	                				id       : doctor.id, 
	                				text     : doctor.full_name, 
	                				full_name: doctor.full_name,
	                				area     : doctor.area_nombre } 
	                			})			        
	                	};
	                },

	                cache: true        
	            },
	            placeholder: "Buscar por Nom., Ap. o Área",
	  			allowClear: true,    		    //Muestra un icono x para limpiar la opción seleccionada		        
	            minimumInputLength: 2,			//Obliga a escribir un mímimo de dos caracteres antes de realizar la búsqueda	
	  			templateResult: formatDoctor,   //formatDoctor es una función definida más abajo
	  			escapeMarkup: function (markup) { return markup; } 

	  		});
			
			/* Valida cuando se elige otro paciente en el element (select) dado */
	  		$(element).on("change", function(){
				$(this).valid(); 			
			});		
		},

		//Muestra el area si es doctor
		mostrarArea: function(){
			
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

			empleadosUI.mostrarArea();

			$('.ruc').inputmask('Regex', { regex: "[0-9\-a-z]+" });

			$('.ci').inputmask('Regex', { regex: "[0-9]+" });

			$('.costo').inputmask('Regex', { regex: "[0-9]+" });

			$('.telefono').inputmask('Regex', { regex: "[0-9\-\(\),]+" });
			
			$('.edad').inputmask('Regex', { regex: "[0-9]+" });
			
			APP.initDatepicker(); 

		   	//Valida el formulario antes de enviarlo
		  	$('.form-empleado').last().validate();
		}
	};
}());

/* FUNCIONES LOCALES */
/* 
	Da un formato customizado a los datos recibidos	en initBuscarDoctor
	El argumento recibido puede nombrarse de otra forma Ej. En vez de doctor usar doc
*/
function formatDoctor (doctor) {
	if (!doctor.id) { return doctor.text; }

	var $doctor = $('<span>' + doctor.full_name + '<br><strong> Area: </strong>  ' + doctor.area + '</span>');
	
	return $doctor;		
};	