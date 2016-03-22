// Configuraciones generales para las validaciones
jQuery.validator.setDefaults({
	errorElement:	'span',
	errorClass:		'text-error',
	onfocusout: function(element) { $(element).valid(); },
	highlight: function(element){
		$(element).closest('.form-control').addClass('input-error');
		$(element).closest('div').addClass('text-error');
	},
	unhighlight: function(element){
		$(element).closest('.form-control').removeClass('input-error');
		$(element).closest('div').removeClass('text-error');
	},	
	errorPlacement: function(error, element) {
        if (element.attr("id") == "user_username" )  
            error.appendTo('#username-error');
        else if (element.attr("id") == "user_password" )  
            error.appendTo('#password-error');
        else{
        	error.insertAfter(element);  
        	element.focus();  
        }	    
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

	ciLength: {
		minlength: 4
	},

	nameLength: {
		minlength: 3
	},

	passwordCheck: {
		passwordCheck: true
	},

	emailCheck: {
		emailCheck: true
	}
});


$.validator.addMethod("passwordCheck",function(value,element){
                return this.optional(element) || /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/.test(value);
            },"La contraseña debe contener una combinación de números y letras (minúsculas y mayúsculas).");

$.validator.addMethod("emailCheck",function(value,element){
                return this.optional(element) || /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i.test(value);
            },"El correo debe tener un formato correo@servidor.com");

