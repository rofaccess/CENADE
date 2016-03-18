var usuariosUI = (function(){
	return {	
		cargarEmpleado: function(url, id, replace){
			$.ajax({
				url: url,
				type: 'post',
				dataType: 'html',
				data: {id: id},
				success: function(response){
					$(replace).html(response);
				}
			});
		},	

		init: function(){
			$('body').on('change', '#empleado_id', function(e){
				usuariosUI.cargarEmpleado('usuarios/get_empleado', $(this).val(), '#modal-sm .empleado');
			});		
			$('body').on('click', '.show-empleado', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		},		


		// Inicia el script en el formulario
		initScript: function(){

		}
	};
}());

$(function(){
	usuariosUI.init();
});