/* FUNCIONES GLOBALES */

var pacientesUI = (function(){
	return {	

		/* Inicia el buscador del select2 en el element dado, para buscar pacientes */
		initBuscarPaciente: function(element) {
			$(element).select2({
				ajax: { 
					url: '/pacientes/buscar',
					dataType: 'json',
	                delay:300, //Tiempo de espera, antes de comenzar la búsqueda
	                data: function(params){
	                	return {
	                		q: { persona_nombre_or_persona_apellido_or_persona_ci_cont: params.term }, 
	                	};
	                },

	                processResults: function (data, params) {
	                	return {
	                		results: $.map( data.items, function(paciente, i) { 
	                			return { 
	                				id       : paciente.id, 
	                				text     : paciente.persona_full_name, 
	                				full_name: paciente.persona_full_name,
	                				ci 		 :paciente.persona_ci 
	                			} 
	                		})			        
	                	};
	                },

	                cache: true        
	            },
	            placeholder: "Buscar por Nombre, Apellido o CI",
	  			allowClear: true,    		    //Muestra un icono x para limpiar la opción seleccionada		        
	            minimumInputLength: 2,			//Obliga a escribir un mímimo de dos caracteres antes de realizar la búsqueda	
	  			templateResult: formatPaciente, //formatPaciente es una función definida más abajo
	  			escapeMarkup: function (markup) { return markup; } 

	  		});
			
			/* Valida cuando se elige otro paciente en el element (select) dado */
	  		$(element).on("change", function(){
				$(this).valid(); 			
			});		
		},

		/* Cuando se selecciona otro valor en el element (select) dado se ejecuta la acción
		   get_paciente del controlador Pacientes, para que actualize los datos del paciente
		
	        Recibe un objeto con:
	        {
	            element: el id o clase del objeto jquery Ej.: #select_paciente, .select-paciente
	            root   : Indica desde donde se llamó a la acción get_paciente del controlador Pacientes
	            con esto se sabrá donde está el js a ejecutar para recargar los datos del paciente.
	        }
    	*/
		getPaciente: function(options){
			$(options.element).on("change", function(){
				$.ajax({
                 
                  url: "/pacientes/get_paciente",
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

		/*
	      Verifica que un ci especificado para un paciente no exista ya en la base de datos 
	      .ci        : es la clase del elemento (input) que contiene el ci 
	      .persona-id: es la clase del elemento (inputo) que contiene el id de la persona relacionada al paciente
	    */
	    checkPacienteCi: function(){
	     	$.validator.addClassRules({
	     		uniquePacienteCi: {
	     			remote: {
	     				url: "/pacientes/check_ci",
	     				type: "get",
	     				data: {
	     					ci: function() {
                                return $('.ci').val();	
                            },
                            persona_id: function() {
                                return $('.persona-id').val();
                            }
	     				}
	     			}
	     		}
	     	});
	    },
	    /*
	      Verifica si un paciente ya posee una ficha 
	      .paciente-id        : es la clase del elemento (input) que contiene el id del paciente
	      .ficha-id			  : es la clase del elemento (inputo) que contiene el id de la persona relacionada al paciente
	       checkPacienteHasUrl: la url del controlador y acción de ficha correspondiente, Ej.: Si se trata de crear una ficha fonoaudiologica
	       la url corresponda a la acción checkPacienteHasFicha del controlador de ficha fonoaudilógica		
	    */
	    checkPacienteHasFicha: function(checkPacienteHasFichaUrl){
            $.validator.addClassRules({
                uniquePacienteFicha: {
                    remote: {
                        url: checkPacienteHasFichaUrl,
                        type: "get",
                        data: {
                            paciente_id: function() {
                                return $( '.paciente-id' ).val();
                            },
                            id: function() {
                                return $('.ficha-id').val();
                            }
                        }
                    }
                }
            });
        },

		/* Muestra los inputs para encargados dependiendo del checkbox 
		   .checkbox-encargado: es la clase del elemento que se usa como checkbox para mostrar y esconder los campos de encargado	
		*/
		mostrarEncargados: function(){

		   	if ($(".checkbox-encargado").is(":checked")){
		   		tieneEncargados();
		   	}else{
		   		sinEncargados();
		   	} 

		   	$(".checkbox-encargado").change(function() {
		   		if(this.checked) {
		   			tieneEncargados();
		   		}else{
		   			sinEncargados();
		   		}
		   	});
	   	},		

	    /* Para iniciar el script para el formulario de paciente */		
	    initScript: function(){
	     	pacientesUI.checkPacienteCi();
	     	pacientesUI.mostrarEncargados();	     	     				

	     	/* Script globales */
	     	APP.initDatepicker(); 
	     	APP.initNumberOnly();
	     	APP.initTelephoneOnly();
	     	APP.initRucOnly();
	     	APP.initCalculateAge({fecha_nacimiento: '.fecha-nacimiento', edad: '.edad'});

	     	/* Valida el formulario antes de enviarlo */
	     	$('.form-paciente').last().validate();
	    }
	};
 }());

/* FUNCIONES LOCALES */

/* 
	Da un formato customizado a los datos recibidos	en initBuscarPaciente
	El argumento recibido puede nombrarse de otra forma Ej. En vez de paciente usar patient
*/
function formatPaciente (paciente) {
	if (!paciente.id) { return paciente.text; }

	var $paciente = $('<span>' + paciente.full_name + '<br><span class="fa fa-credit-card"> </span>  ' + paciente.ci + '</span>');
	
	return $paciente;		
};	

/* 
	.encargados    : es la clase del elemento (div) que contiene los campos de encargaodos
 	.dato-encargado: es la clase de los campos (input) correspondientes a los datos de encargados 
 */
function tieneEncargados(){
	$('.datos-encargados').show();			
	$('.dato-encargado').attr("disabled",false);	

	//Setea el campo borrar_encargado definido en el formulario	
	$('.borrar-encargado').attr("value","false"); 		
};

/* 
	.encargados    : es la clase del elemento (div) que contiene los campos de encargaodos
 	.dato-encargado: es la clase de los campos (input) correspondientes a los datos de encargados 
 */
function sinEncargados(){
	$('.datos-encargados').hide();			
	$('.dato-encargado').attr("disabled",true);	

	//Setea el campo borrar_encargado definido en el formulario	
	$('.borrar-encargado').attr("value","true");	
};
