var turnosUI = (function(){
	return {	
		checkPACIENTE: function(checkTurnoPacienteUrl){
			$.validator.addClassRules({
                uniquePACIENTE: {
                    remote: {
                        url: checkTurnoPacienteUrl,
                        type: "get",
                        data: {
                            paciente_id: function() {
                                return $( "#paciente_id" ).val();
                            },
                            id: function() {
                                return $('.turno-id').val();
                            }
                        }
                    }
                }
            });
		},
		

		// Inicia el script en el formulario
		initScript: function(checkTurnoPacienteUrl){
			//turnosUI.getPaciente(addpacienteUrl)
			turnosUI.checkPACIENTE(checkTurnoPacienteUrl);

			$(".nuevo-turno").validate();

			$('.costo').inputmask('Regex', { regex: "[0-9\.]+" });

			$(".paciente_select").select2({
		        placeholder: "Seleccione un paciente",
		        language: "es"

		        }).on("select2:select",function(){
		        id = $(this).val();

		        $.ajax({
		         
		          url: "/turnos/get_paciente",
		          type: 'get',
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

