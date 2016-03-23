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

			$('body').on('click', '.show-usuario', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			$('body').on('change', '#empleado_id', function(e){
				usuariosUI.cargarEmpleado('usuarios/get_empleado', $(this).val(), '#modal-sm .empleado');
			});		

		},		


		// Inicia el script en el formulario
		initScript: function(){
			$("#new_user").last().validate();

		}
	};
}());

$(function(){
	usuariosUI.init();
});


$(document).on("page:change", function(){
	usuariosUI.init();
})