var controlesUI = (function(){
	return {

		initScript: function(){

			/* Script globales */
	     	APP.initDatepicker();
	     	APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});

	     	pacientesUI.getPaciente({element: '.select-paciente', root: 'controles'});

			/* Valida el formulario antes de enviarlo */
			$('.form-control').validate();
		}
	};
}());