var fichasNeurologicasUI = (function(){
	return {

		initScript: function(){

			/* Script globales */
	     	APP.initDatepicker();
	     	APP.initSelect2({element: '.select-paciente', placeholder: 'Seleccione un Paciente'})
	     	APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

	     	pacientesUI.getPaciente({element: '.select-paciente', root: 'compartido/fic_cli_neu_ped'});

			/* Valida el formulario antes de enviarlo */
			$('.form-ficha2').validate();
		}
	};
}());