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
//= require plugins/bootstrap-datepicker/bootstrap-datepicker.js
//= require plugins/bootstrap-datepicker/bootstrap-datepicker.min.js
//= require plugins/bootstrap-datepicker/bootstrap-datepicker.es.min.js

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

/* Nota: La línea anterior carga todos los script, asi que en teoría, no es necesario ćargar el contenido de los modules */

/*
function formatResults(c){
    var markup = ['<li class="ciudad-result">'];
    markup.push(c.nombre);
    markup.push('</br><span>'+c.estado.nombre+', '+c.estado.pais.nombre+'</span>');
    markup.push('</li>');
    return markup.join('');
}

function formatSelectionClient(c){
    return c.nombre;
}
*/

APP = {  

    /* Para que el listado en los index se actualice a medida que se tipea en el buscador*/
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

    /* El evento para mostrar y esconder el sidebar, el elemento debera tener id=sidebar-toggle, todavía no se usa */
    initSidebarToogle: function(){
        $("#sidebar-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });   
    },    

    /* Inicializa el script para mostrar y esconder la búsqueda avanzada presente en algunos index */
    initBusquedaAvanzada: function(){
        var show=true;
        $("#show-advanced-search").click(function(){
            if(show){
                $("#advanced-search").show();
                show=false;
            }else{
                $("#advanced-search").hide();
                show=true;
            }
        });
    },

    /* Inicia el datepicker en el element dado */
    initDatepicker: function(element){
        
        $(element).datepicker({
            format: "dd/mm/yyyy",
            language: "es",
            autoclose: true,
            orientation: "bottom", 
            todayHighlight: true,           
            }).on('change', function() {
                /* Sin lo siguiente, no desaparecen los mensajes de error la primera vez que se selecciona una fecha */
                $(this).valid(); 
            });

        /* Solo permite escribir números y barras */
        $(element).inputmask('Regex', { regex: "[0-9\/]+" }); 

        $(element).attr('placeholder', 'dd/mm/aaaa');
    }, 
    
    init: function() {        
		APP.initBuscador();
        APP.initSidebarToogle();
        APP.initBusquedaAvanzada();

    }
};

/* Espera el tiempo especificado antes de ejecutar el contenido (o la función?) de delay */
var delay = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();

/* Configura el plugin noty de forma global */
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

/* Configura el select2 de forma global */
$.fn.select2.defaults.set("theme", "bootstrap"); // Todos usarán el tema bootstrap
$.fn.select2.defaults.set("language", "es");     // Todos usarán lenguaje español


/* Envía el q de ransack para que se pueda imprimir solo la lista que se esta filtrando (Actualmente no esta en uso)*/
function configImprimir (params) {
  $('#imprimir-link').attr('href', $('#imprimir-link').data('url') + params.replace('amp;',''));
}

/* Cuando se carge toda la página se ejecuta la función init */
$( document ).on('ready', APP.init );
