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

APP = {      
    
    /* Inicializa el evento para actualizar el listado de los index a medida que se tipea en el buscador 
       .buscador : es la clase del elemento (input) que se usa como buscador 
       #list     : es el id del elemento (div) que contiene la lista del index sobre el que se mostrará un icono de cargando
    */
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

    /* Inicializa el evento para mostrar y esconder la búsqueda avanzada presente en algunos index
       #show-advanced-search: es el id del elmento que actúa botón para mostrar y esconder la busqueda avanzada
       #advanced-search     : es el id del elemento (div) que contiene los campos de búsqueda avanzada 
    */
    initAdvancedSearch: function(){
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

    /* Inicializa el evento para mostrar y esconder el sidebar
       #sidebar-toogle: es el id del elmento que actúa botón para mostrar y esconder el sidebar
       #wrapper       : es el id del elemento que actua como sidebar
    */
    initSidebarToogle: function(){
        $("#sidebar-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });   
    },     

    /* Inicia el datepicker
       .datepicker: es la clase del elemento (input) que desplegará el datepicker
    */
    initDatepicker: function(){
        
        $('.datepicker').datepicker({
            format: "dd/mm/yyyy",
            language: "es",
            autoclose: true,
            orientation: "bottom", 
            todayHighlight: true,           
            }).on('change', function() {
                /* Sin lo siguiente, no desaparecen los mensajes de error la primera vez que se selecciona una fecha */
                $(this).valid(); 
            });

        /* Solo permite escribir números y barras en el elemento especificado*/
        $('.datepicker').inputmask('Regex', { regex: "[0-9\/]+" }); 
        /* Muestra dd/mm/aa en el placeholder */
        $('.datepicker').attr('placeholder', 'dd/mm/aaaa');
    }, 

    /* Inicia el inputmask para el campo que debe recibir solo números
       .number-only: es la clase del elemento (input) que sólo permitirá números
    */
    initNumberOnly: function(){
        $('.number-only').inputmask('Regex', { regex: "[0-9]+" }); 
    },

    /*
        Inicializa el select2
        Recibe un objeto con:
        {
            element: el id o clase del objeto jquery sobre el que se va a inicializar el select2 Ej.: .select-paciente, #select-doctor
            placeholder: El texto que se verá en el placeholder del select
        }
    */
    initSelect2: function(options) {        
        $(options.element).select2({
            placeholder: options.placeholder
        });
            
        /* Valida cuando se elige otro item del select2 */
        
        $(options.element).on("change", function(){
            $(this).valid();            
        });    
    },

    /* Ejecuta las funciones especificadas*/
    init: function() {        
		APP.initBuscador();        
        APP.initAdvancedSearch();
        APP.initDatepicker();
        //APP.initSidebarToogle(); //Tal vez se use
    }
};

/* Cuando se carge toda la página se ejecuta la función init */
$( document ).on('ready', APP.init );


/* FUNCIONES INDEMPENDIENTES? */

/* Espera el tiempo especificado antes de ejecutar el contenido (o la función?) de delay */
var delay = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();

/* Envía el q de ransack para que se pueda imprimir solo la lista que se esta filtrando (Actualmente no esta en uso)*/
function configImprimir (params) {
  $('#imprimir-link').attr('href', $('#imprimir-link').data('url') + params.replace('amp;',''));
}

/* CONFIGURACIONES POR DEFECTO PARA PLUGINS */

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

/* Configura el plugin select2 de forma global */
$.fn.select2.defaults.set("theme", "bootstrap"); // Todos usarán el tema bootstrap
$.fn.select2.defaults.set("language", "es");     // Todos usarán lenguaje español