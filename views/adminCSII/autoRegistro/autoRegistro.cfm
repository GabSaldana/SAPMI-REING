<cfprocessingdirective pageEncoding="utf-8">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2> Oferta de capacitaciones </h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Página de inicio</a>
            </li>
            <li class="active">
                <strong>Oferta de capacitaciones</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div id="pnl-nuevoParticipante" style="margin-left:10%; margin-right:10%; display:none; margin-bottom: 50px;">
    <div class="row">
        <div class="panel panel-success">
            <div class="panel-heading">
                <a onclick="muestraCursos();" class="btn btn-success pull-right"><i class="fa fa-times"></i></a>
                <h4 id="tituloPanel">Registro del participante</h4>
            </div>
            <div class="panel-body">
                <!--- Panel Registrar Participante --->
                <form class="form-horizontal" id="formParticipante" role="form" onsubmit="return false;">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-4 col-md-offset-1">
                                <label class="control-label">* Nombre:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>                        
                                    <input id="nombre" name="nombre" type="text" class="form-control" Maxlength="45"/>
                                </div>                     
                            </div>

                            <div class="col-sm-3">
                                <label class="control-label">* Apellido paterno:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>                        
                                    <input id="paterno" name="paterno" type="text" class="form-control" Maxlength="45"/>
                                </div>                     
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label">* Apellido materno:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>                        
                                    <input id="materno" name="materno" type="text" class="form-control" Maxlength="45"/>
                                </div>                     
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-offset-1">
                                <label class="control-label">* Acrónimo:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select class="form-control m-b" name="acron" id="acron">   
                                        <option value="-1" selected="selected">Seleccionar una opción</option>
                                        <cfoutput query="prc.acron">
                                        <option value="#PK#">#NOMBRE#</option>
                                        </cfoutput>               
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <label class="control-label">* Procedencia:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select class="form-control" name="procedencia" id="procedencia">   
                                        <option value="-1" selected="selected">Seleccionar una opción</option>
                                        <cfoutput query="prc.proced">
                                        <option value="#PK#">#NOMBRE#</option>
                                        </cfoutput>               
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-10 col-md-offset-1">
                                <label class="control-label">* Género:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>                     
                                    <select class="form-control" name="genero" id="genero">   
                                        <option value="-1" selected="selected">Seleccionar una opción</option>
                                        <cfoutput query="prc.genero">
                                            <option value="#PK#">#NOMBRE#</option>
                                        </cfoutput>           
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-offset-1">
                                <label class="control-label">* RFC:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-option-horizontal"></span>
                                    </span>                        
                                    <input id="rfc" name="rfc" type="text" class="form-control" Maxlength="14"/>
                                </div>                     
                            </div>
                            <div class="col-sm-5">
                                <label class="control-label">* Homoclave:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-option-horizontal"></span>
                                    </span>                        
                                    <input id="homoclave" name="homoclave" type="text" class="form-control" Maxlength="45"/>
                                </div>                     
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-3 col-md-offset-1">
                                <label class="control-label">* Teléfono:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-earphone"></span>
                                    </span>                        
                                    <input id="tel" name="tel" type="text" class="form-control" Maxlength="10"/>
                                </div>                     
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label">* Extensión:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-option-horizontal"></span>
                                    </span>                        
                                    <input id="ext" name="ext" type="text" class="form-control" Maxlength="3"/>
                                </div>                     
                            </div>
                            <div class="col-sm-4">
                                <label class="control-label">* Correo:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-envelope"></span>
                                    </span>                        
                                    <input id="correo" name="correo" type="text" class="form-control" Maxlength="45"/>
                                </div>                     
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-10 col-md-offset-1">
                                <label class="control-label">* Empresa:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-registration-mark"></span>
                                    </span>                        
                                    <input id="empresa" name="empresa" type="text" class="form-control" Maxlength="75"/>
                                </div>                     
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-offset-1">
                                <label class="control-label">* Contraseña:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="fa fa-key"></span>
                                    </span>                        
                                    <input id="inPwd" name="inPwd" type="text" class="form-control" Maxlength="14"/>
                                </div>                     
                            </div>
                            <div class="col-sm-5">
                                <label class="control-label">* Confirmacion de contraseña:</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="fa fa-key"></span>
                                    </span>                        
                                    <input id="confPwd" name="confPwd" type="text" class="form-control" Maxlength="45"/>
                                </div>                     
                            </div>
                        </div>
                    </div>
                    <br><br>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-offset-1">
                                <div class="input-group">
                                    <span class="input-group-addon" onclick="getCaptcha();">
                                        <span class="glyphicon glyphicon-refresh"></span>
                                    </span>
                                    <div id="idCaptcha"></div>  
                                </div>                    
                            </div>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-font"></span>
                                    </span>
                                    <input id="inCaptcha" name="inCaptcha" type="text" class="form-control" Maxlength="7" placeholder="Escribe el texto de la imagen de la izquierda"/>
                                </div>                     
                            </div>
                        </div>
                    </div>
                </form>
                <br>
                <div class="form-group">
                    <div class="row">
                        <div class="col-sm-10 col-md-offset-1 text-center">
                            <a class="btn btn-danger" onclick="muestraCursos();"><i class="fa fa-times"></i> Cancelar</a>
                            <a class="btn btn-warning col-md-offset-1" onclick="limpiaForm();"><i class="fa fa-eraser"></i> Limpiar</a>
                            <a class="btn btn-success col-md-offset-1" onclick="registraParticipante();"><i class="fa fa-floppy-o"></i> Guardar</a>
                        </div>
                    </div>
                </div>
                <!--- END Panel Registrar Participante --->
            </div>
        </div>
    </div>
