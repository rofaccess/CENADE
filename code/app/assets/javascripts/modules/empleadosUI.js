/* FUNCIONES GLOBALES */

var empleadosUI = (function(){
	return {
		/* Inicia el buscador del select2 en el element dado, para buscar doctores
		 * validate true o false, si true se valida  o sino no se valida
		 */
		initBuscarDoctor: function(element,validate) {
			$(element).select2({
				ajax: {
					url: '/doctores/buscar',
					dataType: 'json',
	                delay:300, //Tiempo de espera, antes de comenzar la búsqueda
	                data: function(params){
	                	return {
	                		q: { persona_nombre_or_persona_apellido_or_area_nombre_cont: params.term },
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
	            placeholder: "Buscar Profesional",
	  			//allowClear: true,    		    //Muestra un icono x para limpiar la opción seleccionada
	            minimumInputLength: 2,			//Obliga a escribir un mímimo de dos caracteres antes de realizar la búsqueda
	  			templateResult: formatDoctor,   //formatDoctor es una función definida más abajo
	  			escapeMarkup: function (markup) { return markup; }
	  		});

			/* Valida cuando se elige otro doctor en el element (select) dado */
	  		if (validate) {
	  			$(element).on("change", function(){
					$(this).valid();
				});
	  		}
		},

		/* Muestra el area si es doctor (Profesional de Salud) */
		mostrarArea: function(){
			if ($(".checkbox-doctor").is(":checked")){
				esDoctor();
			}else{
				esFuncionario();
			}

		    $(".checkbox-doctor").change(function() {
			    if(this.checked) {
			    	esDoctor();
			    }else{
			    	esFuncionario();
			    }
			});
		},

		/*
	      Verifica que un ci especificado para un empleado no exista ya en la base de datos
	      .ci        : es la clase del elemento (input) que contiene el ci
	      .persona-id: es la clase del elemento (inputo) que contiene el id de la persona relacionada al empleado
	    */
		checkEmpleadoCi: function(){
			$.validator.addClassRules({
                uniqueEmpleadoCI: {
                    remote: {
                        url: '/empleados/check_ci',
                        type: "get",
                        data: {
                            ci: function() {
                                return $( ".ci" ).val();
                            },
                            idd: function() {
                                return $('.persona-id').val();
                            }
                        }
                    }
                }
            });
		},

		// Para iniciar el script para el formulario de empleado
		initScript: function(){
			empleadosUI.checkEmpleadoCi();
			empleadosUI.mostrarArea();

			// Funciones Globales
			APP.initDatepicker();
			APP.initNumberOnly();
	     	APP.initTelephoneOnly();
	     	APP.initRucOnly();
			APP.initCalculateAge({fecha_nacimiento: '.fecha-nacimiento', edad: '.edad'});

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
function formatDoctor(doctor) {
	if (!doctor.id) { return doctor.text; }

	var $doctor = $('<span>' + doctor.full_name + '<br><strong> Area: </strong>  ' + doctor.area + '</span>');

	return $doctor;
};

/*
	.datos-doctor    : la clase del div que contiene los campos a esconder
 	.dato-encargado: es la clase de los campos (input) correspondientes a los datos de encargados
 */

function esDoctor(){
	$('.datos-doctor').show();

	$('.select-area').addClass('required');
	$('.select-area').attr("disabled",false);

	$('.tipo-empleado').attr("value","Doctor");

	$('.area-id').attr("disabled",true);

};

function esFuncionario(){
	$('.datos-doctor').hide();

	$('.select-area').removeClass('required');
	$('.select-area').attr("disabled",true);

	$('.tipo-empleado').attr("value","Funcionario");

	$('.area-id').attr("disabled",false);
};