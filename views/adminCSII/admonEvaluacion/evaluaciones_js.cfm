<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

function setAccion(value, row, index) {
    return [
        '<button class="btn btn-primary eliminar-aspecto" data-tooltip="tooltip" title="Eliminar Aspecto"> <i class="fa fa-trash"></i> </button>'
    ].join('');
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


    $('#fchFin').datepicker({
        dateFormat: "dd/mm/yy",
        language: 'es',
        calendarWeeks: true,
        autoclose: true,
        startDate: '+1d',
        minDate: '+1d',
        todayHighlight: true,
        changeMonth: true,
        changeYear: true
    });

    $('#fchIni').datepicker({
        dateFormat: "dd/mm/yy",
        language: 'es',
        calendarWeeks: true,
        autoclose: true,
        startDate: '+1d',
        minDate: '+1d',
        todayHighlight: true,
        changeMonth: true,
        changeYear: true
    });

    $("#ordenarElementos").sortable();


    $("#valida-agrega-evaluacion").validate({
        rules: {
            nombre:         "required",
            fchIni:          {required: true},
            fchFin:          {required:true}
        },
        submitHandler: function(form){
            return false;
        }
    });

    $('#valida-agrega-aspectos').validate({
        rules: {
            nomAspec: { required: true },
            escalaAspec: { required: true }            
        },
        submitHandler: function(form){
            return false;
        }
    });

    

    $('#tabla-agregar-aspectos').bootstrapTable('hideColumn', 'pk');
    $('#tabla-agregar-aspectos').bootstrapTable('hideColumn', 'num');
    $('#tabla-agregar-aspectos').bootstrapTable('hideColumn', 'keyEscala');
    $("#btn-agregar-aspecto").click(function(){
        var textoEscala = $("#escalaAspec option:selected").text();
        var numRows = $('#tabla-agregar-aspectos').bootstrapTable('getOptions').totalRows;
        var nombreAspecto = $("#nomAspec").val();
        if($('#valida-agrega-aspectos').valid()){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.guardarAspecto")#</cfoutput>', {
                nombreAsp:         nombreAspecto.toUpperCase(),
                ordenAsp:          numRows + 1,
                seccion:           $("#campoPkSeccion").val(),
                escala:            $("#escalaAspec").val(),
                evaluacion:        $("#inEvaluacion").val()
            },function(data){
                if (!isNaN(parseInt(data))){
                    toastr.success('Guardado exitosamente','Aspecto');
                    $("#tabla-agregar-aspectos").bootstrapTable('insertRow', {
                        index: numRows + 1,
                        row: {
                            num: numRows,
                            nombre: nombreAspecto,
                            escala: textoEscala,
                            pk: data,
                            keyEscala: $("#escalaAspec").val(),
                            orden: numRows + 1
                        }
                    });
                    $("#ordenarElementos").append("<li>" + nombreAspecto + "</li>");
                }else {
                    toastr.error('Hubo un problema en el guardado','Campo');
                }
            });

            $("#nomAspec").val('');
            $("#escalaAspec").val('');
        }
    });

    $("#btnBGuardarOrdenElmentos").click(function(){
        var aux = 0;
        if($("#campoPkSeccion").val() == ''){
            var contenidoCelda = $("#tabla-eval").bootstrapTable('getData');
        }else{
            var contenidoCelda = $("#tabla-agregar-aspectos").bootstrapTable('getData');
            aux = 1;
        }
        $('#ordenarElementos li').each(function(indice, elemento){
            for(var i=0;i<contenidoCelda.length;i++){
                if(contenidoCelda[i].nombre == $(elemento).text()){
                    var cambiarOrd = indice + 1;
                    contenidoCelda[i].orden = cambiarOrd;
                    break;
                }
            }
        });
        toastr.error('Hubo un problema en el guardado',JSON.stringify(contenidoCelda));
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.actualizarOrdenElemento")#</cfoutput>', {
            lista:                       JSON.stringify(contenidoCelda),
            tipoTabla:                        aux
        },function(data){
            if(aux == 1){
                for(var i=0;i<contenidoCelda.length;i++){
                    $("#tabla-agregar-aspectos").bootstrapTable('updateByUniqueId', {
                        id: contenidoCelda[i].num,
                        row: {
                            orden: contenidoCelda[i].orden
                        }
                    });
                }
                $("#mdl-agregar-campos").css('opacity', 1);
            }else
                actualizarTablaSecciones();
        });
        $('#modal-CambiarOrden').modal('hide');
    });


    $("#inEvaluacion").change(function(){
        $("#ordenarElementos li").remove();
        if (($('#inEvaluacion').val()) > 0){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.obtenSecciones")#</cfoutput>', {
                pkEvaluacion:         $('#inEvaluacion').val()
            },function(data){
                $('#tabla-seccionEval').html(data);
                cambiarOrden();
            });
        }else {
            toastr.error('Hubo un problema en la actualización','Campo');
        }        
    });


    window.actionEvents = {
        'click .eliminar-aspecto': function (e, value, row, index) {
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.eliminarAsp")#</cfoutput>', {
                Asp:         row.pk
            },function(data){
                $("#tabla-agregar-aspectos").bootstrapTable('removeByUniqueId', row.num);
            });
        },
        'click .editar-seccion': function (e, value, row, index){
            modalAgregarCampos(row.pk, row.nombre);
        },
        'click .eliminar-seccion': function (e, value, row, index){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.eliminarSeccion")#</cfoutput>', {
                Seccion:         row.pk
            },function(data){
                actualizarTablaSecciones();
            });
        }
    }

});

