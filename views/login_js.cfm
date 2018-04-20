<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$(document).ready(function() {
    
   $("#mdlAviso").modal();

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
        "timeOut": "4000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };

    jQuery.validator.addMethod("nombre", function (value, element) {
            return true;
    }, "* Verifique el campo Nombre.");

    jQuery.validator.addMethod("dosCampos", function () {
        if ( ($("#nomUser").val() == '') && ($("#email").val() == '') ){
            return false;
        } else{
            return true;
        };
    }, "Este campo es obligatorio.");

    $("#userName").validate({
        rules: {
            nomUser: {dosCampos: true, nombre: true},
            email: {dosCampos: true}
        },
        messages: {
            nomUser: {
                dosCampos: "* Este campo es requerido.",
                nombre: "* Debe comenzar con una letra."
            },
            email: {
                dosCampos: "* Este campo es requerido."
            }
        },
        submitHandler: function(form){
            return false;
        }
    });


    $(function(){
        $(".divCarrusel").slick({
          dots: true,
          infinite: true
        });
    });

    
});

function modalRecuperar(){
    $(".continuar").hide();
    $(".enviar").show();
    $(".form-control").removeClass('error');
    $("label.error").remove();
    $("#nomUser").val('');
    $("#email").val('');
    $("#email").hide();
    $("#email").removeAttr("disabled","disabled");
    $("#mdl-recuperar-pwd").modal();
}

function consultarEmail(){
    if($('#userName').valid()){ 
        $.post('/index.cfm/adminCSII/usuarios/usuarios/getEmail', {
                userName: $("#nomUser").val()
            }, function(data){
                if(data.DATA.TUS_USUARIO_EMAIL[0] != undefined){
                    $("#email").attr("disabled","disabled");
                    $("#email").val(data.DATA.TUS_USUARIO_EMAIL[0]);
                    $(".enviar").hide();
                    $("#nomUser").hide();
                    $("#email").show();
                    $(".continuar").show();
                }else{
                    toastr.error('No existe','Nombre de usuario');
                    $("#mdl-recuperar-pwd").modal('hide');
                    $("#email").val('');
                }
            }
        );  
    }
}

function recuperar(){
    if($('#userName').valid()){ 
        $.post('/index.cfm/adminCSII/usuarios/usuarios/recuperarPwd', {
                nomUsuario: $("#nomUser").val(),
                email: $("#email").val()
            }, function(data){
                if(data == 1){
                    toastr.success('Recuperada','Contraseña');
                    $("#mdl-recuperar-pwd").modal('hide');
                    $("#email").val('');
                    $("#nomUser").show();
                }else{
                    toastr.error('Contraseña','Error al recuperar');
                    $("#mdl-recuperar-pwd").modal('hide');
                    $("#email").val('');
                }
            }
        );  
    }
}


function registraParticipante(){
    window.location= '/index.cfm/adminCSII/autoRegistro/autoRegistro/index';
}


function muestraPass(){
    passField = document.getElementById("password");

    if (passField.type == "text") {
        passField.type = "password";
    }else {
        passField.type = "text";
    }

    $("#eyePass").toggleClass("fa-eye").toggleClass("fa-eye-slash");
}


</script>