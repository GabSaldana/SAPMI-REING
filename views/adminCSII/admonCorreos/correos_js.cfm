<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Consulta los correos existentes
--->
function consultarCorreos(){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerCorreos")#</cfoutput>', function(data){
        $('#correos').html(data);
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Edita un correo
--->
function editarCorreo(pkCorreo){
    $('#pnl-ncorreo').slideDown(1000,'easeOutExpo');
    $('#cajaCorreos').slideUp(1000,'easeOutExpo');
    $("#inEtiContenido").prop("disabled",false);
    $("#botonAgregarEti").prop("disabled",false);
    $('#info').html('<strong>Información!:</strong> Las etiquetas deben escribirse en minusculas y sin espacios');
    if (pkCorreo > 0){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerBody")#</cfoutput>', {pkCorreo: pkCorreo}, function(data){
            $("#inPkBody").val(data.DATA.PK_BODY[0]);
            tinyMCE.get("inContentCorreo").setContent(data.DATA.BODY[0]);
            pkBody=data.DATA.PK_BODY[0];
            pkHead=data.DATA.PKHEAD[0];
            pkFoot=data.DATA.PKFOOT[0];
            obtienePlantillas(pkHead,pkFoot,pkBody);
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion:  Agrega un correo si el valor de #inPkCorreoNuevo es igual a 0
                Edita un correo si el valor de #inPkCorreoNuevo es mayor a 0
--->
function agregarCorreo(){
    head = $('#carruselHeader').find('.slick-active').children().val();
    foot = $('#carruselFooter').find('.slick-active').children().val();
    if ($("#nuevoCorreo").valid() && $("#inPkCorreoNuevo").val()==0){        
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.agregarCorreo")#</cfoutput>', {
            nombre: $("#inCorreo").val(),
            desc: $("#inCorreoDesc").val(),
            nombreContenido: 'Cuerpo del correo "' + $("#inCorreo").val() + '"',
            contenido: tinyMCE.get("inContentCorreo").getContent(),
            pkHead: $("#pkPlantHead" + head).val(),
            pkFoot: $("#pkPlantFoot" + foot).val()
        }, function(data){
            if (data > 0){
                $('#pnl-ncorreo').slideUp(1000,'easeOutExpo');
                $('#cajaCorreos').slideDown(1000,'easeOutExpo');
                limpiaPanelCorreo();
                $("#nuevoCorreo")[0].reset();
                toastr.success('Exitosamente','Correo Agregado');
                consultarCorreos();
            }
            else {
                toastr.error('al crear correo','Problema');
            }
        });
    } else if ($("#nuevoCorreo").valid() && $("#inPkCorreoNuevo").val()>0){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.editarCorreo")#</cfoutput>', {
            pk: $("#inPkCorreoNuevo").val(),
            nombre: $("#inCorreo").val(),
            desc: $("#inCorreoDesc").val(),
            nombreContenido: 'Cuerpo del correo "' + $("#inCorreo").val() + '"',
            contenido: tinyMCE.get("inContentCorreo").getContent(),
            pkHead: $("#pkPlantHead" + head).val(),
            pkFoot: $("#pkPlantFoot" + foot).val()
        }, function(data){
            if (data > 0){
                $('#pnl-ncorreo').slideUp(1000,'easeOutExpo');
                $('#cajaCorreos').slideDown(1000,'easeOutExpo');
                limpiaPanelCorreo();
                $("#nuevoCorreo")[0].reset();
                toastr.success('Exitosamente','Correo Editado');
                consultarCorreos();
            }
            else {
                toastr.error('al crear correo','Problema');
            }
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Obtiene la vista previa de un correo
--->
function vistaCorreo(pkCorreo){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerVistaCorreo")#</cfoutput>', {pkCorreo: pkCorreo}, function(data){
        $('#vista').html(data.DATA.HEADER[0] + '<br>' + data.DATA.BODY[0] + '<br><br>' + data.DATA.FOOTER[0]+ '<br><br>');
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Cambia el estado de un correo
--->
function cambiarEstadoCorreo(){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.cambiarEstadoCorreo")#</cfoutput>', {
        pk: $('#inPkCorreo').val()
    }, function(data){
        if (data > 0){
            consultarCorreos();
            toastr.success('Eliminado Exitosamente','Correo');
        }else {
            toastr.error('al eliminar correo','Problema');
        }
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Obtiene las plantillas de cabecera y pie de pagina existentes para la modal en la que se crea un correo
--->
function obtienePlantillas(pkHead,pkFoot,pkBody){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtieneHeaderCarrusel")#</cfoutput>', {pkHead:pkHead}, function(data){
        for (var i = 0; i < data.DATA.HEADER.length; i++) {
            $('#carruselHeader').slick('slickAdd','<div style="background-color:#ffffff; padding:5px; border:solid 1px #e6e6e6; height:200px;"><input id="pkPlantHead' + data.DATA.PK[i] + '" type="hidden" value="' + data.DATA.PK[i] + '"><br>' + data.DATA.HEADER[i] + '<br></div>');
        }
        if(pkHead<=0){
            $('#carruselHeader').slick('slickGoTo', 0);
        }else{
            $('#carruselHeader').slick('slickGoTo', $('#pkPlantHead'+pkHead).parent().attr("data-slick-index"));
        }
    });
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtieneFooterCarrusel")#</cfoutput>', {pkFoot:pkFoot}, function(data){
        for (var j = 0; j < data.DATA.FOOTER.length; j++) {
            $('#carruselFooter').slick('slickAdd','<div style="background-color:#ffffff; padding:5px; border:solid 1px #e6e6e6; height:200px;"><input id="pkPlantFoot' + data.DATA.PK[j] + '" type="hidden" value="' + data.DATA.PK[j] + '"><br>' + data.DATA.FOOTER[j] + '<br></div>');
        }
        if(pkFoot<=0){
            $('#carruselFooter').slick('slickGoTo', 0);
        }else{
            $('#carruselFooter').slick('slickGoTo', $('#pkPlantFoot'+pkFoot).parent().attr("data-slick-index"));
        }
    });
    if (pkBody > 0){
        obtieneEtiquetas(pkBody);
    }
}

<!--- 
*Fecha  Agosto de 2017
*Autor  Roberto Cadena
!--->
$('body').on('click', '#btn-historial-correos', function(){
    getHistorialCorreos();
});

$('body').on('change', '.buscador', function(){
    getHistorialCorreos();
});

<!--- 
*Fecha  Agosto de 2017
*Autor  Roberto Cadena
!--->
function getHistorialCorreos(){
    var fechaInicio = $('#fechaInicio').val() == undefined || $('#fechaInicio').val() == null || $('#fechaInicio').val() == '' ? '0/0/0' : $('#fechaInicio').val();
    var fechaFin = $('#fechaFin').val() == undefined || $('#fechaFin').val() == null || $('#fechaFin').val() == '' ? '0/0/0' : $('#fechaFin').val();
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.getHistorialCorreos")#</cfoutput>',{
        fechaInicio: fechaInicio,
        fechaFin:fechaFin
    }, function(data){
        if(data){
            $('#cajaCorreos').slideUp(1000,'easeOutExpo');
            $('#panel-historial').slideDown(1000,'easeOutExpo');
            $('#historialCorreos').html(data);

        }
    });
    if(fechaInicio != '0/0/0' && fechaFin != '0/0/0')
    if ($.datepicker.parseDate('dd/mm/yy', fechaFin) < $.datepicker.parseDate('dd/mm/yy', fechaInicio))
        swal({
            type: "error",
            title: "Error",
            text: "La fecha de inicio es mayor a la fecha de fin.",
            timer: 3000,
            showConfirmButton: false
        });

}

