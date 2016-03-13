var empleadosUI = (function(){
	return {		

		init: function(){
			

			$('body').on('click', '.show-empleado', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		},		

		//Esconde la especialidad si es doctor
		mostrarEspecialidad: function(){
			//Esconde especialidad
		    $('.to-hide').hide();
		    
		    $(".check-doctor").change(function() {
			    if(this.checked) {
			        $('.to-hide').show();
			        $('#empleado_especialidad_id').addClass('required');
			    }else{
			    	$('.to-hide').hide();
			    	$('#empleado_especialidad_id').removeClass('required');
			    }
			});
		},

		// Inicia el script en el formulario
		initScript: function(){

		  	empleadosUI.mostrarEspecialidad();

		  	// Facilita seleccionar una fecha
		  	
		   	$(function() {
		    	$('.datepicker').datepicker();
		  	});
			
		   	//Valida el formulario antes de enviarlo
		  	$('#new_empleado').last().validate();
		}
	};
}());

$(function(){
	empleadosUI.init();
});