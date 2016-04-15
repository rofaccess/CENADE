var turnosUI = (function(){
	return {	
		

		// Inicia el script en el formulario
		initScript: function(){
			//turnosUI.getPaciente(addpacienteUrl)
			$("#nuevo-turno").last().validate();

			$(".paciente_select").select2({
		        placeholder: "Seleccione un paciente",
		        language: "es"

		        }).on("select2:select",function(){
		        id = $(this).val();

		        $.ajax({
		         
		          url: "/turnos/get_paciente",
		          type: 'post',
		          data: {
		           id : $(this).val()
		          },
		          success: function(resp){
		              //alert("Data");
		           }
		          
		         });
		      });
	        $(".paga").on("change", function(){
	          $("#factura").toggle($(this).hasClass("si_paga"));
	        });
			$('#table-turnos').DataTable( {
	        "paging":   false,
	        "info":     false,
	        "searching": false,
	        "columnDefs": [
	            { "visible": false, "targets": 5 },
	            { "visible": false, "targets": 6 }
        	],
	        "drawCallback": function ( settings ) {
            var api = this.api();
            var rows = api.rows( {page:'current'} ).nodes();
            var last=null;
 
            api.column(5, {page:'current'} ).data().each( function ( group, i ) {
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group" bgcolor="#CCCCCC"><td align="center" colspan="6">'+group+'</td></tr>'
                    );
 
                    last = group;
                }
            } );
            api.column(6, {page:'current'} ).data().each( function ( group, i ) {
                if ( last !== group ) {
                    $(rows).eq( i ).before(
                        '<tr class="group" bgcolor="#EFEFEF"><td align="center" colspan="6">'+group+'</td></tr>'
                    );
 
                    last = group;
                }
            } );
        }
	    	});
		}
	};
}());

