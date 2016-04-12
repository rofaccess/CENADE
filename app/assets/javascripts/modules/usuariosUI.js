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

		checkUsername: function(checkUsuarioUsernameUrl){
			$.validator.addClassRules({
                uniqueUsuarioUsername: {
                    remote: {
                        url: checkUsuarioUsernameUrl,
                        type: "get",
                        data: {
                            username: function() {
                                return $( ".username" ).val();
                            },
                            id: function() {
                                return $('#usuario_id').val();
                            }
                        }
                    }
                }
            });
		},	

		init: function(){

			$('body').on('click', '.show-usuario', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});

			// $('body').on('change', '#empleado_id', function(e){
			// 	usuariosUI.cargarEmpleado('usuarios/get_empleado', $(this).val(), '#modal-sm .empleado');
			// });		

		},		

		// Inicia el script en el formulario
		initScript: function(checkUsuarioUsernameUrl){
			usuariosUI.checkUsername(checkUsuarioUsernameUrl);
			$(".form-user").last().validate();

		}
	};
}());

$(function(){
	usuariosUI.init();
});

/*
$(document).on("page:change", function(){
	usuariosUI.init();
})
*/