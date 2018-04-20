<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

    $(document).ready(function() {

        lanzarModal();
        $("#pkUsuario").val(<cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>);   ///
        $("#user").val('<cfoutput>#Session.cbstorage.usuario.USR#</cfoutput>');
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "progressBar": true,
            "preventDuplicates": false,
            "newestOnTop": true,
            "positionClass": "toast-top-full-width",
            "onclick": null,
            "showDuration": "1000",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "2000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

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

        jQuery.validator.addMethod("contrasena", function (value, element) {
            var pwdActual= '<cfoutput>#Session.cbstorage.usuario.PSW#</cfoutput>';
            if (pwdActual.toString() == value){
                return true;
            }else{
                return false;
            };
        }, "* La contraseña no es igual a la actual.");

        var registroForm = $("#registroForm").validate({
            rules: {
                inPassword: "required",
                confirmPassword: {
                    equalTo: "#inPassword"
                },
                inActual: {
                    required: true, 
                    contrasena: true
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        });

        $("#validaUsuario").validate({
            rules: {
                inNombre:  {required: true, nombre: true},
                inPaterno: {sinApellido:true},
                inMaterno: {sinApellido:true},
                inUr:      {required:false},
                inAcr:     {required:true},
                inEmail:   {required: true, email: true},
                inTel:     {required: true, digits: true, maxlength: 15},
                inExt:     {digits: true, maxlength: 6},
                inRol:     {required:true},
                inUser:    {required:true, nombre: true}
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        }); 

        $("#actualizaUsr").on("click", function() {
            if($("#validaUsuario").valid()){
                var nombre  = $("#inNombre").val();
                var paterno = $("#inPaterno").val();
                var materno = $("#inMaterno").val();
                var genero  = $("input[name=inGenero]:checked").val();
                var tel     = $("#inTel").val();
                var ext     = $("#inExt").val();
                var acr     = $("#inAcr").val();
                var email   = $("#inEmail").val();
                var psw     = $("#inPassword").val();

                $.post('/index.cfm/administracion/usuarios/editarUsuario', { 
                    nombre: nombre, apaterno: paterno, amaterno: materno, genero: genero, tel: tel, ext: ext, acr: acr, email: email,psw: psw}, function(data) {
                    if (data > 0) {
                        $("#mdl-usuario").modal('hide');
                        $("#nuevo").submit();
                    }else {
                        toastr.error('Hubo un problema al tratar de completar el registro.');
                    }
                });
            }
        });

        $("#cambiaPwd").on("click", function() {
            if($("#registroForm").valid()){
                var psw = $("#inPassword").val();
                $("#password").val(psw);

                $.post('/index.cfm/administracion/usuarios/cambiarPwd', { 
                    psw: psw }, function(data) {
                    if (data == -1){
                        toastr.error('La contraseña debe ser distinta a la que se asiganó automáticamente.');
                    }else if (data > 0) {

                        $.post('/index.cfm/administracion/usuarios/consultarUsuario', { 
                            pkUsuario: $("#pkUsuario").val() }, function(data) {
                            
                            if ((data.DATA.NOMBRE[0]== null || data.DATA.PATERNO[0]== null || data.DATA.MATERNO[0]== null || data.DATA.GENERO[0]== null ||data.DATA.UR[0]== null || data.DATA.ACRO[0]== null || data.DATA.EMAIL[0]== null || data.DATA.TEL[0]== null || data.DATA.EXT[0]== null || data.DATA.ROL[0]== null || data.DATA.CVEROL[0]== null || data.DATA.USR[0]== null))
                            { 
                                $("#mdl-cambia-pwd").modal('hide');
                                $("#mdl-usuario").modal();

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

                                $("#inNombre").val() != '' ? $('#inNombre').attr('disabled','') : '';
                                $("#inPaterno").val() != '' ? $('#inPaterno').attr('disabled','') : '';
                                $("#inMaterno").val() != '' ? $('#inMaterno').attr('disabled','') : '';
                                $('#inEmail').attr('disabled','');
                                $("#inTel").val() != '' ? $('#inTel').attr('disabled','') : '';
                                $("#inExt").val() != '' ? $('#inExt').attr('disabled','') : '';
                                $('#inRol').attr('disabled','');
                                $("#inUr").val() != '' ? $('#inUr').attr('disabled','') : '';
                                $("#inAcr").val() != '' ? $('#inAcr').attr('disabled','') : '';
                                $('#inUser').attr('disabled','');
                            }else {
                                $("#nuevo").submit();
                            }
                        });
                    }else {
                        toastr.error('Hubo un problema al tratar de completar el registro.');
                    }
                });
            }
        });
        
    });

    function lanzarModal(){
        $("#mdl-cambia-pwd").modal();
        toastr.error('','La contraseña que ha añadido solo sirve para acceder al sistema la primera vez. Será necesario personalizarla. Para lo cual a continuación se presenta el formulario para actualización de la misma.');
    }

</script>