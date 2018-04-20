<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Llena el combo select con los periodos existentes al iniciar la pagina
--->
function obtenerAnios(){
    $.post('admonPeriodos/obtenerAnios', function(data){
    	var thisYear = new Date().getFullYear();
        $("#anioPeriodo").append("<option selected disabled>Seleccione un año</option>");
        for(var i = thisYear+3; i >= 2008; i--){
    		if(jQuery.inArray(i, data.DATA.ANIO) == -1){
    			$("#anioPeriodo").append("<option>"+i+"</option>");
    		}
        }
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Crea un nuevo periodo al seleccionar un año en la modal
--->
function agregarPeriodo(){
    $.post('admonPeriodos/agregarPeriodo',{
        anio: $("#anioPeriodo").val()
    }, function(data){
        if (data > 0){
            obtenerPeriodos();
            reiniciaAniosSelect();
            $("#mdl-nuevoPeriodo").modal('hide');
            toastr.success('exitosamente','Periodo creado');
        } else {
            toastr.error('al crear el periodo','Problema');
        }
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Reinicia la modal que crea nuevos periodos
--->
function reiniciaAniosSelect(){
    $("#anioPeriodo").empty();
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Llena el combo select con los periodos existentes despues de agregar uno nuevo
--->
function obtenerPeriodos(){
    $("#Periodos").empty();
    $.post('admonPeriodos/obtenerPeriodos', function(data){
        $("#Periodos").append("<option selected disabled>Seleccione un periodo</option>");
        for(var i = data.DATA.NOMBRE.length-1; i >= 0 ; i--){
            $("#Periodos").append('<option value="'+data.DATA.PK[i]+'">'+data.DATA.NOMBRE[i]+'</option>');
        }
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Crea la tabla con los formatos de un periodo 
--->
function obtenerFormatos(){
    $("#mensaje").hide();
    $("#tituloFormatos").html("<h5>Formatos registrados del "+$("#Periodos :selected").text().toLowerCase()+"</h5>");
    $.post('admonPeriodos/obtenerFormatos',{
        periodo: $("#Periodos").val()
    }, function(data){
        $('#tablaFormatos').html(data);
        $('#btn-ValidarAll').show();
        $("#lanzaMsj").show();
    });
    cerrarTablaFormato();
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Obtiene un formato para la vista previa del mismo 
--->
function obtenerReporte(pkformato, pkperiodo){
    $('#tablaFormatoVista').html('');
    $.post('admonPeriodos/obtenerReporte', {
        formato: pkformato,
        periodo: pkperiodo
    }, function(data){
        $('#tablaFormatoVista').html(data);
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Crear todos los reportes marcados con un checkbox para un periodo
--->
function crearReportesSeleccionados(){
    if(confirm( '¿Desea crear los reporte seleccionados?')){
        var formatosSelected = $('#tabla-formatos').bootstrapTable('getSelections');
        periodoActual = $("#Periodos :selected").val();
        contadorFormatos = 0;
        for(var i=0; i<formatosSelected.length; i++){
            if(formatosSelected[i].pkperiodo!=periodoActual){
                crearReporte(formatosSelected[i].pkformato, periodoActual);
                contadorFormatos++;
            }
        }
        if (contadorFormatos == 0){
            toastr.warning('seleccionado para validar','Ningún formato');
        }
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Crear un reporte para un periodo
--->
function crearReporte(pkformato, pkperiodo){
    if(confirm( '¿Desea crear el reporte seleccionado?')){
        $.post('admonPeriodos/crearReporte', {
            formato: pkformato,
            periodoNuevo: pkperiodo
        }, function(data){
            if (data > 0){
                obtenerFormatos();
                toastr.success('exitosamente','Formato validado');
            }else {
                toastr.error('al validar el formato','Problema');
            }
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Limpia el panel de la vista previa de un formato
--->
function cerrarTablaFormato(){
    $('#displayNombre').text('');
    $('#displayTrimestre').text('');
    $('#tablaFormatoVista').empty();
    $('#pnl-Formato').slideUp(1000,'easeInExpo');
    $('#box-formatosRegistrados').slideDown(1000,'easeInExpo');
    $('#in-pkFormato').val(0);
    $('#in-pkPeriodo').val(0);
}


<!---
* Fecha      : Enero 2017
* Autor      : Marco Torres
* Descripcion: cambia el estado del reporte
* --->
function cambiarEstadoRT(accion, textoAccion, pkRegistro, nombreFormato, periodoFormato, claveFormato){
    if(confirm( textoAccion+'\n¿Desea realizar esta operacion?')){
        $.post('admonPeriodos/cambiarEstadoPer', {
                accion: accion,
                pkRegistro: pkRegistro,
                nombreFormato: nombreFormato,
                periodoFormato: periodoFormato,
                claveFormato: claveFormato
            }, 
            function(data){
                if (data.EXITO){
                    obtenerFormatos();
                }else if (data.FALLO){
                    alert("El registro ya había sido modificado.");
                }
            }
        );
    }
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

    $("#lanzaMsj").hide();
    $("#mensaje").hide();

    $('#lanzaMsj').on('click', function() {
        $("#mensaje").slideToggle();
    });

    $('#Periodos').on('change', function() {
        obtenerFormatos(); 
    });

    window.actionEvents = {
        'click .validarformato': function (e, value, row, index) {
            crearReporte(row.pkformato, $("#Periodos :selected").val());
            // obtenerFormatos();
        },
        'click .vistaformato': function (e, value, row, index) {
            $('#in-pkFormato').val(row.pkformato);
            $('#in-pkPeriodo').val(row.pkperiodo);
            $('#displayNombre').text(row.nombre);
            $('#displayTrimestre').text($("#Periodos :selected").text().toLowerCase()).css('text-transform', 'capitalize');
            $('#box-formatosRegistrados').slideUp(1000,'easeInExpo');
            $('#pnl-Formato').slideDown(1000,'easeInExpo');
            obtenerReporte(row.pkformato,row.pkperiodo);
        }
    };

});

</script>