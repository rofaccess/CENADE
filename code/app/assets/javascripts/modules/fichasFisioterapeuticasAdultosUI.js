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
			APP.initDatepicker('.datepicker')		   	
		   	$('.form-ficha2').validate(); //Valida el formulario antes de enviarlo

		   	/* Inicializa select2 en pacientes */
		   	
		   	$(".select-paciente").select2({
				placeholder: "Seleccione un Paciente"
			}).on("change", function(){
				$(this).valid();
			});	

			/* Inicializa select2 en Profesionales de Salud */
		   	$(".select-doctor").select2({
				placeholder: "Seleccione un Profesional de Salud"
			}).on("change", function(){
				$(this).valid();
			});



		}
	};
}()); 