function limpiarCamposEditarAspectos(){
    $("#ordenarElementos li").remove();
    $("#campoPkSeccion").val('');
    $("#nomAspec").val('');
    $("#escalaAspec").val('');
    $("#tabla-agregar-aspectos").bootstrapTable('removeAll');
    cambiarOrden();
}

function limpiarCamposAgregarEval(){    
    $("#nombre").val('');
    $("#fchIni").val('');
    $("#fchFin").val('');
}

function modalAgregarEvaluacion(){
    limpiarCamposAgregarEval();
    $("#mdl-admon-evaluacion").modal('show');
}

function modalAgregarSeccion(){
    $("#nomSecc").val('');
    $("#modal-Agregar-Seccion").modal('show');
}

function modalOpacidadAspectos(){
    $("#mdl-agregar-campos").css('opacity', 1);
}

function modalAgregarCampos(pkSeccion, nombreSeccion){
    $("#ordenarElementos li").remove();
    $("#mdl-agregar-campos .modal-title").html("SECCION: " + nombreSeccion);
    $("#campoPkSeccion").val(pkSeccion);
    agregarAspectos(pkSeccion);
    $("#mdl-agregar-campos").modal('show');
}

function agregarAspectos(pkSeccion){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.cargaAspectos")#</cfoutput>', {
        pkSecc:         pkSeccion
    },function(data){
        if(data.ROWCOUNT > 0){
            var nombre="";
            for(var i=0;i<data.ROWCOUNT;i++){
                nombre = data.DATA.NOMASP[i];
                $("#tabla-agregar-aspectos").bootstrapTable('insertRow', {
                    index: $('#tabla-agregar-aspectos').bootstrapTable('getOptions').totalRows + 1,
                    row: {
                        num: $('#tabla-agregar-aspectos').bootstrapTable('getOptions').totalRows,
                        nombre: nombre,
                        pk: data.DATA.PKASP[i],
                        escala: data.DATA.NOMESCL[i],
                        orden: data.DATA.ORDA[i]
                    }
                });
            }
            cambiarOrden();
        }else{
            toastr.error('No se Encontraron Aspectos en la Seccion','Aspecto');
        }
    });
}

function modalCambiarOrden(){
    $("#modal-CambiarOrden").modal('show');
    if($("#campoPkSeccion").val() != '')
        $("#mdl-agregar-campos").css('opacity', 0.2);
}

function cambiarOrden(){
    if($("#campoPkSeccion").val() == ''){
        $("#modal-CambiarOrden .modal-title").html("Modal para Modificar las Secciones de la Encuesta: " + $('#inEvaluacion option:selected').text());
        var filasSecciones = $("#tabla-eval").bootstrapTable('getData');
        for(var i=0;i<filasSecciones.length;i++)
            $("#ordenarElementos").append("<li>" + filasSecciones[i].nombre + "</li>");
    }else{
        $("#modal-CambiarOrden .modal-title").html("Modal para Modificar los Aspectos de la Seccion: ");
        var filasSecciones = $("#tabla-agregar-aspectos").bootstrapTable('getData');
        for(var i=0;i<filasSecciones.length;i++)
            $("#ordenarElementos").append("<li>" + filasSecciones[i].nombre + "</li>");
    }
}

function actualizarTablaSecciones(){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.obtenSecciones")#</cfoutput>', {
        pkEvaluacion:         $('#inEvaluacion').val()
    },function(data){
        $('#tabla-seccionEval').html(data);
    });
}

function guardarSeccion(){
    var nomSecc = $("#nomSecc").val();
    if(nomSecc == "")
        $("#nomSecc").focus();
    else{
        $("#modal-Agregar-Seccion").modal('hide');
        var numTotTablaSecc = $('#tabla-eval').bootstrapTable('getOptions').totalRows + 1;
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.guardarSeccion")#</cfoutput>', {
                nombreSecc:         nomSecc.toUpperCase(),
                ordenSecc:          numTotTablaSecc,
                fkEvaluacion:       $("#inEvaluacion").val()
            },function(data){
                if (!isNaN(parseInt(data))){
                    toastr.success('Guardada exitosamente','Seccion');
                    $("#tabla-eval").bootstrapTable('insertRow', {
                        index: numTotTablaSecc,
                        row: {
                            numero: numTotTablaSecc - 1,
                            nombre: nomSecc,
                            pkSeccion: data,
                            orden: numTotTablaSecc
                        }
                    });
                    $("#ordenarElementos").append("<li>" + nomSecc + "</li>");
                }else {
                    toastr.error('Hubo un problema en el guardado','Seccion');
                }
            }
        );
    }
}

function guardarEvaluacion(){
    if($('#valida-agrega-evaluacion').valid()){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEvaluacion.admonEvaluacion.guardaEvaluacion")#</cfoutput>', {
                nombre:         $('#nombre').val(),
                fechaIni:       $('#fchIni').val(),
                fechaFin:       $('#fchFin').val()
            },function(data){
                if (!isNaN(parseInt(data))){
                    toastr.success('Guardada exitosamente','Evaluacion');
                    limpiarCamposAgregarEval();
                    $("#mdl-admon-evaluacion").modal('hide');
                }else {
                    toastr.error('Hubo un problema en el guardado','Evaluacion');
                }
            }
        );
    }
}

</script>