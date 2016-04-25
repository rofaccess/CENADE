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
	errorPlacement: function (error, element) {
    if (element.parent('.input-group').length) { 
        error.insertAfter(element.parent());      // radio/checkbox?
    } else if (element.hasClass('select2')) {     
        error.insertAfter(element.next('span'));  // select2
    } else {                                      
        error.insertAfter(element);               // default
    }
}
});

// Reglas para las validaciones
$.validator.addClassRules({
	required: {
		required: true,
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

	nameMinLength: {
		minlength: 3
	},

	minLength2: {
		minlength: 2
	},

	minLength3: {
		minlength: 3
	},

	minEmail8: {
		minlength: 8
	},

	minLength4: {
		minlength: 4
	},

	passwordCheck: {
		passwordCheck: true
	},

	emailCheck: {
		emailCheck: true
	},
	telCheck: {
		telCheck: true
	},
	passwordEqual:{
		equalTo: "#user_password"
	},
	horaCheck:{
		hora:true
	}
});


$.validator.addMethod("passwordCheck",function(value,element){
                return this.optional(element) || /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/.test(value);
            },"La contraseña debe contener una combinación de números y letras (minúsculas y mayúsculas).");

$.validator.addMethod("emailCheck",function(value,element){
                return this.optional(element) || /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i.test(value);
            },"El correo debe tener un formato correo@servidor.com");

$.validator.addMethod("telCheck",function(value,element){
                return this.optional(element) || /^[\d\s()+-]+$/.test(value);
            },"Debe tener el formato ej:(0982)256 974");

$.validator.addMethod("hora", function(value, element){
  return value.length == 0 || /^[0-9]{2}:[0-9]{2}$/i.test(value);},
  "Formato hh:mm"); 
