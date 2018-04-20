<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene la tabla de los estados relacionados a una ruta.
    --->   
    function consultarEstados(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.getTablaEstados")#</cfoutput>', {
            pkProcedimiento: $("#inProced").val()
        }, function(data){
            $('#tableRutas').html(data);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene las acciones y estados representados en un grafo.
    --->
    function consultarGrafo(id){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.getDatoGrafo")#</cfoutput>', {
            pkRuta: id
        }, function(data){
            $('#divGrafo').html(data);
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.getOpcionesGrafo")#</cfoutput>', {
                pkRuta: id
            }, function(data){
                $('#divOpcionesGrafo').html(data);
                $("#modal-grafo").modal();
            });
        });
    }


    $(document).ready(function() {

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "progressBar": true,
            "preventDuplicates": false,
            "newestOnTop": true,
            "positionClass": "toast-top-right",
            "onclick": null,
            "showDuration": "400",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "2000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        consultarEstados();

        window.actionEvents = {
            'click .route': function (e, value, row, index) {
                window.location = '/index.cfm/adminCSII/admonEdos/admonEdos/setEstados?pkRuta='+ row.id + '&pkProced='+ $("#inProced").val();
            },
            'click .relation': function (e, value, row, index) {
                window.location = '/index.cfm/adminCSII/admonEdos/admonEdos/setRelaciones?pkRuta='+ row.id + '&pkProced='+ $("#inProced").val();
            },
            'click .grafo': function (e, value, row, index) {
                consultarGrafo(row.id);
            }

        };

    });

</script>