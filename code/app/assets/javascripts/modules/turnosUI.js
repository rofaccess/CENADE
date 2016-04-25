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
		        language: "es",
		        theme: "bootstrap"

		        }).on("select2:select",function(){
 				$(this).valid();
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
		      $(".profesional_select").select2({
		        placeholder: "Seleccione un Profesional",
		        language: "es",
		        theme: "bootstrap"

		        }).on('change', function () {
        			$(this).valid();
        		});
		    $(".area_select").select2({
		        placeholder: "Seleccione un Área",
		        theme: "bootstrap",
		        language: "es"

		        }).on('change', function () {
        			$(this).valid();
        		});
		  
	        $(".paga").on("change", function(){
	          $("#factura").toggle($(this).hasClass("si_paga"));
	        });

	        $('.datepicker').datepicker({
		        format: "dd/mm/yyyy",
		        language: "es",
		        autoclose: true,
		        orientation: "bottom"
		        }).on('change', function() {
        			$(this).valid();
		      	});
		      $('.datepicker2').datepicker({
		        format: "dd/mm/yyyy",
		        language: "es",
		        autoclose: true
		        }).on('change', function() {
        			$(this).valid();
		      	});
		     

			$('#table-turnos').DataTable( {
		        "paging":   false,
		        "info":     false,
		        "searching": false,
		        "columnDefs": [
		            { "visible": false, "targets": 0 },
		            { "visible": false, "targets": 7 }
	        	],
		        "drawCallback": function ( settings ) {
	            var api = this.api();
	            var rows = api.rows( {page:'current'} ).nodes();
	            var last=null;
	 			
	            api.column(0, {page:'current'} ).data().each( function ( group, i ) {
	                if ( last !== group ) {
	                    $(rows).eq( i ).before(
	                        '<tr class="group" bgcolor="#CCCCCC"><td align="center" colspan="7">'+group+'</td></tr>'
	                    );
	 
	                    last = group;
	                }
	            } );
	            api.column(7, {page:'current'} ).data().each( function ( group, i ) {
	                if ( last !== group ) {
	                    $(rows).eq( i ).before(
	                        '<tr class="group" bgcolor="#EFEFEF"><td align="center" colspan="7">'+"Fecha consulta "+group+'</td></tr>'
	                    );
	 
	                    last = group;
	                }
	            } );
	        }
	    	});
		}
	};
}());

