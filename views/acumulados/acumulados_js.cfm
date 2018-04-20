<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

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
    });

    function obtenerFormatos(){
        $.post('/index.cfm/acumulados/acumulados/obtenerFormatos',{
            anio: $("#anio").val()
        }, function(data){
            $('#tablaFormatos').html(data);
        });
        cerrarTablaFormato();
    }


    function verAcumulado(pkformato){

        /**************/
        /*$('#in-pkFormato').val(row.pkformato);
        $('#in-pkPeriodo').val(row.pkperiodo);
        $('#displayNombre').text(row.nombre);*/
        $('#displayTrimestre').text($("#Periodos :selected").text().toLowerCase()).css('text-transform', 'capitalize');
        $('#box-formatosRegistrados').slideUp(1000,'easeInExpo');
        $('#pnl-Formato').slideDown(1000,'easeInExpo');
        /*************/

        $('#tablaFormatoVista').html('');
        $.post('/index.cfm/acumulados/acumulados/obtenerReporte', {
            formato: pkformato,
            anio: $("#anio").val()
        }, function(data){
            $('#tablaFormatoVista').html(data);
        });
    }


    function cerrarTablaFormato(){
        $('#displayNombre').text('');
        $('#displayTrimestre').text('');
        $('#tablaFormatoVista').empty();
        $('#pnl-Formato').slideUp(1000,'easeInExpo');
        $('#box-formatosRegistrados').slideDown(1000,'easeInExpo');
        $('#in-pkFormato').val(0);
        $('#in-pkPeriodo').val(0);
    }


</script>