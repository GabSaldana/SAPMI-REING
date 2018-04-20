<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">
    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Funcion que obtiene la tabla con los procedimientos disponibles.
    ---> 
function consultarProcedimientos(){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.obtenerProced")#</cfoutput>', function(data){
        $('#procedimientos').html( data );
    });
}
    
<!---
* Fecha: Noviembre de 2016
* @author SGS
* Descripcion: Consulta las operaciones de los procedimientos
--->
function consultarOperaciones(pkProcedimiento){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.setTablaOpe")#</cfoutput>', {pkProcedimiento: pkProcedimiento}, function(data){
        $("#mdl-operaciones").modal('show');
        $('#tablaOpe').html(data);
    });
}

<!---
* Fecha: Noviembre de 2016
* @author SGS
* Descripcion: Agrega una nueva operacion
--->
function addOperacion(){
    if ($("#nuevaOperacion").valid()){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.addOperacion")#</cfoutput>', {
            oper: $("#inOperacion").val(),
            desc: $("#inDescripcion").val(),
            proced: $("#inProced").val()
        }, function(data){
            if (data > 0){
                consultarOperaciones($("#inProced").val());
                $("#nuevaOperacion")[0].reset();
                toastr.success('Exitosamente','Operación Agregada');
            }
        });
    }
}

<!---
* Fecha: Noviembre de 2016
* @author SGS
* Descripcion: Cambia el estado de una operacion
--->
function cambiarEstadoOperacion(){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.cambiarEdoOper")#</cfoutput>', {
        pkOper: $("#inPkOper").val() 
    }, function(data){
        if (data > 0){
            limpiaOpacidadModal();
            consultarOperaciones($("#inProced").val());
            toastr.success('eliminada exitosamente','Operación');
        }else {
            toastr.error('al eliminar relación','Problema');
        }
    });
}

<!---
* Fecha: Noviembre de 2016
* @author SGS
* Descripcion: Limpia el modal que agrega operaciones nuevas al cerrarlo
--->
function limpiaModal(){
    $("#mdl-operaciones").modal('hide');
    $("#inOperacion").removeClass("error");
    $("#inOperacion-error").remove();
    $("#inDescripcion").removeClass("error");
    $("#inDescripcion-error").remove();
    $("#nuevaOperacion")[0].reset();
}

<!---
* Fecha: Noviembre de 2016
* @author SGS
* Descripcion: Limpia el modal que agrega operaciones nuevas al cerrar el modal de confirmacion
--->
function limpiaOpacidadModal(){
    $("#mdl-confirma").modal('hide');
    $("#mdl-operaciones").css('filter', '');
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

    $("#nuevaOperacion").validate({
        rules: {
            inOperacion:   {required: true, maxlength: 30},
            inDescripcion: {required: true, maxlength: 60}
        },
        submitHandler: function(form){
            return false;
        }
    });

    window.actionEvents = {
        'click .route': function (e, value, row, index) {
            window.location = '/index.cfm/adminCSII/admonEdos/admonEdos/setRutas?pkProcedimiento='+ row.id;
        },
        'click .oper': function (e, value, row, index) {
            $("#inProced").val(row.id);
            consultarOperaciones(row.id);
        },
        'click .borrar': function (e, value, row, index) {
            $("#mdl-confirma").modal('show');
            $("#mdl-operaciones").css('filter', 'brightness(70%)');
            $("#inPkOper").val(row.id);
            $("#mdl-confirma .modal-body").html('¿Seguro que quiere eliminar la operación?'+ '<br><br>' + '<strong>Nombre:</strong> '+ row.nombre + '<br>' + '<strong>Descripción:</strong> '+ row.descripcion);
        }
    };    

    consultarProcedimientos();

});

</script>