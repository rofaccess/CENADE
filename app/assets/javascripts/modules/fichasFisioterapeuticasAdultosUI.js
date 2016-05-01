var fichasFisioterapeuticasAdultosUI = (function(){
	return {		
		checkPaciente: function(checkPacienteUrl){
			$.validator.addClassRules({
				uniquePaciente: {
					remote: {
						url: "/fichas_fisioteraputicas_adultos/check_paciente_id",
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
			fichasFisioterapeuticasAdultosUI.checkPaciente();				
			APP.initDatepicker()		   	
		   	$('.form-ficha2').validate(); //Valida el formulario antes de enviarlo
 			
 			/* Inicializa el buscador de pacientes */
 			pacientesUI.buscarPaciente('.select-paciente');
 			
 			//buscarPaciente({element: $('.select-paciente'), url: '<%= pacientes_buscar_path%>' });	
			/* Inicializa select2 en Profesionales de Salud */
		   	$(".select-doctor").select2({
				placeholder: "Seleccione un Profesional de Salud"
			}).on("change", function(){
				$(this).valid();
			});



		}
	};
}()); 