var atencionesProfesionalesUI = (function(){
  return {
    /* Inicia el evento, que permitirá marcar como activo, al paciente seleccionado en el sidebar */
    initCurrentSidebar: function(){
      $('.item-paciente').click(function(){
        APP.initLoadingOverlay(".atencion-content,.atencion-title, .fichas-consultas-content");
        $('.item-paciente').removeClass('active');
        $(this).addClass('active');
      })
    },

    initScript: function(){
      initDatepickerInline();
      initGetTurnos();
      initSetEstadoTurnoToAtendido();

      $('#sidebar-wrapper').perfectScrollbar();
    }
  };
}());

/* FUNCIONES LOCALES */

/*
  Inicia el datepicker en el sidebar de atencion profesional
*/
function initDatepickerInline(){
  $('#datepicker-inline').datepicker({
    language: "es",
  });
}

/* Cuando se selecciona otra fecha en el datepicker del sidebar
   , se realiza la petición para traer los turnos
*/
function initGetTurnos(){
  $('#datepicker-inline').on("changeDate", function(){
      APP.initLoadingOverlay("#pacientes-content");
      getTurnosAjax();
  });
  $('#doctor_id').on("change", function(){
      APP.initLoadingOverlay("#pacientes-content");
      getTurnosAjax();
  });
}

/* Ejecuta la llamada ajax para obtener los turnos */
function getTurnosAjax(){
  $.ajax({
      url: "/atenciones_profesionales/get_turnos",
      type: 'get',
      data: {
        fecha_consulta : $('#datepicker-inline').datepicker('getFormattedDate'),
        doctor_id: $('#doctor_id').val()
      }
    });
}

/* Inicia el evento, que permitirá setear el turno de un paciente como atendido */
function initSetEstadoTurnoToAtendido(){
  $('.icon-pendiente').click(function(e){
    e.preventDefault();
    APP.initLoadingOverlay("#pacientes-content");

    paciente = $(this).attr('paciente');
    var confirm = window.confirm("¿Desea establecer al paciente "+paciente+" como atendido?");
    if (confirm){
      $.ajax({
        url: 'atencion_profesional/set_estado_turno_to_atendido',
        type: 'post',
        dataType: 'script',
        data: {
          turno_id: $(this).attr('turno-id'),
          fecha_consulta : $('#datepicker-inline').datepicker('getFormattedDate'),
          doctor_id: $('#doctor_id').val()
        }
      });
    }else{
      $("#pacientes-content").LoadingOverlay("hide", true);
    }
    return false;
   });
}
