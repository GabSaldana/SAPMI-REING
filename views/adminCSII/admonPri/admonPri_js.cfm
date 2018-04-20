<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

function eliminaUsuario(){
    var pk = $('#mdl-estado-usuario').find('p').attr('pkUsr');
    $("#mdl-estado-usuario").modal('hide');
    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.eliminaUsuario")#</cfoutput>', {
            pkUsu: pk,
        }, function(data){
            if(data > 0){
                consultarUsuarios();
                toastr.success('Eliminado correctamente','Usuario');
            } else{
                toastr.error('Hubo un problema en la eliminación','Usuario');
            }
        }
    );
}


function actualizarUsuario(edo, successMsg, errorMsg) {
    var pk = $('#mdl-estado-usuario').find('p').attr('pkUsr');
    $("#mdl-estado-usuario").modal('hide');
    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.actualizarUsuario")#</cfoutput>', {
            pkUsu: pk, estado: edo
        }, function(data) {
        if(data > 0) {
            consultarLista();
            toastr.success(successMsg + ' correctamente', 'Usuario');
        } else
            toastr.error('Hubo un problema al tratar de ' + errorMsg + ' el usuario.');
    });
}

function modificarModal(titulo, usr, nombre, rol) {
    var body = $('#mdl-estado-usuario .modal-body');            
    body.empty();
    $("#mdl-estado-usuario .modal-title").text(titulo + " usuario");
    $("#btn-estado-usr").attr("data-action", titulo.toLowerCase());
    var conf = $('<p>').text("¿Confirma que desea " + titulo.toLowerCase() + " el usuario seleccionado?");
    conf.attr("pkUsr", usr);
    body.append(conf);
    var texto = $('<p>').append($('<strong>').text("Nombre: "));
    texto.append(nombre);
    texto.append('<br>');
    texto.append($('<strong>').text("Rol: "));
    texto.append(rol);
    body.append(texto);
}

function limpiarFormUsr(){
    $("#validaUsuario")[0].reset();
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

    <!---
    * Descripcion: Validación de campos para agregar usuario.
    * Fecha: 08 de agosto de 2016
    * @author: Alejandro Tovar
    * --->    
    jQuery.validator.addMethod("sincompletar", function () {
        if ( ($("#inClave").val() == "") && ($("#inPrefijo").val() == "") ){
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

    var validateForm = $("#validaUsuario").validate({
        rules: {
            inNombre:  {required: true, nombre: true},
            inClave: {sincompletar: true},
            inPrefijo: {sincompletar: true},           
            inDesc:    {required: true, nombre: true}
        },
        errorPlacement: function (error, element) {
            error.insertAfter($(element).parent());
        },
        submitHandler: function(form){
            return false;
        }
    }); 

    consultarLista();
    
    $(".btn-crear").on("click", function() {        
        limpiarFormUsr();
        validateForm.resetForm();
        $(".form-control").removeClass('error');
        $("#mdl-admon-usuario .modal-title").text("Agregar rol");
        $("#btn-admon-usr").switchClass("btn-editar","btn-agregar");
        $("#btn-admon-usr").html('<span class="fa fa-check"></span> Guardar');
    });
    
    <!---
    * Descripcion: Agrega un usuario
    * Fecha: 08 de agosto de 2016
    * @author: Yareli Andrade
    * --->
    $(document).on("click", ".btn-agregar", function() {
        if($("#validaUsuario").valid()){
            var nombre      = $("#inNombre").val();
            var clave       = $("#inClave").val();
            var descripcion = $("#inDesc").val();
            var prefijo     = $("#inPrefijo").val();
            var vertiente   = $("#inVert").val();
            if ($("#inModulo").val() == 0){
                var modulo  = 1;
            } else {
                var modulo  = $("#inModulo").val();
            }
            $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.agregarRol")#</cfoutput>', { nombre: nombre, clave: clave, descripcion: descripcion, prefijo: prefijo, modulo: modulo, vertiente: vertiente}, function(data){      
                if(data > 0){
                    consultarLista();
                    $('#mdl-admon-usuario').modal('hide');
                    toastr.success('Registrado exitosamente','Usuario');
                    limpiarFormUsr();
                }
                else
                    toastr.error('Hubo un problema al tratar de guardar el registro.');
            });
        }
    });

    <!---
    * Descripcion: Edita un usuario
    * Fecha: 09 de agosto de 2016
    * @author: Yareli Andrade
    * --->
    $(document).on("click", ".btn-editar", function() { 
        if($("#validaUsuario").valid()){
            var cveUsr = $("#mdl-admon-usuario").attr("data-usr");
            var nombre      = $("#inNombre").val();
            var clave       = $("#inClave").val();
            var descripcion = $("#inDesc").val();
            var prefijo     = $("#inPrefijo").val();
            if ($("#inModulo").val() == 0){
                var modulo  = 1;
            } else {
                var modulo  = $("#inModulo").val();
            }
            $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.editarUsuario")#</cfoutput>', { 
                pkUsuario: cveUsr, nombre: nombre, clave: clave, descripcion: descripcion, prefijo: prefijo, modulo: modulo}, function(data){
                if(data > 0){  
                    consultarLista();
                    $('#mdl-admon-usuario').modal('hide');
                    toastr.success('Actualizado exitosamente','Usuario');
                    limpiarFormUsr();
                }
                else
                    toastr.error('Hubo un problema al tratar de actualizar el registro.');
            });
        }
    });    
    
    <!---
    * Descripcion: Muestra ventanas modal de confirmación para eliminar/editar usuario
    * Fecha: 08 de agosto de 2016
    * @author: Yareli Andrade
    * --->
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
            $("#mdl-admon-usuario").attr("data-usr", row.id);             
            $("#mdl-admon-usuario .modal-title").text('Editar rol');
            $("#btn-admon-usr").switchClass("btn-agregar","btn-editar");
            $("#btn-admon-usr").html('<span class="fa fa-check"></span> Actualizar');
            $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.consultarUsuario")#</cfoutput>', { 
                pkUsuario: row.id}, function(data){
                if(data.ROWCOUNT > 0){
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                    $('#inClave').val(data.DATA.CVE.toString());
                    $('#inDesc').val(data.DATA.DESCRIPCION.toString());
                    $('#inPrefijo').val(data.DATA.PREFIJO.toString());
                    $('#inModulo').val(data.DATA.MODULO);
                    $('#inVert').val(data.DATA.PKVERT);
                   }
                else
                    toastr.error('Hubo un problema al realizar la consulta del usuario');
            });
        },     
    };

    $("#btn-estado-usr").on("click", function() {
        if ($(this).attr('data-action') == 'eliminar')
            actualizarUsuario(3, 'Eliminado', 'eliminar');
        else if ($(this).attr('data-action') == 'validar')
            actualizarUsuario(2, 'Validado', 'validar');
        else if ($(this).attr('data-action') == 'cancelar')
            actualizarUsuario(1, 'Cancelado', 'cancelar');
    });

   

});

function consultarLista(){
    $.post('<cfoutput>#event.buildLink("adminCSII.admonPri.admonPri.obtenerLista")#</cfoutput>', function(data){
        $('#lista').html( data );
         
    });
}
function newDoc(){
   window.location= '/index.cfm/adminCSII/admonPri/admonPri/cargarAcciones';
}

function secDoc(){
   window.location= '/index.cfm/adminCSII/admonPri/admonPri/vistaGeneral';
}

function limpiarFormUsr(){
    $("#validaUsuario")[0].reset();
}


</script>

