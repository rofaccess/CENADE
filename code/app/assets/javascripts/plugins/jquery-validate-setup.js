// Configuraciones generales para las validaciones
jQuery.validator.setDefaults({
	errorElement:	'span',
	errorClass:		'text-warning',
	onfocusout: function(element) { $(element).valid(); },
	highlight: function(element){
		$(element).closest('.form-control').addClass('input-warning');
	},
	success: function(element){
		$(element).closest('.form-group').removeClass('input-warning');
	},
	errorPlacement: function(error, element) {
        if (element.attr("id") == "user_username" )  
            error.appendTo('#username-error');
        if (element.attr("id") == "user_password" )  
            error.appendTo('#password-error');
    }
});


// Reglas para las validaciones
$.validator.addClassRules({
	required: {
		required: true
	},
	date: {
		dateITA: true
	},
	shortString: {
		maxlength: 50
	},
	mediumString: {
		maxlength: 150
	},
	longString: {
		maxlength: 250
	},
	
	passwordLength: {
		maxlength: 20,
		minlength: 8
	},

	passwordCheck: {
		passwordCheck: true
	}
});


$.validator.addMethod("passwordCheck",function(value,element){
                return this.optional(element) || /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/.test(value);
            },"La contraseña debe contener una combinación de números y letras (minúsculas y mayúsculas).");
