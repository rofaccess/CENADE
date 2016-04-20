var rolesUI = (function(){
	return {		
		checkNAME: function(checkRoleNameUrl){
			$.validator.addClassRules({
                uniqueRoleName: {
                    remote: {
                        url: checkRoleNameUrl,
                        type: "get",
                        data: {
                            name: function() {
                                return $( ".name" ).val();
                            },
                            id: function() {
                                return $('#role_id').val();
                            }
                        }
                    }
                }
            });
		},
		initScript: function(checkRoleNameUrl){
			rolesUI.checkNAME(checkRoleNameUrl);
            $(".multiple_select").select2({
              placeholder: "Interfaces disponibles...",
              multiple: true,
              language: "es"

            });
		   	//Valida el formulario antes de enviarlo
		  	$('.nuevo-rol').validate();
		}
	};
}());