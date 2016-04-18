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
//= require plugins/select2/select2.full.min.js
//= require plugins/select2/i18n/es.js
//= require plugins/jquery.dataTables.js
//= require plugins/loading-overlay-min.js

//= require plugins/noty/jquery.noty
//= require plugins/noty/packaged/jquery.noty.packaged
//= require plugins/noty/layouts/topCenter
//= require plugins/noty/themes/default


//= require languages/jquery-validate-messages-es.js
//= require languages/jquery-ui-datepicker-es.js

//= require modules/empleadosUI
//= require modules/configuracionesUI
//= require modules/usuariosUI
//= require modules/rolesUI

//= require_tree .

APP = {  

    /* Para que el listado se actualice a medida que se tipea */
    initBuscador: function(){
    	$('.buscador').on('keyup', 'input', function () {
			delay(function(){
				$("#list").LoadingOverlay("show", {
    				image       : "",
    				fontawesome : "fa fa-refresh fa-spin"
				});				
				
				setTimeout(function(){},5000); //Quitar esto en producción

				$('.buscador').submit();
			}, 500);
			$("#list").LoadingOverlay("hide", true);
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

$.noty.defaults = {
    layout: 'topCenter',
    theme: 'bootstrapTheme',
    type: 'alert',
    text: '',
    dismissQueue: true, // If you want to use queue feature set this true
    template: '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
    animation: {
        open: {height: 'toggle'},
        close: {height: 'toggle'},
        easing: 'swing',
        speed: 500 // opening & closing animation speed
    },
    timeout: 8000, // delay for closing event. Set false for sticky notifications
    force: false, // adds notification to the beginning of queue when set to true
    modal: false,
    maxVisible: 5, // you can set max visible notification for dismissQueue true option
    closeWith: ['click'], // ['click', 'button', 'hover']
    callback: {
        onShow: function() {},
        afterShow: function() {},
        onClose: function() {},
        afterClose: function() {}
    },
    buttons: false
};



function configImprimir (params) {
  $('#imprimir-link').attr('href', $('#imprimir-link').data('url') + params.replace('amp;',''));
}


$( document ).on('ready', APP.init );
