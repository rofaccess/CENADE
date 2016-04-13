var turnosUI = (function(){
	return {	
		cargarTurno: function(url, id, replace){
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
				

		// Inicia el script en el formulario
		initScript: function(){
			$("#nuevo-turno").last().validate();

		}
	};
}());


$(document).on("page:change", function(){
	turnosUI.init();
})