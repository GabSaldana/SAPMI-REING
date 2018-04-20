<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

function eliminaAccion(){
    var pk = $('#mdl-estado-accion').find('p').attr('pkAcc');
    $("#mdl-estado-accion").modal('hide');
    $.post('/index.cfm/admonPri/admonPri/eliminaAccion', {
            pkUsu: pk,
        }, function(data){
            if(data > 0){
                consultarInfoAcciones();
                toastr.success('Eliminada correctamente','Acción');
            } else{
                toastr.error('Hubo un problema en la eliminación','Acción');
            }
        }
    );
}


function actualizarAccion(edo, successMsg, errorMsg) {
    var pk = $('#mdl-estado-accion').find('p').attr('pkAcc');
    $("#mdl-estado-accion").modal('hide');
    $.post('/index.cfm/admonPri/admonPri/actualizarAccion', {
            pkUsu: pk, estado: edo
        }, function(data) {
        if(data > 0) {
            consultarAcciones();
            toastr.success(successMsg + ' correctamente', 'Acción');
        } else
            toastr.error('Hubo un problema al tratar de ' + errorMsg + ' la acción.');
    });
}

function modificarModal(titulo, usr, nombre, rol) {
    var body = $('#mdl-estado-accion .modal-body');            
    body.empty();
    $("#mdl-estado-accion .modal-title").text(titulo + " Acción");
    $("#btn-estado-usr").attr("data-action", titulo.toLowerCase());
    var conf = $('<p>').text("¿Confirma que desea " + titulo.toLowerCase() + " la acción seleccionada?");
    conf.attr("pkAcc", usr);
    body.append(conf);
    var texto = $('<p>').append($('<strong>').text("Nombre: "));
    texto.append(nombre);
    texto.append('<br>');
    texto.append($('<strong>').text("Rol: "));
    texto.append(rol);
    body.append(texto);
}

function consultarAcciones(curso){
    curso = $("#inrol").val();    
    $.post('/index.cfm/admonPri/admonPri/mostrarAcciones', { 
          curso: curso            
        }, function(data){            
        $('#eval-accion').html( data );
        
    });
}