<!--- 
*Fecha  Agosto de 2017
*Autor  Roberto Cadena
!--->
function verCajaCorreos(){
    $('#panel-historial').slideUp(1000,'easeOutExpo');
    $('#cajaCorreos').slideDown(1000,'easeOutExpo');
}

<!--- 
*Fecha  Agosto de 2017
*Autor  Roberto Cadena
!--->
function getCorreo(pkHistorial){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.getCorreo")#</cfoutput>',{
        pkHistorial: pkHistorial
    }, function(data){
        if(data){
            $('#modal-historial').modal();
            $('#Contenido').html(data);
        }
    });

}
<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Obtiene las etiquetas de un correo
--->
function obtieneEtiquetas(pkBody){
    $('#listaEtiquetas').empty();
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtieneEtiquetas")#</cfoutput>', {pkBody: pkBody}, function(data){
        if(data.DATA.ETIQUETA.length>0){ 
            for(var i = 0; i < data.DATA.ETIQUETA.length; i++){
                $('#listaEtiquetas').append('<li class="list-group-item">'+data.DATA.ETIQUETA[i]+'<span class="badge" onclick="cambiarEstadoEtiqueta('+i+');"><i class="fa fa-trash"></i></span><span class="badge" onclick="ponerEtiqueta('+i+');"><i class="fa fa-plus"></i></span></li>');
                $('#listaEtiquetas').append('<input id="etiquetaCont'+i+'" type="hidden" value="'+data.DATA.ETIQUETA[i]+'">');
                $('#listaEtiquetas').append('<input id="etiquetaPk'+i+'" type="hidden" value="'+data.DATA.PK[i]+'">');
            }
        }
        else{
            $('#listaEtiquetas').append('<li class="list-group-item">Correo sin etiquetas</li>');
        }
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Coloca la etiqueta en el area de texto
--->
function ponerEtiqueta(number){
    tinyMCE.get("inContentCorreo").insertContent('#'+$("#etiquetaCont"+number).val()+'#');
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Guarda una etiqueta
--->
function agregarEtiqueta(){
    if ($("#nuevaEtiqueta").valid()){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.agregarEtiqueta")#</cfoutput>', {
            pkBody: $("#inPkBody").val(),
            nombre: $("#inEtiContenido").val(),
            descripcion: 'Etiqueta para ' + $("#inEtiContenido").val() + ' de ' + $("#inCorreo").val()
        }, function(data){
            if (data > 0){
                obtieneEtiquetas($("#inPkBody").val());
                $("#nuevaEtiqueta")[0].reset();
            }
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Cambia el estado de una etiqueta
--->
function cambiarEstadoEtiqueta(number){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.cambiarEstadoEtiqueta")#</cfoutput>', {
        pkEti: $("#etiquetaPk"+number).val()
    }, function(data){
        if (data > 0){
            obtieneEtiquetas($("#inPkBody").val());
        }
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Llena la modal de plantillas con la tabla de cabeceras existentes
--->
function obtieneHeader(){
    $("#mdl-plantillas .modal-title").html('Cabeceras disponibles');
    $("#mdl-crear .modal-title").html('Editor de cabecera');
    $("#tipoPlantillaConf").val("1");
    $("#tipoPlantilla").val("1");
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtieneHeader")#</cfoutput>',{}, function(data){
        $('#plantillas').html(data);
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Llena la modal de plantillas con la tabla de pies de pagina existentes
--->
function obtieneFooter(){
    $("#mdl-plantillas .modal-title").html('Pies de pagina disponibles');
    $("#mdl-crear .modal-title").html('Editor de pie de pagina');
    $("#tipoPlantillaConf").val("2");
    $("#tipoPlantilla").val("2");
    $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtieneFooter")#</cfoutput>', function(data){
        $('#plantillas').html(data);
    });
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion:  Agrega una plantilla cabecera si el valor de #tipoPlantilla es igual a 1 y el valor #inPkPlant es igual a 0
                Edita una plantilla cabecera si el valor de #tipoPlantilla es igual a 1 y el valor #inPkPlant es mayor a 0
                Agrega una plantilla pie de pagina si el valor de #tipoPlantilla es igual a 2 y el valor #inPkPlant es igual a 0
                Edita una plantilla pie de pagina si el valor de #tipoPlantilla es igual a 2 y el valor #inPkPlant es mayor a 0
--->
function agregarPlant(){
    if ($("#nuevaPlant").valid() && $("#tipoPlantilla").val()==1){
        if ($("#inPkPlant").val()==0){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.agregarHeader")#</cfoutput>', {
                nombre: $("#inPlantilla").val(),
                desc: $("#inPlantillaDesc").val(),
                contenido: tinyMCE.get("inContentPlant").getContent()
            }, function(data){
                if (data > 0){
                    obtieneHeader();
                    limpiarVistaPre();
                    $("#mdl-crear").modal('hide');
                    $("#nuevaPlant")[0].reset();
                    toastr.success('Exitosamente','Plantilla Agregada');
                }
                else {
                    toastr.error('al crear cabecera','Problema');
                }
            });
        }else{
            $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.editarHeader")#</cfoutput>', {
                pk: $("#inPkPlant").val(),
                nombre: $("#inPlantilla").val(),
                desc: $("#inPlantillaDesc").val(),
                contenido: tinyMCE.get("inContentPlant").getContent()
            }, function(data){
                if (data > 0){
                    obtieneHeader();
                    limpiarVistaPre();
                    $("#mdl-crear").modal('hide');
                    $("#nuevaPlant")[0].reset();
                    toastr.success('Exitosamente','Plantilla Editada');
                }
                else {
                    toastr.error('al editar cabecera','Problema');
                }
            });
        }
    } else if ($("#nuevaPlant").valid() && $("#tipoPlantilla").val()==2){
        if ($("#inPkPlant").val()==0){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.agregarFooter")#</cfoutput>', {
                nombre: $("#inPlantilla").val(),
                desc: $("#inPlantillaDesc").val(),
                contenido: tinyMCE.get("inContentPlant").getContent()
            }, function(data){
                if (data > 0){
                    obtieneFooter();
                    limpiarVistaPre();
                    $("#mdl-crear").modal('hide');
                    $("#nuevaPlant")[0].reset();
                    toastr.success('Exitosamente','Plantilla Agregada');
                }
                else {
                    toastr.error('al crear pie de pagina','Problema');
                }
            });
        } else{
            $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.editarFooter")#</cfoutput>', {
                pk: $("#inPkPlant").val(),
                nombre: $("#inPlantilla").val(),
                desc: $("#inPlantillaDesc").val(),
                contenido: tinyMCE.get("inContentPlant").getContent()
            }, function(data){
                if (data > 0){
                    obtieneFooter();
                    limpiarVistaPre();
                    $("#mdl-crear").modal('hide');
                    $("#nuevaPlant")[0].reset();
                    toastr.success('Exitosamente','Plantilla Editada');
                }
                else {
                    toastr.error('al editar pie de pagina','Problema');
                }
            });
        }        
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion:  Obtiene la vista previa de una plantilla cabecera si #tipoPlantilla es igual a 1
                Obtiene la vista previa de una plantilla pie de pagina si #tipoPlantilla es igual a 2
