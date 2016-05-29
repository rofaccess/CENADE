var atencionesProfesionalesUI = (function(){
  return {
    initScript: function(){
      initDatepickerInline();
      getPacientes();
      empleadosUI.initBuscarDoctor('#doctor_id',false);

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

  $('#datepicker-inline').on("changeDate", function() {
    $('#fecha_consulta').val(
      $('#datepicker-inline').datepicker('getFormattedDate')
    );
  });
}

/* Cuando se selecciona otra fecha en el datepicker del sidebar
   , se realiza la petición para traer los pacientes
*/
function getPacientes(){
  $('#datepicker-inline').on("changeDate", function(){
      getPacientesAjax();
  });
  $('#doctor_id').on("change", function(){
      getPacientesAjax();
  });
}

/* Ejecuta la llamada ajax para obtener los pacientes */
function getPacientesAjax(){
  $.ajax({
      url: "/atenciones_profesionales/get_pacientes",
      type: 'get',
      data: {
        fecha_consulta : $('#datepicker-inline').datepicker('getFormattedDate'),
        doctor_id: $('#doctor_id').val()
      },
    });
}