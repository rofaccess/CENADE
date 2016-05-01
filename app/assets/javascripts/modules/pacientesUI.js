var pacientesUI = (function(){
	
	/* 
		Esto le da un formato customizado a los datos recibidos	en buscarPaciente
		El argumento recibido puede nombrarse de otra forma Ej. En vez de paciente usar patient
	*/
	function formatPaciente (paciente) {
		if (!paciente.id) { return paciente.text; }
		 
		  var $paciente = $(
		    '<span>' + paciente.full_name + '<br><span class="fa fa-credit-card"> </span>  ' + paciente.ci + '</span>'
		);
		return $paciente;		
	};		

	return {			

		/* Setea el element dado como buscador de pacientes */
		buscarPaciente: function(element) {
			$(element).select2({
	            ajax: { 
	                url: '/pacientes/buscar',
	                dataType: 'json',
	                delay:300,
	                data: function(params){
	                    return {
	                        q: { persona_cont: params.term }, 
	                    };
	                },
	               
	                processResults: function (data, params) {
				      	return {
					        results: $.map( data.items, function(paciente, i) { 
					            return { id:      	paciente.id, 
					            		 text:      paciente.full_name, 
					            	     full_name: paciente.full_name,
					            	     ci:      	paciente.ci } 
					        })			        
	      				};
	    			},

	    			cache: true        
	            },
	            placeholder: "Buscar por Nombre, Apellido o CI",
	  			allowClear: true,            
	            minimumInputLength: 2,
	  			templateResult: formatPaciente,//formatPaciente es una función definida más arriba
	            escapeMarkup: function (markup) { return markup; } 

	        });		
		},

		/* Valida cuando se elige otro paciente */
		validatePaciente: function(element){
			$(element).on("change", function(){
				$(this).valid(); 			
			});
		},		
			
		/* Muestra los inputs para encargados dependiendo del checkbox */
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

		/* */
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
		
		
		/**
	     *  Verifica que un ci no exista ya en la base de datos 
	     * Recibe un objeto con:
	     * {
	     *   ci: el ci a comprobar
	     *	 persona_id: el id de persona al que esta relacionado el paciente
	     * }
	     */
		checkCi: function(options){
			$.validator.addClassRules({
                uniquePacienteCi: {
                    remote: {
                        url: "/pacientes/check_ci",
                        type: "get",
                        data: {
                            ci: options.ci,
                            persona_id: options.persona_id
                        }
                    }
                }
            });
		},
		
		// Inicia el script en el formulario
		initScript: function(){
			pacientesUI.checkCi({ci: $('#paciente_persona_attributes_ci'), persona_id: $('paciente_persona_attributes_id'});

			pacientesUI.mostrarEncargados();

			// ci, num,costo, edad se debería unificar a un solo regex llamado num establecido en application.js 
			// ya que se usa en muchas partes	
			$('.ruc').inputmask('Regex', { regex: "[0-9\-a-z]+" });

			$('.ci').inputmask('Regex', { regex: "[0-9]+" });

			$('.num').inputmask('Regex', { regex: "[0-9]+" });

			$('.costo').inputmask('Regex', { regex: "[0-9]+" });

			$('.telefono').inputmask('Regex', { regex: "[0-9\-\(\),]+" });
			
			$('.edad').inputmask('Regex', { regex: "[0-9]+" });

			APP.initDatepicker() 
			
		   	//Valida el formulario antes de enviarlo
		  	$('.form-paciente').last().validate();
		}
	};
}());