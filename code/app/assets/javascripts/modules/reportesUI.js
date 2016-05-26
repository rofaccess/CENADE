var reportesUI = (function(){
	return {

		datatableControl: function(){

	    	$('#table-reportes').DataTable( {
		        "paging":   false,
		        "info":     false,
		        "searching": false,
		        "columnDefs": [

		            { "visible": false, "targets": 2 }
	        	],
		        "drawCallback": function ( settings ) {
	            var api = this.api();
	            var rows = api.rows( {page:'current'} ).nodes();
	            var last=null;

	            api.column(2, {page:'current'} ).data().each( function ( group, i ) {
	                if ( last !== group ) {
	                    $(rows).eq( i ).before(
	                        '<tr class="group" bgcolor="#CCCCCC"><td align="center" colspan="2">'+group+'</td></tr>'
	                    );

	                    last = group;
	                }
	            } );
	        }
	      });
		},

		initScript: function(){

			/* Script globales */
			reportesUI.datatableControl();
	     	APP.initDatepicker();

		}
	};
}());