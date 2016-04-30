var fichasFisioterapeuticasAdultosUI = (function(){
	return {		
		checkPaciente: function(checkPacienteUrl){
			$.validator.addClassRules({
				uniquePaciente: {
					remote: {
						url: checkPacienteUrl,
						type: "get",
						data: {
							paciente_id: function() {
								return $( "#paciente_id" ).val();
							},
							id: function() {
								return $('#ficha_fisioterapeutica_adulto_id').val();
							}
						}
					}
				}
			});
		},
		initScript: function(checkPacienteUrl){
			fichasFisioterapeuticasAdultosUI.checkPaciente(checkPacienteUrl);
           /*
           $(".select-paciente").select2({
            placeholder: "Seleccione un paciente",
            language: "es",
            theme: "bootstrap"

	        }).on("select2:select",function(){
	            $(this).valid();
	            id = $(this).val();

	            $.ajax({

	              url: "/fichas_fisioterapeuticas_adultos/get_paciente",
	              type: 'get',
	              data: {
	               id : $(this).val()
	           },
	           success: function(resp){
	                      //alert("Data");
	                  }
	                  
	              });
	        });
				*/
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
					$(this).valid(); //onchange creo que sera mejor
				});

				APP.initDatepicker('.datepicker')

		   	//Valida el formulario antes de enviarlo
		   	$('.form-ficha2').validate();
		   }
		};
	}()); 