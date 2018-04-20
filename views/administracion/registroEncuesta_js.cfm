<cfprocessingdirective pageEncoding="utf-8">
<style type="text/css">
    .modaltext-content {
  overflow:auto;
}
<!---Css para los radio botones--->
 .radioButton:hover, .radioButton:focus, .radioButton:active, .radioButton.active, .open .dropdown-toggle.radioButton{
  background-color : #0D79C9;
  color : #ffffff;
}
<!---CSS para select--->
 .form-group .bootstrap-select {
  position: relative;
  z-index: 2;
  float: left;
  width: 100%;
  margin-bottom: 0;
  display: table;
  table-layout: fixed;
}
 .bootstrap-select>.dropdown-toggle{
    width: 100%;
    padding-right:25px
  }

  .dropdown-menu {
    width: 100%;
    word-wrap: break-word;

}

 

</style>
<script type="text/javascript">
    var rol;
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
            var pwdActual= 'IPN';
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
                inAcr:     {required:true},
                inEmail:   {required: true, email: true},
                inEmailConf:{required: true, email: true, equalTo: '[name="inEmail"]'},
                inTel:     {required: true, digits: true, maxlength: 15},
                inExt:     {digits: true, maxlength: 6},
                inRol:     {required:true},
                inUser:    {required:true, nombre: true},
                inPassword:{required:true},
                inPasswordConf:{required:true, equalTo: '[name="inPassword"]'}
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            messages: {
                 inPasswordConf: {required:"Confirma tu contraseña.", equalTo:"Las contraseñas no coinciden"},
                 inEmailConf:    {required:"Confirma tu correo electrónico.", equalTo:"Los correos no coiciden"}
            },
            submitHandler: function(form){
                return false;
            }
        }); 


        $("#InfoInicial").validate({
            rules: {
               
               
                rol:      {required:true},
                 Ur:      {required:true}
                
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        }); 

        $("#RegistroEncuesta").on("click", function() {
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
                 var pkUsuario=<cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>;
                 var usr     = $("#inUser").val();
                 $.post('/index.cfm/administracion/usuarios/editarUsuarioEncuesta', { 
                     pkUsuario: pkUsuario, nombre: nombre, apaterno: paterno, amaterno: materno, genero: genero, tel: tel, ext: ext, acr: acr, email: email,psw: psw, rol:rol, usr:usr}, function(data) {
                         if (data > 0) {
                             $("#nuevo").submit();
                         }else {       
                             toastr.error('Hubo un problema al tratar de completar el registro.');
                         }
                 });
             }
        });

        $("#guardaInfoInicial").on("click", function() {
            if($("#Ur").val()!=0 && $("#rol").val()!=0){
               var pkUsuario=<cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>;
               rol=$("#rol").val();
               var ur=$("#Ur").val();

                $.post('/index.cfm/administracion/usuarios/guardarInfoInicial', { 
                    pkUsuario: pkUsuario, rol: rol, ur: ur}, function(data) {
                    if (data > 0) {
                        $("#mdl-inicial").modal('hide');
                        $("#mdl-usuario").modal('show');
                    }else {
                        toastr.error('Hubo un problema al tratar de completar el registro.');
                    }
                });
               
            }
            else{
                toastr.error('Selecciona la información que se solicita.');
            }

        });

        $("#Continuar").on("click", function() {
            $("#nuevo").submit();
        });
        
    });

    function lanzarModal(){
        $("#mdl-inicial").modal('show');
        $('#Ur').selectpicker({
             style: 'btn-info',
             size: 10
         });
        $('#rol').selectpicker({
             style: 'btn-info',
             size: 10
         });

        //mdl-usuario
        toastr.warning('','Antes de iniciar, por favor ingresa la información correspondiente.');
    }

</script>