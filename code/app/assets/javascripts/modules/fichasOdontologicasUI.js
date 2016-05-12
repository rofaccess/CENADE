var fichasOdontologicasUI = (function(){
	return {

		initScript: function(){

			/* Script globales */
	     	APP.initDatepicker();
	     	APP.initTelephoneOnly();
	     	APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'})
	     	APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

	     	//pacientesUI.initBuscarPaciente('.select-paciente');
	     	//empleadosUI.initBuscarDoctor('.select-doctor');

	     	pacientesUI.getPaciente({element: '.select-paciente', root: 'fichas_odontologicas'});

			/* Valida el formulario antes de enviarlo */
			$('.form-ficha2').validate();
		}
	};
}());