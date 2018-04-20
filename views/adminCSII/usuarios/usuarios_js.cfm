<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

<!---
* Descripcion: Obtiene lista de usuarios
* Fecha: 03 de agosto de 2016
* @author: Yareli Andrade
* --->    
function consultarUsuarios(){
    $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.obtenerUsuarios")#</cfoutput>', function(data){
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
    $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.generarPsw")#</cfoutput>', function(data){
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
    $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.eliminaUsuario")#</cfoutput>', {
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
function actualizarUsuario(edo, successMsg, errorMsg) {
    var pk = $('#mdl-estado-usuario').find('p').attr('pkUsr');
    $("#mdl-estado-usuario").modal('hide');
    $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.actualizarUsuario")#</cfoutput>', {
            pkUsu: pk, estado: edo
        }, function(data) {
        if(data > 0) {
            consultarUsuarios();
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
<!---
* Descripcion: Limpia el formulario
* Fecha: 09 de agosto de 2016
* @author: Yareli Andrade
* ---> 
function limpiarFormUsr(){
    $("#validaUsuario")[0].reset();
}

$(document).ready(function() {

    $("select").select2({dropdownCssClass: "selectzindex"});

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

    /* SELECT 2 */
    $('select').select2({
        containerCssClass: 'form-control'
    }).on('change',function(event){
        if($(this).val() !== '-1'){    		
            $(this).closest('.form-group').removeClass('has-error');
            $(this).parent().find('label[id$="-error"]').hide();
    }
    });
    
    $(".btn-crear").on("click", function() {        
        limpiarFormUsr();
        validateForm.resetForm();
        $(".form-control").removeClass('error');
        $('#inNombre').removeAttr('disabled','');
        $('#inPaterno').removeAttr('disabled','');
        $('#inMaterno').removeAttr('disabled','');
        $('#opcM').removeAttr('disabled','');
        $('#opcF').removeAttr('disabled','');
        $('#inUr').removeAttr('disabled','');
        $('#inRol').removeAttr('disabled','');
        $("#inPref").text('');
        $("#mdl-admon-usuario .modal-title").text("Agregar usuario");
        $("#btn-admon-usr").switchClass("btn-editar","btn-agregar");
        $("#btn-admon-usr").html('<span class="fa fa-check"></span> Guadar');
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
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.agregarUsuario")#</cfoutput>', { nombre: nombre, apaterno: paterno, amaterno: materno, acronimo: acronimo, ur: ur, genero: genero, email: email, tel: tel, ext: ext, rol: rol, usr: usr}, function(data){      
                if(data > 0){
                    consultarUsuarios();
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
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.editarUsuario")#</cfoutput>', { 
                pkUsuario: cveUsr, nombre: nombre, apaterno: paterno, amaterno: materno, genero: genero, email: email, tel: tel, ext: ext, rol: rol, usr: usr, acr:acr}, function(data){
                if(data > 0){  
                    consultarUsuarios();
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
            $('#opcM').removeAttr('disabled','');
            $('#opcF').removeAttr('disabled','');
            $('#inUr').removeAttr('disabled','');
            $('#inRol').removeAttr('disabled','');
                
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.consultarUsuario")#</cfoutput>', { 
                pkUsuario: row.id}, function(data){
                if(data.ROWCOUNT > 0){                                 
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                    $('#inPaterno').val(data.DATA.PATERNO.toString());
                    $('#inMaterno').val(data.DATA.MATERNO.toString());
                    $('#inEmail').val(data.DATA.EMAIL.toString());
                    $('#inTel').val(data.DATA.TEL.toString());
                    $('#inExt').val(data.DATA.EXT.toString());
                    $("#inRol").val(data.DATA.ROL.toString());
                    $("#inUr").val(data.DATA.UR.toString()).trigger('change');                    
                    $("#inAcr").val(data.DATA.ACRO[0]);
                    $("#inPref").text(data.DATA.CVEROL.toString());
                    var nomUsu = data.DATA.USR.toString().split(data.DATA.CVEROL.toString());
                    $("#inUser").val(nomUsu[1]);
                    if (data.DATA.GENERO.toString() == 3) {
                        $('#opcM').attr("checked", true);
                        $('#opcF').attr("checked", false);
                        $('#opcM').attr("disabled", true);
                        $('#opcF').attr("disabled", true);
                    }
                    else {
                        $('#opcF').attr("checked", true);
                        $('#opcM').attr("checked", false);
                        $('#opcM').attr("disabled", true);
                        $('#opcF').attr("disabled", true);
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
            $('#opcM').removeAttr('disabled','');
            $('#opcF').removeAttr('disabled','');
            $('#inUr').attr('disabled','');
            $('#inRol').attr('disabled','');
                
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.consultarUsuario")#</cfoutput>', { 
                pkUsuario: row.id}, function(data){
                if(data.ROWCOUNT > 0){                    
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                    $('#inPaterno').val(data.DATA.PATERNO.toString());
                    $('#inMaterno').val(data.DATA.MATERNO.toString());
                    $('#inEmail').val(data.DATA.EMAIL.toString());
                    $('#inTel').val(data.DATA.TEL.toString());
                    $('#inExt').val(data.DATA.EXT.toString());
                    $("#inRol").val(data.DATA.ROL.toString());
                    $("#inUr").val(data.DATA.UR.toString()).trigger('change');
                    $("#inAcr").val(data.DATA.ACRO[0]);
                    $("#inPref").text(data.DATA.CVEROL.toString());
                    var nomUsu = data.DATA.USR.toString().replace(data.DATA.CVEROL.toString(),'');                    
                    $("#inUser").val(nomUsu);
                    if (data.DATA.GENERO.toString() == 3) {
                        $('#opcM').attr("checked", true);
                        $('#opcF').attr("checked", false);
                        $('#opcM').attr("disabled", true);
                        $('#opcF').attr("disabled", true);
                    }
                    else {
                        $('#opcF').attr("checked", true);
                        $('#opcM').attr("checked", false);
                        $('#opcM').attr("disabled", true);
                        $('#opcF').attr("disabled", true);
                    }
                }
                else
                    toastr.error('Hubo un problema al realizar la consulta del usuario');
            });
        },        
        'click .enviar-pwd': function (e, value, row, index) {
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.recuperarPwd")#</cfoutput>', {
                email: row.correo,
		NOMUSUARIO: row.usuario 
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
            actualizarUsuario(0, 'Eliminado', 'eliminar');
        else if ($(this).attr('data-action') == 'validar')
            actualizarUsuario(2, 'Validado', 'validar');
        else if ($(this).attr('data-action') == 'cancelar')
            actualizarUsuario(4, 'Cancelado', 'cancelar');
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
            $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.getClaveRol")#</cfoutput>', {
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



function operacionArchivos(){
    $.post('<cfoutput>#event.buildLink("CVU.migracionDocumentos.operacionArchivos")#</cfoutput>',{
    },function(data){
        console.log(data);
    });
}


function archivosHumanos(){
    $.post('<cfoutput>#event.buildLink("CVU.migracionDocumentos.archivosHumanos")#</cfoutput>',{
    },function(data){
        console.log(data);
    });
}

function operacionDisenoRedisenoProgramas(){
    $.post('<cfoutput>#event.buildLink("CVU.migracionDocumentos.operacionDisenoRedisenoProgramas")#</cfoutput>',{
    },function(data){
        console.log(data);
    });
}

</script>