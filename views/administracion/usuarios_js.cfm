<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

<!---
* Descripcion: Obtiene lista de usuarios
* Fecha: 03 de agosto de 2016
* @author: Yareli Andrade
* --->    
function consultarUsuarios(){
    $.post('usuarios/obtenerUsuarios', function(data){
        $('#usuarios').html( data );
    });
}

<!---
* Descripcion: Genera contraseña
* Fecha: 05 de agosto de 2016
* @author: Yareli Andrade
* --->  
function generarPsw(){
    var psw = $("#inPsw").val();
    $.post('usuarios/generarPsw', function(data){
        if(data != 0){
            $("#inPsw").val(data);
        }
    });
}

<!---
* Descripcion: Elimina usuario
* Fecha: 05 de agosto de 2016
* @author: ATC
* --->
function eliminaUsuario(){
    var pk = $('#mdl-estado-usuario').find('p').attr('pkUsr');
    $("#mdl-estado-usuario").modal('hide');
    $.post('/index.cfm/administracion/usuarios/eliminaUsuario', {
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

<!---
* Descripcion: Actualiza el estado de un usuario
* Fecha: 09 de agosto de 2016
* @author: Yareli Andrade
* --->
function actualizarUsuario(edo, successMsg, errorMsg, mail) {
    var pk = $('#mdl-estado-usuario').find('p').attr('pkUsr');
    $("#mdl-estado-usuario").modal('hide');
    $.post('usuarios/actualizarUsuario', {
            pkUsu: pk, estado: edo
        }, function(data) {
        if (data > 0) {
            if (edo == 2){
                $.post('/index.cfm/administracion/usuarios/notificaCreacionCuenta', {
                        email: mail
                    }, function(data){
                        if (data == 1){
                            consultarUsuarios();
                            toastr.success(successMsg + ' correctamente', 'Usuario');
                        }else {
                            toastr.error('No enviada', 'Cuenta de usuario');
                        }
                    }
                );
            }else {
                consultarUsuarios();
                toastr.success(successMsg + ' correctamente', 'Usuario');
            }
        } else
            toastr.error('Hubo un problema al tratar de ' + errorMsg + ' el usuario.');
    });
}



function modificarModal(titulo, usr, nombre, rol, correo) {
    var body = $('#mdl-estado-usuario .modal-body');
    $('#mdl-estado-usuario #mail').val(correo);            
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
<!---
* Descripcion: Limpia el formulario
* Fecha: 09 de agosto de 2016
* @author: Yareli Andrade
* ---> 
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
    jQuery.validator.addMethod("sinApellido", function () {
        if ( ($("#inPaterno").val() == "") && ($("#inMaterno").val() == "") ){
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
            inPaterno: {sinApellido: true},
            inMaterno: {sinApellido: true},
            inUr:      {required: true},
            inAcr:     {required: true},
            inEmail:   {required: true, email: true},
            inTel:     {required: true, digits: true, maxlength: 15},
            inExt:     {digits: true, maxlength: 6},
            inRol:     {required: true},
            inUser:    {required: true, nombre: true}
        },
        errorPlacement: function (error, element) {
            error.insertAfter($(element).parent());
        },
        submitHandler: function(form){
            return false;
        }
    });    

    consultarUsuarios();
    
    $(".btn-crear").on("click", function() {        
        limpiarFormUsr();
        validateForm.resetForm();
        $(".form-control").removeClass('error');
        $('#inNombre').removeAttr('disabled','');
        $('#inPaterno').removeAttr('disabled','');
        $('#inMaterno').removeAttr('disabled','');
        $('#opcM').parent().removeAttr('disabled','');
        $('#opcF').parent().removeAttr('disabled','');
        $('#inUr').removeAttr('disabled','');
        $('#inRol').removeAttr('disabled','');
        $("#inPref").text('');
        $("#mdl-admon-usuario .modal-title").text("Agregar usuario");
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
            var ur = $("#inUr").val();
            var nombre = $("#inNombre").val();
            var paterno = $("#inPaterno").val();
            var materno = $("#inMaterno").val();
            var genero = $("input[name=inGenero]:checked").val();  
            var acronimo    = $("#inAcr").val();      
            var email = $("#inEmail").val();
            var tel = $("#inTel").val();
            var ext = $("#inExt").val();
            var rol = $("#inRol").val();
            var usr = $("#inPref").text().concat($("#inUser").val());
            $.post('usuarios/agregarUsuario', { nombre: nombre, apaterno: paterno, amaterno: materno, acronimo: acronimo, ur: ur, genero: genero, email: email, tel: tel, ext: ext, rol: rol, usr: usr}, function(data){      
                if(data > 0){
                    consultarUsuarios();
                    $('#mdl-admon-usuario').modal('hide');
                    toastr.success('Registrado exitosamente','Usuario');
                    limpiarFormUsr();
                }
                else
                    toastr.error('El nombre de usuario ya existe.');
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
            var nombre = $("#inNombre").val();
            var paterno = $("#inPaterno").val();
            var materno = $("#inMaterno").val();
            var genero = $("input[name=inGenero]:checked").val();        
            var email = $("#inEmail").val();
            var tel = $("#inTel").val();
            var ext = $("#inExt").val();
            var rol = $("#inRol").val();
            var usr = $("#inPref").text().concat($("#inUser").val());
            var acr = $("#inAcr").val();
                
            $.post('usuarios/editarUsuario', { 
                pkUsuario: cveUsr, nombre: nombre, apaterno: paterno, amaterno: materno, genero: genero, email: email, tel: tel, ext: ext, rol: rol, usr: usr, acr:acr}, function(data){
                if(data > 0){  
                    consultarUsuarios();
                    $('#mdl-admon-usuario').modal('hide');
                    toastr.success('Actualizado exitosamente','Usuario');
                    limpiarFormUsr();
                }
                else
                    toastr.error('El nombre de usuario ya existe.');
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
            modificarModal('Validar', row.id, row.nombre, row.rol, row.correo)        
        },
        'click .cancelar-usuario': function (e, value, row, index) {            
            modificarModal('Cancelar', row.id, row.nombre, row.rol)        
        },        
        'click .editar-usuario': function (e, value, row, index) {
            limpiarFormUsr();
            validateForm.resetForm();
            $(".form-control").removeClass('error');
            $("#mdl-admon-usuario").attr("data-usr", row.id);             
            $("#mdl-admon-usuario .modal-title").text('Editar usuario');
            $("#btn-admon-usr").switchClass("btn-agregar","btn-editar");
            $("#btn-admon-usr").html('<span class="fa fa-check"></span> Actualizar');
            $('#inNombre').removeAttr('disabled','');
            $('#inPaterno').removeAttr('disabled','');
            $('#inMaterno').removeAttr('disabled','');
            $('#opcM').parent().removeAttr('disabled','');
            $('#opcF').parent().removeAttr('disabled','');
            $('#inUr').removeAttr('disabled','');
            $('#inRol').removeAttr('disabled','');
                
            $.post('usuarios/consultarUsuario', { 
                pkUsuario: row.id}, function(data){
                if(data.ROWCOUNT > 0){
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                    $('#inPaterno').val(data.DATA.PATERNO.toString());
                    $('#inMaterno').val(data.DATA.MATERNO.toString());
                    $('#inEmail').val(data.DATA.EMAIL.toString());
                    $('#inTel').val(data.DATA.TEL.toString());
                    $('#inExt').val(data.DATA.EXT.toString());
                    $("#inRol").val(data.DATA.ROL.toString());
                    $("#inUr").val(data.DATA.UR.toString());
                    $("#inAcr").val(data.DATA.ACRO[0]);
                    $("#inPref").text(data.DATA.CVEROL.toString());
                    var nomUsu = data.DATA.USR.toString().split(data.DATA.CVEROL.toString());
                    $("#inUser").val(nomUsu[1]);
                    if (data.DATA.GENERO.toString() == 1) {
                        $('#opcM').attr("checked", true);
                        $('#opcF').parent().removeClass('active');
                        $('#opcM').parent().addClass('active');
                    }
                    else {
                        $('#opcF').attr("checked", true);
                        $('#opcM').parent().removeClass('active');
                        $('#opcF').parent().addClass('active');
                    }
                }
                else
                    toastr.error('Hubo un problema al realizar la consulta del usuario');
            });
        },
        'click .editar-usuario-validado': function (e, value, row, index) {
            limpiarFormUsr();
            validateForm.resetForm();
            $(".form-control").removeClass('error');
            $("#mdl-admon-usuario").attr("data-usr", row.id);             
            $("#mdl-admon-usuario .modal-title").text('Editar usuario');
            $("#btn-admon-usr").switchClass("btn-agregar","btn-editar");
            $("#btn-admon-usr").html('<span class="fa fa-check"></span> Actualizar');
            $('#inNombre').attr('disabled','');
            $('#inPaterno').attr('disabled','');
            $('#inMaterno').attr('disabled','');
            $('#opcM').parent().removeAttr('disabled','');
            $('#opcF').parent().removeAttr('disabled','');
            $('#inUr').attr('disabled','');
            $('#inRol').attr('disabled','');
                
            $.post('usuarios/consultarUsuario', { 
                pkUsuario: row.id}, function(data){
                if(data.ROWCOUNT > 0){
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                    $('#inPaterno').val(data.DATA.PATERNO.toString());
                    $('#inMaterno').val(data.DATA.MATERNO.toString());
                    $('#inEmail').val(data.DATA.EMAIL.toString());
                    $('#inTel').val(data.DATA.TEL.toString());
                    $('#inExt').val(data.DATA.EXT.toString());
                    $("#inRol").val(data.DATA.ROL.toString());
                    $("#inUr").val(data.DATA.UR.toString());
                    $("#inAcr").val(data.DATA.ACRO[0]);
                    $("#inPref").text(data.DATA.CVEROL.toString());
                    var nomUsu = data.DATA.USR.toString().split(data.DATA.CVEROL.toString());
                    $("#inUser").val(nomUsu[1]);
                    if (data.DATA.GENERO.toString() == 1) {
                        $('#opcM').attr("checked", true);
                        $('#opcF').parent().attr('disabled','');
                        $('#opcF').parent().removeClass('active');
                        $('#opcM').parent().addClass('active');
                    }
                    else {
                        $('#opcF').attr("checked", true);
                        $('#opcM').parent().attr('disabled','');
                        $('#opcM').parent().removeClass('active');
                        $('#opcF').parent().addClass('active');
                    }
                }
                else
                    toastr.error('Hubo un problema al realizar la consulta del usuario');
            });
        },        
        'click .enviar-pwd': function (e, value, row, index) {
            $.post('/index.cfm/administracion/usuarios/recuperarPwd', {
                nomUsuario:row.usuario,
                    email: row.correo
                }, function(data){
                    if(data == 1){
                        toastr.success('Enviada','Contraseña');
                    }else{
                        toastr.error('Contraseña','Error al enviar');
                    }
                }
            );           
        }
    };

    $("#btn-estado-usr").on("click", function() {
        if ($(this).attr('data-action') == 'eliminar')
            actualizarUsuario(0, 'Eliminado', 'eliminar', $("#mail").val());
        else if ($(this).attr('data-action') == 'validar')
            actualizarUsuario(2, 'Validado', 'validar', $("#mail").val());
        else if ($(this).attr('data-action') == 'cancelar')
            actualizarUsuario(4, 'Cancelado', 'cancelar', $("#mail").val());
    });

    <!---
    * Descripcion: Formar nombre de usuario
    * Fecha: 09 de agosto de 2016
    * @author: Alejandro tovar
    * --->
    $("#inRol").change(function(){
        if( $("#inRol").val() == "" ){
            $("#inPref").text("");
        }else{
            $.post('usuarios/getClaveRol', {
                rol: $("#inRol").val()
                },function(data){      
                    if(data){
                        $("#inPref").text(data.DATA.CLAVE[0]);
                        var posPref = $("#inEmail").val().indexOf('@');
                        var prefijo = $("#inEmail").val().substr(0,posPref);
                        $("#inUser").val(prefijo.toUpperCase());
                    }
            }); 
        }
    });

    <!---
    * Descripcion: Formar nombre de usuario al cambiar el campo Email
    * Fecha: 12 de agosto de 2016
    * @author: Alejandro tovar
    * --->
    $("#inEmail").keyup(function(){
        var posPref = $("#inEmail").val().indexOf('@');
        var prefijo = $("#inEmail").val().substr(0,posPref);
        $("#inUser").val(prefijo.toUpperCase());
    });

});

</script>