function limpiarFormUsr(){
    $("#validaAccion2")[0].reset();
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

    consultarAcciones();

     jQuery.validator.addMethod("completarmodulo", function () {
        if ( $("#inrol").val() == "0" ){
            return false;
            
        } else{
            return true;                        
        };
    }, "*Es necesario ingrear el módulo.");

      $("#form-accion").validate({
        rules: {
            inrol:    {completarmodulo: true }
        },
        errorPlacement: function (error, element) {
            error.insertAfter($(element).parent());
            // $(".btn-crear").hide();
        },
        submitHandler: function(form){
            return false;                        
        }
    });



    jQuery.validator.addMethod("sincompletar", function () {
        if ( ($("#inrol").val() == "") && ($("#inAccion").val() == "") ){
            return false;
        } else{
            return true;
        };
    }, "Este campo es obligatorio.");

    jQuery.validator.addMethod("nombre", function (value, element) {
        if (/^[a-zA-Z_áéíóúñ\s]/.test(value)){
            return true;
        }else{
            return false;
        };
    }, "* Debe comenzar con una letra.");

    var validateForm = $("#validaAccion2").validate({
        rules: {            
            inAccion: {required: true },                       
            inCom:    {required: true, sincompletar: true},
            inOrden:  {required: true, sincompletar: true},
            inClave:  {required: true, nombre: true},
            inIcon:   {required: true}

        },
        errorPlacement: function (error, element) {
            error.insertAfter($(element).parent());
        },
        submitHandler: function(form){
            return false;
        }
    });

     $(".btn-crear").on("click", function() {        
        limpiarFormUsr();
        validateForm.resetForm();
        $(".form-control").removeClass('error');
        // $('#inMod').removeAttr('disabled','');
        // $('#inTitulo').removeAttr('disabled','');
        // $('#inAccion').removeAttr('disabled','');
        // $('#inCom').removeAttr('disabled','');
        $("#mdl-admon-accion .modal-title").text("Agregar usuario");
        $("#btn-admon-usr").switchClass("btn-editar","btn-agregar");
        $("#btn-admon-usr").html('<span class="fa fa-check"></span> Guardar');
    });

    $(document).on("click", ".btn-agregar", function() {
        if($("#validaAccion2").valid()){
            var modulo      = $("#inrol").val();
            var estado 		= 2;
            var nombre      = $("#inAccion").val();
            var descripcion = $("#inCom").val();
            var orden       = parseInt($("#inOrden").val());
            var clave       = $("#inClave").val();
            var icono       = $("#inIcon").val();
            
            alert(modulo + ', '+estado+', '+nombre+', '+descripcion+', '+orden+', '+clave+', '+icono);
            $.post('/index.cfm/admonPri/admonPri/agregarAccion', { modulo: modulo, estado: estado, nombre: nombre,  descripcion: descripcion, orden:orden, clave: clave, icono:icono}, 
		function(data){  
                if(data > 0){
                    consultarAcciones();
                    $('#mdl-admon-accion').modal('hide');
                    toastr.success('Registrado exitosamente','Usuario');
                    limpiarFormUsr();
                }
                else
                    toastr.error('Hubo un problema al tratar de guardar el registro. ');
                 
            });
        }
        
    }); 



    $(document).on("click", ".btn-editar", function() { 
        if($("#validaAccion2").valid()){
            var cveAcc = $("#mdl-admon-accion").attr("data-usr");            
            var nombre      = $("#inAccion").val();
            var descripcion = $("#inCom").val();
            var orden       = parseInt($("#inOrden").val());
            var clave       = $("#inClave").val();
            var icono       = $("#inIcon").val();
            $.post('/index.cfm/admonPri/admonPri/editarAccion', { 
                pkAccion: cveAcc, nombre: nombre, descripcion: descripcion, orden: orden, clave: clave, icono: icono}, function(data){
                if(data > 0){  
                    consultarAcciones();
                    $('#mdl-admon-accion').modal('hide');
                    toastr.success('Actualizado exitosamente','Usuario');
                    limpiarFormUsr();
                }
                else
                    toastr.error('Hubo un problema al tratar de actualizar el registro.');                               
            });
        }
    });

     window.actionEvents = {        
        'click .eliminar-usuario': function (e, value, row, index) {            
            modificarModal('Eliminar', row.id, row.nombre, row.rol)        
        },
        'click .validar-usuario': function (e, value, row, index) {            
            modificarModal('Validar', row.id, row.nombre, row.rol)        
        },
        'click .cancelar-usuario': function (e, value, row, index) {            
            modificarModal('Cancelar', row.id, row.nombre, row.rol)        
        },

        'click .editar-usuario-validado': function (e, value, row, index) {
            limpiarFormUsr();
            validateForm.resetForm();
            $(".form-control").removeClass('error');
            $("#mdl-admon-accion").attr("data-usr", row.id);             
            $("#mdl-admon-accion .modal-title").text('Editar usuario');
            $("#btn-admon-usr").switchClass("btn-agregar","btn-editar");
            $("#btn-admon-usr").html('<span class="fa fa-check"></span> Actualizar');
            $.post('/index.cfm/admonPri/admonPri/consultarInfoAcciones', { 
                pkAccion: row.id}, function(data){
                if(data.ROWCOUNT > 0){                    
                    $('#inAccion').val(data.DATA.NOMBRE[0]);
                    $('#inCom').val(data.DATA.DESCRIPCION.toString());
                    $('#inOrden').val(data.DATA.ORDEN[0]);
                    $('#inClave').val(data.DATA.CLAVE.toString());
                    $('#inIcon').val(data.DATA.ICONO.toString());
                }
                else
                    toastr.error('Hubo un problema al realizar la consulta del usuario');
            });
        },     
    };

    $("#btn-estado-usr").on("click", function() {
        if ($(this).attr('data-action') == 'eliminar')
            actualizarAccion(3, 'Eliminado', 'eliminar');
        else if ($(this).attr('data-action') == 'validar')
            actualizarAccion(2, 'Validado', 'validar');
        else if ($(this).attr('data-action') == 'cancelar')
            actualizarAccion(1, 'Cancelado', 'cancelar');
    });    

        $("#inrol").change(function(){
                if($(this).val() == 0){  
                    consultarAcciones();
                }             
        });
         
        $('[data-toggle="tooltip"]').tooltip();

        
});

    function secDoc(){
        window.location= '/index.cfm/admonPri/admonPri/vistaGeneral';
    }

    function thrDoc(){
        window.location= '/index.cfm/admonPri/admonPri';
    }


</script>

