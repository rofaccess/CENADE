var reportesUI = (function(){
	return {

		datepickerSpecialControl: function(){
			$('.datepickerYear').datepicker( {
			    format: ' yyyy',
			    viewMode: 'years',
			    minViewMode: 'years'
			  });
			},
		datatableControl: function(){

	    	$('#table_reporte').dataTable( {
		        "paging":   false,
		        "info":     false,
		        "searching": false,
		        "columnDefs": [

		            { "visible": false, "targets": 5 }
	        	],
		        "drawCallback": function ( settings ) {
	            var api = this.api();
	            var rows = api.rows( {page:'current'} ).nodes();
	            var last=null;

	            api.column(5, {page:'current'} ).data().each( function ( group, i ) {
	                if ( last !== group ) {
	                    $(rows).eq( i ).before(
	                        '<tr class="group" bgcolor="#EFEFEF"><td align="center" colspan="5">'+group+'</td></tr>'
	                    );

	                    last = group;
	                }
	            } );
	        }
	      });
		},
	datatableControl2: function(){
		$('#table-reporte-anho').dataTable( {
		        "paging":   false,
		        "info":     false,
		        "searching": false,
		        "columnDefs": [

		            { "visible": false, "targets": 4 }
	        	],
		        "drawCallback": function ( settings ) {
	            var api = this.api();
	            var rows = api.rows( {page:'current'} ).nodes();
	            var last=null;

	            api.column(4, {page:'current'} ).data().each( function ( group, i ) {
	                if ( last !== group ) {
	                    $(rows).eq( i ).before(
	                        '<tr class="group" bgcolor="#EFEFEF"><td align="center" colspan="4">'+group+'</td></tr>'
	                    );

	                    last = group;
	                }
	            } );
	        }
	      });
		},

		initScript: function(){

			/* Script globales */
			reportesUI.datepickerSpecialControl();
			reportesUI.datatableControl();
			reportesUI.datatableControl2();
	     	APP.initDatepicker();

		}
	};
}());