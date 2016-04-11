/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: ES (Spanish; Español)
 */
(function ($) {
	$.extend($.validator.messages, {
		required: "Este campo es obligatorio.",
		uniqueRoleName: "El Rol ya existe ",
		remote: "El Numero ingresado ya existe para este Proveedor.",
		email: "Por favor, escribe una dirección de correo válida",
		url: "Por favor, escribe una URL válida.",
		date: "Por favor, escribe una fecha válida.",
		dateISO: "Por favor, escribe una fecha (ISO) válida.",
		dateITA: "Por favor, escribe una fecha (dd/mm/aaaa) válida.",
		number: "Por favor, escribe un número entero válido.",
		digits: "Por favor, escribe sólo dígitos.",
		creditcard: "Por favor, escribe un número de tarjeta válido.",
		equalTo: "Por favor, escribe el mismo valor de nuevo.",
		accept: "Por favor, escribe un valor con una extensión aceptada.",
		maxlength: $.validator.format("Max {0} Caracteres."),
		minlength: $.validator.format("Por favor, no escribas menos de {0} caracteres."),
		rangelength: $.validator.format("Por favor, escribe un valor entre {0} y {1} caracteres."),
		range: $.validator.format("Por favor, escribe un valor entre {0} y {1}."),
		max: $.validator.format("Por favor, escribe un valor menor o igual a {0}."),
		min: $.validator.format("0 No Permitido."),
		//remote: "El valor ingresado ya existe en la base de datos.",
		//maxlength: $.validator.format("Por favor, no escribas más de {0} caracteres."),
		//min: $.validator.format("Por favor, escribe un valor mayor o igual a {0}.")
	});
}(jQuery));