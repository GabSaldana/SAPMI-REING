

<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">
var visitas=0;
$(document).ready(function() {
   // $("#mdlAviso").modal();
    //Se inicializa el contador de visitas


     <cfif isDefined("Request.visitas")>
         var visitas=<cfoutput>#Request.visitas#</cfoutput>;
         var res = "";
         if(visitas == 0){
             res = '<span style=" background-color: white; color: gray;"class="badge badge-success millar"><h4>0</h4></span> ';
         }
         else{
             while(visitas > 0){
                res = '<span style=" background-color: white; color: gray;"class="badge badge-success millar"><h4>'+(Math.trunc(visitas%10))+'</h4></span> ' + res;
                visitas = Math.trunc(visitas/10);
             }
         }
         $('#visitas').html(res);



         var aportaciones=<cfoutput>#Request.aportaciones#</cfoutput>;
         var res = "";
         if(aportaciones == 0){
             res = '<span style=" background-color: white; color: gray;"class="badge badge-success millar"><h4>0</h4></span> ';
         }
         else{
             while(aportaciones > 0){
                res = '<span style=" background-color: white; color: gray;"class="badge badge-success millar"><h4>'+(Math.trunc(aportaciones%10))+'</h4></span> ' + res;
                aportaciones = Math.trunc(aportaciones/10);
             }
         }
         $('#aportaciones').html(res);
     </cfif>
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
        if (/^[a-zA-Z_áéíóúñ\s]/.test(value)){
            return true;
        }else{
            return false;
        };
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

    
    
});

function modalRecuperar(){
    $(".continuar").hide();
    $(".enviar").show();
    $(".form-control").removeClass('error');
    $("label.error").remove();
     $("#nomUser").show(); 
    $("#nomUser").val('');
    $("#email").val('');
    $("#email").hide();
    $("#email").removeAttr("disabled","disabled");
    $("#mdl-recuperar-pwd").modal();
}

function modalDocumentos(){
    $('#documentos_consulta').modal('toggle');  
}

function modalPdf(){
    $('#mdl-diagnostico').modal('toggle');
}

function inicioRegistrado(){
    $('#login_registrado').modal('toggle');   
}


function consultarEmail(){
    if($('#userName').valid()){
        $.post('/index.cfm/administracion/usuarios/getEmail', {
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
        $.post('/index.cfm/administracion/usuarios/recuperarPwd', {
                nomUsuario: $("#nomUser").val(),
                email: $("#email").val()
            }, function(data){
                if(data == 1){
                    toastr.success('Recuperada','Contraseña');
                    $("#mdl-recuperar-pwd").modal('hide');
                    $("#email").val('');
                   
                }else{
                    toastr.error('Contraseña','Error al recuperar');
                    $("#mdl-recuperar-pwd").modal('hide');
                    $("#email").val('');

                }
            }
        );  
    }
}

function iniciosesionAdministracion(){
    window.location= '/index.cfm/login/inicioSesionAdministradores';
}



</script>