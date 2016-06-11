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
                            idd: function() {
                                return $('.turno-id').val();
                            }
                        }
                    }
                }
            });
		},

		selectControl: function(){
      pacientesUI.initBuscarPaciente('.select-paciente');

      pacientesUI.getPaciente({element: '.select-paciente', root: 'turnos'});

      APP.initSelect2({element: '.profesional_select', placeholder: 'Seleccione un Profesional'});

      APP.initSelect2({element: '.area_select', placeholder: 'Seleccione un Área'});

		},

		mostrarNroFactura: function(){
			$(".paga").on("change", function(){
	          $("#factura").toggle($(this).hasClass("si_paga"));
	        });
	    },

	    datatableControl: function(){

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
		},

		// Inicia el script en el formulario
		initScript: function(checkTurnoPacienteUrl){
			//turnosUI.getPaciente(addpacienteUrl)
			turnosUI.checkPACIENTE(checkTurnoPacienteUrl);

			turnosUI.selectControl();

			turnosUI.mostrarNroFactura();

			turnosUI.datatableControl();

			APP.initDatepicker();

			$(".nuevo-turno").validate();

			$('.costo').inputmask('Regex', { regex: "[0-9\.]+" });


		      $('.datepicker2').datepicker({
		        format: "dd/mm/yyyy",
		        language: "es",
		        autoclose: true,
		        todayHighlight: true,
                todayBtn: true,
		        }).on('change', function() {
        			$(this).valid();
		      	});
				/* Solo permite escribir números y barras en el elemento especificado*/
		        $('.datepicker2').inputmask('Regex', { regex: "[0-9\/]+" });
		        /* Muestra dd/mm/aa en el placeholder */
		        $('.datepicker2').attr('placeholder', 'dd/mm/aaaa');

		}
	};
}());

