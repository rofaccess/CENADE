// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.datepicker
//= require bootstrap-sprockets
//= require jquery_ujs

//= require plugins/jquery-validate-min.js
//= require plugins/jquery-additional-methods-min.js
//= require plugins/jquery-validate-setup.js
//= require plugins/jquery-inputmask.js
//= require plugins/jquery-inputmask-regex-extensions.js


//= require languages/jquery-validate-messages-es.js
//= require languages/jquery-ui-datepicker-es.js

//= require modules/empleadosUI
//= require modules/configuracionesUI
//= require modules/usuariosUI

//= require_tree .

APP = {  

    /* Para que el listado se actualice a medida que se tipea */
    initBuscador: function(){
    	$('.buscador').on('keyup change', 'input', function () {
			delay(function(){
				$("#list").append('<div class="overlay"><i class="fa fa-refresh fa-spin"></i></div>');
					
				delay(function(){}, 500);
				
				$('.buscador').submit();
			}, 500);
		});
    },

    init: function() {        
		APP.initBuscador();

    }
};

var delay = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();


$( document ).on('ready', APP.init );