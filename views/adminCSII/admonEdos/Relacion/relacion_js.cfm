<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene las relaciones con que cuenta una ruta.
    --->
    function consultarRelaciones(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.setTablaRelaciones")#</cfoutput>', {
            pkRuta: $("#inRuta").val()
        }, function(data){
            $('#tableRelacion').html(data);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene las operaciones con que cuenta la relación acción-rol.
    --->
    function consultaOperaciones(pkRelacion){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.setTablaAccOpe")#</cfoutput>', {
            pkRelacion: pkRelacion
        }, function(data){
            $('#tablaaccionOperacion').html(data);
            $("#mdl-relOperacion .modal-body #inEdoAcc").val(pkRelacion);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene las operaciones con que cuenta la relación acción-rol, dentro de la ventana modal.
    --->
    function consultaOper(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.setTablaAccOpe")#</cfoutput>', {
            pkRelacion: $("#inEdoAcc").val()
        }, function(data){
            $('#tablaaccionOperacion').html(data);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene las acciones que puede realizar algún rol.
    --->
    function consultarAcciones(){
        $("#inAccion").empty();
        $("#inAccion").append('<option value="" selected="selected">Seleccionar acción</option>');
        $("#inEdoAc").val('');
        $("#inEdoSg").val('');

        if ($("#inRol").val() != ''){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.getAcciones")#</cfoutput>', {
                pkRol: $("#inRol").val()
            }, function(data){
                if (data.ROWCOUNT > 0){
                    $("#inAccion").removeAttr('disabled');
                    $("#inEdoAc").removeAttr('disabled');
                    $("#inEdoSg").removeAttr('disabled');
                    for (var i = 0; i < data.ROWCOUNT; i++){
                        $("#inAccion").append('<option value=' + data.DATA.PK[i] + '>' + data.DATA.MODULO[i] + ' - ' + data.DATA.NOMBRE[i] + '</option>');
                    }
                }else {
                    toastr.error('','Sin Registros');
                    $("#inAccion").attr('disabled', true);
                    $("#inEdoAc").attr('disabled', true);
                    $("#inEdoSg").attr('disabled', true);
                }
            });
        }else {
            $("#inAccion").attr('disabled', true);
            $("#inEdoAc").attr('disabled', true);
            $("#inEdoSg").attr('disabled', true);
        }
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Agrega una nueva relacion entre el rol-acción, y establece sus estados.
    --->    
    function addRelacion(){
        if ($("#nuevaRelacion").valid()){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.addEdoAccion")#</cfoutput>', {
                accionRol: $("#inAccion").val(),
                edoAct: $("#inEdoAc").val(),
                edoSig: $("#inEdoSg").val()
            }, function(data){
                if (data > 0){
                    $("#mdl-relacion").modal('hide');
                    consultarRelaciones();
                    $("#nuevaRelacion")[0].reset();
                    toastr.success('Exitosamente','Relacion Agregada');
                }
            });
        }
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función que cambia el estado de la relación accion-rol.
    ---> 
    function cambiarEstado(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.cambiarEdoRel")#</cfoutput>', {
            pkRel: $("#inPkRel").val()
        }, function(data){
            if (data > 0){
                $("#mdl-confirma").modal('hide');
                consultarRelaciones();
                toastr.success('eliminada exitosamente','Relación');
            }else {
                toastr.error('al eliminar relación','Problema');
            }
        });
    }

   
    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función que cambia el estado de una operación ligada a una relación.
    ---> 
    function cambiarEstadoOper(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.cambiarEdoOper")#</cfoutput>', {
            pkOper: $("#inpkOper").val()
        }, function(data){
            if (data > 0){
                consultaOperaciones($("#inRelOper").val());
                $("#mdl-relOperacion").css('opacity', 1);
                $("#mdl-borra-oper").modal('hide');
                toastr.success('eliminada exitosamente','Relación');
            }else {
                toastr.error('al eliminar relación','Problema');
            }
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Limpia campos y mensajes de error en la modal para agregar una relación.
    ---> 
    function limpiaModal(){
        $("#mdl-relacion").modal('hide');
        $("#nuevaRelacion")[0].reset();
        $(".form-control").removeClass('error');
        $("label.error").remove();
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Limpia campos y mensajes de error en la modal para relacionar una operación.
    ---> 
    function limpiaOper(){
        $("#mdl-relOperacion").modal('hide');
        $("#accionOperacion")[0].reset();
        $(".form-control").removeClass('error');
        $("label.error").remove();
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función para devolver opacidad a la modal de operaciones.
    ---> 
    function cierraBorraOperacion(){
        $("#mdl-borra-oper").modal('hide');
        $("#mdl-relOperacion").css('opacity', 1);
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Función que liga una operación con alguna relación.
    ---> 
    function relacionaAccionOperacion(){
        if ($("#accionOperacion").valid()){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.relacionaAccionOperacion")#</cfoutput>', {
                pkOperacion: $("#inOpe").val(),
                pkTipoOper:  $("#inTipo").val(),
                pkRelacion:  $("#inEdoAcc").val(),
            }, function(data){
                if (data > 0){
                    consultaOper();
                    $("#inOpe").val('');
                    $("#inTipo").val('');
                    toastr.success('eliminada exitosamente','Relación');
                }else {
                    toastr.error('al eliminar relación','Problema');
                }
            });
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

        $("#nuevaRelacion").validate({
            rules: {
                inRol:    {required: true},
                inAccion: {required: true},
                inEdoAc:  {required: true},
                inEdoSg:  {required: true}
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        });

        $("#accionOperacion").validate({
            rules: {
                inOpe:  {required: true},
                inTipo: {required: true}
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        });

        $("#inAccion").attr('disabled', true);
        $("#inEdoAc").attr('disabled', true);
        $("#inEdoSg").attr('disabled', true);

        consultarRelaciones();

        window.actionEvents = {
            'click .borrar': function (e, value, row, index) {
                $("#mdl-confirma").modal('show');
                $("#inPkRel").val(row.id);
                $("#mdl-confirma .modal-body").html('¿Seguro que quiere eliminar la relación?'+ '<br><br>' + '<strong>Rol:</strong> '+row.rol + '<br>' + '<strong>Acción:</strong> '+ row.accion);
            },
            'click .accionOper': function (e, value, row, index) {
                $("#mdl-relOperacion").modal('show');
                $("#inRelOper").val(row.id);
                consultaOperaciones(row.id);
            },
            'click .borraOper': function (e, value, row, index) {
                $("#mdl-borra-oper").modal('show');
                $("#mdl-relOperacion").css('opacity', 0.7);
                $("#inpkOper").val(row.id);
                $("#mdl-borra-oper .modal-body").html('¿Seguro que quiere eliminar la operacion?'+ '<br><br>' + '<strong>Rol:</strong> '+row.oper + '<br>' + '<strong>Acción:</strong> '+ row.tipo);
            }
        };

    });

</script>