var consultasUI = (function(){
	return {

		init: function(){
			$('body').on('click', '.show-consulta', function(e){
				$.get($(this).parents('tr').data('url'), {}, function(){}, 'script');
			});
		},

    advancedSearchControl: function(){
          $(".to-hide").hide();

             $(document).ready(function(){
              var show=true;
              $("#show").click(function(){
               if(show){
                  $("#advanced-search").show();
                  show=false;
               }else{
                  $("#advanced-search").hide();
                  show=true;
               }

            });
          });
        },

		selectControl: function(){
            $(".paciente_select").select2({
                placeholder: "Seleccione un paciente",
                language: "es",
                theme: "bootstrap"

               }).on("select2:select",function(){
                $(this).valid();
                id = $(this).val();

                $.ajax({

                  url: "/consultas/get_paciente",
                  type: 'get',
                  data: {
                   id : $(this).val()
                  },
                  success: function(resp){
                      //alert("Data");
                   }

                 });
              });
              $(".profesional_select").select2({
                placeholder: "Seleccione un Profesional",
                language: "es",
                theme: "bootstrap"

                }).on('change', function () {
                    $(this).valid();

                });

        },

		// Inicia el script en el formulario
		initScript: function(){
			consultasUI.selectControl();
      consultasUI.advancedSearchControl();

			$('.datepicker').datepicker({
		        format: "dd/mm/yyyy",
		        language: "es",
		        autoclose: true,
		        orientation: "bottom",
		        theme: "bootstrap"
		        }).on('change', function() {
        			$(this).valid();
		    });

		   	//Valida el formulario antes de enviarlo
		  	$('.nueva-consulta').last().validate();
		}
	};
}());

$(function(){
	consultasUI.init();
});