</div>

<div style="margin-left:10%; margin-right:10%">
    <div id="tablaOferta"> </div>
</div>

<div class="pnl-inicio" style="margin-left:38%; margin-right:10%; margin-top: 11%; display:none;">
    <div class="row">
        <div class="col-sm-10"><h2>Inicia sesión</h2>
            <h3>Cuenta de usuario creada exitosamente</h3>
            <h4>Su cuenta de usuario y contraseña fue enviada al correo <span id="corInfo"></span> </h4>
            <p style="margin-left:25%;">
                <cfoutput>
                    <a href="#event.buildLink('login.cerrarSesion')#"><i class="fa fa-sign-in big-icon"></i></a>
                </cfoutput>
            </p>
        </div>
    </div>
</div>


<script type="text/javascript">

    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: Oculta el formulario de registro y muestra el inicio de sesion.
    --->
    function muestraInicio(){
        $("#pnl-nuevoParticipante").hide();
        $(".pnl-inicio").show();
        $("#formParticipante")[0].reset();
    }


    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: Limpia el formulario de registro.
    --->
    function limpiaForm(){
        $("#formParticipante")[0].reset();
        getCaptcha();
    }


    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: Obtiene la oferta de cursos de las vertientes
    --->
    function consultaOferta(){
        $.post('<cfoutput>#event.buildLink("adminCSII.autoRegistro.autoRegistro.getOferta")#</cfoutput>', {

        },
        function(data){
            $('#tablaOferta').html(data);
        });
    }


    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: Oculta la tabla de oferta de cursos y muestra formulario de registro.
    --->
    function regitraParticipante(){
        $("#tablaOferta").hide();
        $("#pnl-nuevoParticipante").show();
        $("#pnl-nuevoParticipante").slideDown( 1000,'easeOutExpo');
    }


    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: Muestra la oferta de cursos (cierra formulario de registro)
    --->
    function muestraCursos(){
        $("#pnl-nuevoParticipante").hide();
        $("#tablaOferta").show();
        $("#tablaOferta").slideDown(1000,'easeOutExpo');
    }


    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: Guarda el registro en TPARTICIPANTE y USRTUSUARIO (envia correo de confirmacion)
    --->
    function registraParticipante(){

        jQuery.validator.addMethod("nombre", function (value, element) {
            if (/^[a-zA-Z_áéíóúñ\s]/.test(value)){
                return true;
            }else {
                return false;
            };
        }, "* Verificar el campo nombre.");


        jQuery.validator.addMethod("RFC", function (value, element) {
            if (/^(([A-Z]|[a-z]){4})([0-9]{6})/.test(value)) {
                return true;
            }else {
                return false;
            };
        }, "* Verifique el campo RFC.");

        var validaParticipante = $("#formParticipante").validate({
            rules: {
                nombre:      {required: true, nombre: true},
                paterno:     {required: true, nombre: true},
                materno:     {required: true, nombre: true},
                rfc:         {RFC:true, required: true},
                homoclave:   {required:true},
                procedencia: {required: true, min:1},
                acron:       {required:true, min:1},
                genero:      {required:true, min:1},
                correo:      {required: true, email: true},
                tel:         {required: true, digits: true, maxlength: 15},
                ext:         {digits: true, maxlength: 6},
                empresa:     {required:true},
                confPwd:     {equalTo: "#inPwd"},
                inCaptcha:   {equalTo: "#capOriginal"}
            }, messages: {
                acron:       {min:"Este campo es obligatorio."},
                genero:      {min:"Este campo es obligatorio."},
                procedencia: {min:"Este campo es obligatorio."}
            }, submitHandler: function(form) {
                return true;
            },errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            }
        });

        if (validaParticipante.form()){
            $.post('/index.cfm/adminCSII/autoRegistro/autoRegistro/registraParticipante', {
                    acr:  $('#acron option:selected').val(),
                    nom:  $('#nombre').val(),
                    pat:  $('#paterno').val(),
                    mat:  $('#materno').val(),
                    gen:  $('#genero option:selected').val(),
                    rfc:  $('#rfc').val(),
                    hom:  $('#homoclave').val(),
                    proc: $('#procedencia').val(),
                    tel:  $('#tel').val(),
                    ext:  $('#ext').val(),
                    mail: $('#correo').val(),
                    emp:  $('#empresa').val(),
                    pwd:  $('#inPwd').val(),
                    rol:  39
                }, function(data){
                    if (data > 0){
                        $("#corInfo").text($('#correo').val());
                        muestraInicio();
                    }else {
                        toastr.error('Al registrar el usuario','Problema');
                    }
                }
            );
        }
    }


    <!---
    * Fecha : Agosto de 2017
    * Autor : Alejandro Tovar
    * Comentario: obtiene la vista de captcha
    --->
    function getCaptcha(){
        $.post('<cfoutput>#event.buildLink("adminCSII.autoRegistro.autoRegistro.getCaptcha")#</cfoutput>', {
        },
        function(data){
            $('#idCaptcha').html(data);
        });
    }


    $(document).ready(function() {

        consultaOferta();
        getCaptcha();

        toastr.options = {
          "closeButton": true,
          "debug": false,
          "progressBar": true,
          "preventDuplicates": false,
          "newestOnTop": true,
          "positionClass": "toast-top-right",
          "onclick": null,
          "showDuration": "400",
          "hideDuration": "5000",
          "timeOut": "4000",
          "extendedTimeOut": "2000",
          "showEasing": "swing",
          "hideEasing": "linear",
          "showMethod": "fadeIn",
          "hideMethod": "fadeOut"
        };
    });


</script> 