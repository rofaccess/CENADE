var perfilUI = (function(){
	return{

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
                            idd: function() {
                                return $('#usuario_id').val();
                            }
                        }
                    }
                }
            });
		},

		// Inicia el script en el formulario
		initScript: function(checkUsuarioUsernameUrl){
			usuariosUI.checkUsername(checkUsuarioUsernameUrl);
			$(".form-perfil").last().validate();

		}

	}

}());