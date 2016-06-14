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
//= require bootstrap-sprockets
//= require jquery_ujs

//= require plugins/jquery-validate-min.js
//= require plugins/jquery-additional-methods-min.js
//= require plugins/jquery-validate-setup.js
//= require plugins/jquery-inputmask.js
//= require plugins/jquery-inputmask-regex-extensions.js
//= require plugins/select2.full.min.js

//= require plugins/jquery.dataTables.js
//= require plugins/loading-overlay-min.js
//= require plugins/bootstrap-datepicker.min.js

//= require plugins/noty/packaged/jquery.noty.packaged.min.js
//= require plugins/noty/layouts/topCenter
//= require plugins/tabbedcontent.min.js
//= require plugins/perfect-scrollbar.jquery.min.js

//= require languages/jquery-validate-messages-es.js
//= require languages/select2-es.js
//= require languages/bootstrap-datepicker.es.min.js

//= require_tree ./modules

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

				$('.buscador').submit();
			}, 500);
			$("#list").LoadingOverlay("hide", true);
		});
    },

    /* Inicializa el la función LoadingOverlay sobre el elemento cuyo clase o id es pasado como parámetro */
    initLoadingOverlay: function(element){
        $(element).LoadingOverlay("show", {
            image       : "",
            fontawesome : "fa fa-refresh fa-spin"
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

        $('input.datepicker').datepicker({
            format: "dd/mm/yyyy",
            language: "es",
            autoclose: true,
            orientation: "bottom",
            todayHighlight: true,
            todayBtn: true,
            startDate: new Date(1900,01,01),
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

    /* Inicia el inputmask para el campo que debe recibir solo números de teléfono
       .tel-only: es la clase del elemento (input) que sólo permitirá numeros de teléfono
    */
    initTelephoneOnly: function(){
        $('.tel-only').inputmask('Regex', { regex: "[\\d\\s()+-]+" });
    },

    /* Inicia el inputmask para el campo que debe recibir solo ruc
       .ruc-only: es la clase del elemento (input) que sólo permitirá ruc
    */
    initRucOnly: function(){
        $('.ruc-only').inputmask('Regex', { regex: "[0-9\-a-z]+" });
    },

    /* Retorna la fecha del sistema en formato 'dd/mm/aa' */
    systemDate: function(){
        var today = new Date();

        var day = today.getDate();
        var month = today.getMonth()+1;
        var year = today.getFullYear();
        //Del 1 al 9 le agrega un cero delante
        if(day<10) day = '0'+ day;
        if(month < 10) month = '0' + month;

        return day+'/'+month+'/'+year;
    },

    /*
        Permite calcular la edad a partir de la fecha de nacimiento y la fecha de hoy
        Recibe un objeto con:
        {
            fecha_nacimiento: el id o clase del objeto jquery (input) que contiene la fecha de nacimiento
            edad: el id o clase del objeto jquery (input) donde se mostrará la edad
        }
    */
    initCalculateAge: function(options){
        $(options.fecha_nacimiento).on('change', function(){
            var today = new Date();

            var day = parseInt(today.getDate());
            var month = parseInt(today.getMonth())+1;
            var year = parseInt(today.getFullYear());



            var fec_nac = $(this).val().split('/');

            var day_nac = parseInt(fec_nac[0]);
            var month_nac = parseInt(fec_nac[1]);
            var year_nac = parseInt(fec_nac[2]);
            var age = year - year_nac;

            if (year_nac < year){
                if(month_nac < month){
                    $(options.edad).val(age);
                }else if(month_nac == month && day_nac <= day){
                    $(options.edad).val(age);
                }else{
                    $(options.edad).val(age -1);
                }
            }else if(year_nac == year){
                 if(month_nac < month){
                    $(options.edad).val(age);
                }else if(month_nac == month && day_nac <= day){
                    $(options.edad).val(age);
                }else{
                    $(options.edad).val('');
                }
            }else{
                $(options.edad).val('');
            }
        });
    },

    /*
        Compara dos strings de fechas con el formato 'dd/mm/aaaa'
        Retorna true si el primero es mayor o igual al segundo caso contrario false
    */
    //- Se puede usar para implementar la validación de nuevo turno, que la fecha de consulta sea mayor o igual a la fecha de expedicion del turno
    compareDate: function(date1, date2){
        var d1 = date1.split('/');
        var day1 = parseInt(d1[0]);
        var month1 = parseInt(d1[1]);
        var year1 = parseInt(d1[2]);

        var d2 = date2.split('/');
        var day2 = parseInt(d2[0]);
        var month2 = parseInt(d2[1]);
        var year2 = parseInt(d2[2]);

        if (year1 > year2){
            return true;
        }else if(year1==year2){
            if(month1 > month2){
                return true;
            }else if(month1 == month2){
                if(day1 >= day2){
                    return true;
                }else{
                    return false;
                }

            }else{
                return false;
            }
        }else{
            return false;
        }
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
            placeholder: options.placeholder,
        });

        /* Valida cuando se elige otro item del select2 */

        $(options.element).on("change", function(){
            $(this).valid();
        });
    },

    /* Inicializa el la función tabbedContent sobre el elemento cuyo clase o id es pasado como parámetro */
    initTabs: function(element){
        $(element).tabbedContent();
    },

    /* Incializa el evento para mostrar y esconder el cuerpo de un panel al hacer
     * click sobre la cabecera del panel
     * .panel-folding: es la clase que deberá tener el div que actua como panel
     */
    initPanelFolding: function(){
        $(".panel-folding > .panel-heading").click(function(){
            $(this).next('.panel-body').toggle();
        });
    },

    /* Incializa el evento para cerrar un mensaje mostrado con el helper
     * message definido en application_helper
     */
    initMessageClose: function(){
        $('.close-message').click(function(){
            $(this).closest('.message').fadeOut();
        });
    },


    /* Envía el q de ransack para que se pueda imprimir solo la lista que se esta filtrando */
    initImprimir: function(params) {
      $('#imprimir-link').attr('href', $('#imprimir-link').data('url') + params.replace('amp;',''));
    },

    /* Ejecuta las funciones especificadas*/
    init: function() {
		APP.initBuscador();
        APP.initAdvancedSearch();
        APP.initDatepicker();
        APP.initMessageClose();
        //APP.initSidebarToogle(); //- Tal vez se use
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

/* CONFIGURACIONES POR DEFECTO PARA VENDORS */

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
    timeout: 10000, // delay for closing event. Set false for sticky notifications
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
