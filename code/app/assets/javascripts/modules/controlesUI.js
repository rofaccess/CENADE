var controlesUI = (function(){
	return {
		initAdvancedSearch: function(){
	        var show=true;
	        $("#show-advanced-search").click(function(){
	            if(show){
	                $("#advanced-search2").show();
	                show=false;
	            }else{
	                $("#advanced-search2").hide();
	                show=true;
	            }
	        });
	    },

		initScript: function(){

			/* Script globales */
	     	APP.initDatepicker();
	     	APP.initSelect2({element: '.select-doctor', placeholder: 'Seleccione un Profesional'});
	     	controlesUI.initAdvancedSearch();
	     	pacientesUI.getPaciente({element: '.select-paciente', root: 'controles'});

			/* Valida el formulario antes de enviarlo */
			$('.form-controles').validate();
		}
	};
}());