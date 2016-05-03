var fichasFisioterapeuticasAdultosUI = (function(){
	return {		

		initScript: function(){	
			
			/* Script globales */
	     	APP.initDatepicker();
	     	APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

	     	pacientesUI.initBuscarPaciente('.select-paciente');
	     	//empleadosUI.initBuscarDoctor('.select-doctor');
	     	
			/* Valida el formulario antes de enviarlo */
			$('.form-ficha2').validate(); 
		}
	};
}()); 