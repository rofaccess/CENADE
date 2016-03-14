var empleadosUI = (function(){
	return {		

		init: function(){
			

			$('body').on('click', '.show-empleado', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		},		

		//Esconde la especialidad si es doctor
		mostrarEspecialidad: function(){
			
			if ($(".checkbox-doctor").is(":checked")){
				$('.to-hide').show();
				$('.empleado-select').addClass('required');
			}else{
				$('.to-hide').hide();
				$('.empleado-select').removeClass('required');
			} 
		    	
		    
		    $(".checkbox-doctor").change(function() {
			    if(this.checked) {
			        $('.to-hide').show();
			        $('.empleado-select').addClass('required');
			    }else{
			    	$('.to-hide').hide();
			    	$('.empleado-select').removeClass('required');
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
		  	$('.nuevo-empleado').last().validate();
		}
	};
}());

$(function(){
	empleadosUI.init();
});