--->
function vistaPlant(pkPlant){
    if ($("#tipoPlantilla").val()==1){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerVistaHeader")#</cfoutput>', {pkPlant: pkPlant}, function(data){
            $('#plantillaVistaPre').html(data.DATA.HEADER[0]);
        }); 
    } else if ($("#tipoPlantilla").val()==2){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerVistaFooter")#</cfoutput>', {pkPlant: pkPlant}, function(data){
            $('#plantillaVistaPre').html(data.DATA.FOOTER[0]);
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion:  Obtiene el contenido de una plantilla cabecera si #tipoPlantilla es igual a 1
                Obtiene el contenido de una plantilla pie de pagina si #tipoPlantilla es igual a 2
--->
function obtieneContenidoPlant(pkPlant){
    if ($("#tipoPlantilla").val()==1){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerVistaHeader")#</cfoutput>', {pkPlant: pkPlant}, function(data){
            tinyMCE.get("inContentPlant").setContent(data.DATA.HEADER[0]);
        }); 
    } else if ($("#tipoPlantilla").val()==2){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.obtenerVistaFooter")#</cfoutput>', {pkPlant: pkPlant}, function(data){
            tinyMCE.get("inContentPlant").setContent(data.DATA.FOOTER[0]);
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion:  Cambia el estado de una plantilla cabecera si #tipoPlantilla es igual a 1
                Cambia el estado de una plantilla pie de pagina si #tipoPlantilla es igual a 2
--->
function cambiarEstadoPlant(){
    if ($("#tipoPlantillaConf").val()==1){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.cambiarEstadoHeader")#</cfoutput>', {
            pk: $('#inPkPlantConf').val()
        }, function(data){
            if (data >= 1){
                limpiaOpacidadModal();
                limpiarVistaPre();
                obtieneHeader();
                toastr.success('Eliminada Exitosamente','Plantilla');
            } else if(data == -1) {
                toastr.warning('La plantilla esta siendo usada por un correo','No se puede eliminar');
            } else {
                toastr.error('al eliminar plantilla','Problema');
            }
        });
    } else if ($("#tipoPlantillaConf").val()==2){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonCorreos.admonCorreos.cambiarEstadoFooter")#</cfoutput>', {
            pk: $('#inPkPlantConf').val()
        }, function(data){
            if (data >= 1){
                limpiaOpacidadModal();
                limpiarVistaPre();
                obtieneFooter();
                toastr.success('Eliminada Exitosamente','Plantilla');
            } else if(data == -1) {
                toastr.warning('La plantilla esta siendo usada por un correo','No se puede eliminar');
            } else {
                toastr.error('al eliminar plantilla','Problema');
            }
        });
    }
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Limpia la modal que sirve para crear o editar correos
--->
function limpiaPanelCorreo(){
    $('#pnl-ncorreo').slideUp(1000,'easeOutExpo');
    $('#cajaCorreos').slideDown(1000,'easeOutExpo');
    $("#inCorreo").removeClass("error");
    $("#inCorreo-error").remove();
    $("#inCorreoDesc").removeClass("error");
    $("#inCorreoDesc-error").remove();
    $("#inEtiContenido").removeClass("error");
    $("#inEtiContenido-error").remove();
    $("#nuevoCorreo")[0].reset();    
    $("#nuevaEtiqueta")[0].reset();
    $('#listaEtiquetas').empty();
    $('#listaEtiquetas').append('<li class="list-group-item">Correo sin etiquetas</li>');
    tinyMCE.get("inContentCorreo").setContent('');
    $("#inPkCorreoNuevo").val('0');
    $("#inPkBody").val('0');
    for(var i=0; i<=10; i++){
        $('#carruselHeader').slick('slickRemove',false);
    }
    for(var j=0; j<=10; j++){
        $('#carruselFooter').slick('slickRemove',false);
    }
    $("#inEtiContenido").prop("disabled",true);
    $("#botonAgregarEti").prop("disabled",true);
    $('#info').html('<strong>Información!:</strong> Antes de poder agregar una etiqueta, es necesario guardar el correo.');
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Limpia la modal que sirve para crear o editar plantillas de cabeceras o pies de pagina
--->
function limpiaModalPlant(){
    $("#inPlantilla").removeClass("error");
    $("#inPlantilla-error").remove();
    $("#inPlantillaDesc").removeClass("error");
    $("#inPlantillaDesc-error").remove();
    $("#nuevaPlant")[0].reset();
    $('#plantilla').html('');
    $('#inPkPlant').val('0');
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Limpia la modal en la que se muestra la vista previa de un correo
--->
function limpiarVistaPre() {
    $('#plantillaVistaPre').html('');
    $("#encabezadoVista").text("Vista previa");
}

<!---
* Fecha: Enero de 2017
* @author SGS
* Descripcion: Limpia la modal donde se muestran las plnatillas despues de confirmar la eliminacion de una cabecera o pie de pagina
--->
function limpiaOpacidadModal(){
    $("#mdl-confirma").modal('hide');
    $("#mdl-plantillas").css('filter', '');
}

$(document).ready(function() {

    $(".carrusel").slick({
        dots: true,
        slidesToShow: 1,
        slidesToScroll: 1
    });

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

    $("#nuevoCorreo").validate({
        rules: {
            inCorreo:        {required: true, maxlength: 75},
            inCorreoDesc:    {required: true, maxlength: 100}
        },
        submitHandler: function(form){
            return false;
        }
    });

    $("#nuevaPlant").validate({
        rules: {
            inPlantilla:        {required: true, maxlength: 75},
            inPlantillaDesc:    {required: true, maxlength: 100}
        },
        submitHandler: function(form){
            return false;
        }
    });

    $("#nuevaEtiqueta").validate({
        rules: {
            inEtiContenido:    {required: true}
        },
        submitHandler: function(form){
            return false;
        }
    });

    window.actionEvents = {
        'click .editarcorreo': function (e, value, row, index) {
            $('#inCorreo').val(row.nombre);
            $('#inCorreoDesc').val(row.descripcion);
            $("#inPkCorreoNuevo").val(row.id);
            editarCorreo(row.id);
        },
        'click .vistaprecorreo': function (e, value, row, index) {
            $("#mdl-vistacorreo .modal-title").html(row.nombre);
            $("#mdl-vistacorreo").modal('show');
            vistaCorreo(row.id);          
        },
        'click .eliminarcorreo': function (e, value, row, index) {
            $("#mdl-confirmaEliminar").modal('show');
            $("#inPkCorreo").val(row.id);
            $("#mdl-confirmaEliminar .modal-body").html('¿Seguro que quiere eliminar el correo?'+ '<br><br>' + '<strong>Nombre:</strong> '+ row.nombre + '<br>' + '<strong>Descripción:</strong> '+ row.descripcion);
        },
        'click .editarplant': function (e, value, row, index) {
            $("#inPkPlant").val(row.id);
            $('#inPlantilla').val(row.nombre);
            $('#inPlantillaDesc').val(row.descripcion);
            obtieneContenidoPlant(row.id);
            $("#mdl-crear").modal('show');
        },
        'click .vistapreplant': function (e, value, row, index) {
            $("#encabezadoVista").text("Vista previa de "+row.nombre);
           vistaPlant(row.id);
        },
        'click .eliminarplant': function (e, value, row, index) {
            $("#mdl-confirma").modal('show');
            $("#mdl-plantillas").css('filter', 'brightness(65%)');
            $("#inPkPlantConf").val(row.id);
            $("#mdl-confirma .modal-body").html('¿Seguro que quiere eliminar la plantilla?'+ '<br><br>' + '<strong>Nombre:</strong> '+ row.nombre + '<br>' + '<strong>Descripción:</strong> '+ row.descripcion);
        }
    };   

	consultarCorreos();

    $('.modal').css('max-height', $(window).height());
    $('.date').datepicker({
        format: 'dd/mm/yyyy',
        language: 'es',
        calendarWeeks: true,
        autoclose: true,
        startDate: '01/01/2015',
        todayHighlight: true
    });

});

</script>