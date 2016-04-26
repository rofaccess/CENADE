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

        init: function(){   
            $('body').on('click', '.show-role', function(e){
                $.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
            });         
        },  
		initScript: function(checkRoleNameUrl){
			rolesUI.checkNAME(checkRoleNameUrl);
            $(".multiple_select").select2({
              placeholder: "Interfaces disponibles...",
              multiple: true,
              language: "es"

            }).on('change', function () {
                    $(this).valid();
                });
		   	//Valida el formulario antes de enviarlo
		  	$('.nuevo-rol').validate();
		}
	};
}()); 


$(function(){
    rolesUI.init();
});