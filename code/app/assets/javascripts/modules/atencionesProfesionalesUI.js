var atencionesProfesionalesUI = (function(){
  return {
    initScript: function(){
      initDatepickerInline();
      initGetTurnos();
      empleadosUI.initBuscarDoctor('#doctor_id',false);

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
      getTurnosAjax();
  });
  $('#doctor_id').on("change", function(){
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
      },
    });
}

/* Inicia el evento, que permitirá setear el turno de un paciente como atendido */
function initSetEstadoTurnoToAtendido(){
  $('.icon-pendiente').click(function(e){
    paciente = $(this).attr('paciente');
    var confirm = window.confirm("¿Desea establecer al paciente "+paciente+" como atendido?");
    if (confirm){
      $.ajax({
        url: 'atenciones_profesionales/setEstadoTurnoToAtendido',
        type: 'post',
        dataType: 'script',
        data: {
          turno_id: $(this).attr('turno-id'),
          fecha_consulta : $('#datepicker-inline').datepicker('getFormattedDate'),
          doctor_id: $('#doctor_id').val()
        }
      });
    }
    e.preventDefault();
   });
}
