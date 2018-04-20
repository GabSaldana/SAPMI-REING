<!---
===============================================================================
* IPN - CSII
* Sistema: SERO
* Modulo: login 
* Sub modulo: 
* Fecha: agosto/2016
* Descripcion: permite el acceso al sistema y muestra contenidos informativos
* Autor: Yareli Andrade
===============================================================================
--->

<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8">

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SX | IPN</title>

    <!-- Hojas de estilo -->
    <link href="/includes/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="/includes/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/includes/css/inspinia/animate.css" rel="stylesheet">
    <link href="/includes/css/inspinia/style.css" rel="stylesheet">
    <link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css">

    <!-- Scripts -->
    <script src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/jquery.validate.min.js"></script>
    <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/localization/messages_es.min.js"></script>
    <script src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>

    <script src="/includes/bootstrap/bootstrap-select/bootstrap-select.min.js"></script>
    <link href="/includes/bootstrap/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">
    <script src="/includes/js/select2/i18n/es.js"></script>
    <!--- <link href="/includes/css/plugins/select2/select2.min.css" rel="stylesheet"> --->
    <link href="/includes/css/plugins/select2/select2.css" rel="stylesheet">

    <cfinclude template="registroEncuesta_js.cfm">
</head>

<body class="gray-bg">

   <div id="mdl-inicial" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="fa fa-exclamation-triangle fa-2x" style="color: red;"></span>
                    <h4 style="color: red;">Estos datos son obligatorios para ingresar a realizar aportaciones.</h4>
                </div> 
                <div class="modal-body">
                    <input type="hidden" id="pkUsuario" name="pkUsuario" class="form-control"/>
                    <form id="InfoInicial" class="form-horizontal" role="form">

                        <div class="form-group">
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="fa fa-user"></span>
                                </span>                     
                                <select id="rol" name="rol" class="form-control selectpicker" data-live-search="true" data-width="100%" >
                                            <option value="0" selected="selected">Seleccionar rol del participante</option>
                                            <cfset total_records = Request.rol.recordcount/>
                                            <cfloop index="x" from="1" to="#total_records#">
                                                <cfoutput><option value="#Request.rol.CVE[x]#" >#Request.rol.ROL[x]#</option></cfoutput>    
                                            </cfloop>
                                        </select>
                            </div> 
                                              
                        </div>    
                        <div class="form-group">
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="fa fa-building"></span>
                                </span>                     
                                 <select id="Ur" name="Ur" class="form-control selectpicker" data-live-search="true" data-width="100%">     
                                        <option value="0" selected="selected">Seleccionar escuela o dependencia</option>
                                        <cfset total_records = Request.ur.recordcount/>
                                        <cfloop index="x" from="1" to="#total_records#">
                                            <cfoutput><option value="#Request.ur.PK[x]#" >#Request.ur.UR[x]#-"#Request.ur.NOMBRE[x]#"</option></cfoutput>    
                                        </cfloop>               
                                    </select>
                            </div> 
                                              
                        </div>                
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="form-group">
                        <button type="button" id="guardaInfoInicial" class="btn btn-success btn-lg pull-right"><span class="fa fa-check-square-o"></span> Continuar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    
    <form id="nuevo" class="m-t" action="<cfoutput>#event.buildLink('login.inicioRapido')#</cfoutput>" method="post">
        <input type="hidden" name="user" id="user">
        <input type="hidden" name="password" id="password">
    </form>

</body>

</html>
 <cfoutput>  
    <div class="row">
    <div id="mdl-usuario" class="modal small inmodal modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="fa fa-exclamation-triangle fa-2x" style="color: red;""></span>
                    <h4 style="color: red;"">Estos datos son opcionales. Si deseas ingresar como anónimo pulsa el botón “Omitir registro” .</h4>
                </div>
                <div class="modal-body" style="overflow-y: auto; height: calc(100vh - 230px);">
                    <form id="validaUsuario" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Datos personales</h3>
                        <div>
                            <label class="control-label">Nombre</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>          
                                        
                                     <input type="text" id="inNombre" name="inNombre" class="form-control" value="#Request.usuario.NOMBRE#" placeholder="Ingresar nombre" maxlength="25"/>
                               
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Apellido Paterno</label>
                            <div class="input-group">   
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                                                 
                                <input type="text" id="inPaterno" name="inPaterno" class="form-control" value="#Request.usuario.AP_PAT#" placeholder="Ingresar apellido paterno" maxlength="25" />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Apellido Materno</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                                                 
                                <input type="text" id="inMaterno" name="inMaterno" class="form-control" value="#Request.usuario.AP_MAT#" placeholder="Ingresar apellido materno" maxlength="25" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Género</label>
                            <div class="radio" data-toggle="buttons">
                                <label for="opcM" class="btn btn-default radioButton active"> <span class="fa fa-male"></span>
                                    <input type="radio" name="inGenero" id="opcM" value="2" checked="checked"> &nbsp; Masculino
                                </label>
                                <label for="opcF" class="btn btn-default radioButton"> <span class="fa fa-female"></span>
                                    <input type="radio" name="inGenero" id="opcF" value="1"> &nbsp; Femenino 
                                </label>
                            </div>
                        </div>
                        <hr>
                        <h3> Datos institucionales</h3>
                        <div class="row">
                            <div class="col-sm-6">
                                <label style="text-align:right;" class="control-label">Titulo</label>  
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select id="inAcr" name="inAcr" class="form-control">     
                                        <option value="" selected="selected">Seleccionar titulo</option>
                                        <cfset total_records = Request.acron.recordcount/>
                                        <cfloop index="x" from="1" to="#total_records#">
                                            <cfoutput><option value="#Request.acron.PK[x]#" >#Request.acron.ACRONIM[x]#</option></cfoutput>    
                                        </cfloop>               
                                    </select>
                                </div>                     
                            </div>
                             <div class="col-sm-6">
                                <label class="control-label">Teléfono</label>
                                <div class="input-group">   
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-earphone"></span>
                                    </span>                                                                         
                                    <input type="text" name="inTel" class="form-control" id="inTel" placeholder="Ingresar teléfono" maxlength="15"  />
                                </div>                     
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-offset-3">
                                <label class="control-label">Extensión</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-option-horizontal"></span>
                                    </span>                        
                                    <input type="text" id="inExt" name="inExt" class="form-control" maxlength="5" placeholder="Ingresar extensión"/>
                                </div>                     
                            </div>
                        </div>
                        <div>
                          <label class="control-label">Correo electrónico</label>
                          <div class="input-group">
                             <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope"></span>
                             </span>
                             <input type="email" name="inEmail" class="form-control"  id="inEmail" placeholder="Ingresar correo electrónico" maxlength="50" />
                          </div>
                        </div>
                        <div>
                          <label class="control-label">Confirma tu correo electrónico</label>
                          <div class="input-group">
                             <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope"></span>
                             </span>
                             <input type="email" name="inEmailConf" class="form-control"  id="inEmailConf" placeholder="Confirma tu correo electrónico" maxlength="50" />
                          </div>
                        </div>
                        <hr>
                        <h3> Cuenta de usuario</h3>
                        <div class="row">
                            <div class="col-sm-6 ">
                                    <label class="control-label">Nombre de usuario</label>
                                    <div class="input-group">                           
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-user"></span>
                                        </span>
                                        <input class="form-control"   value="#Request.usuario.USR#" type="text" id="inUser" name="inUser" maxlength="18">
                                        
                                    </div>
                                        <p class="text-small">Nombre de usuario sugerido por el sistema.</p>
                            </div>
                             <div class="col-sm-6">
                                    <label class="control-label">Password</label>
                                    <div class="input-group">                           
                                        <span class="input-group-addon">
                                            <span class="fa fa-key"></span>
                                        </span>
                                        <input class="form-control"  type="password" id="inPassword" name="inPassword" maxlength="15">
                                        
                                    </div>
                             </div>
                             <div class="col-sm-6">
                                    <label class="control-label">Confirma tu password</label>
                                    <div class="input-group">                           
                                        <span class="input-group-addon">
                                            <span class="fa fa-key"></span>
                                        </span>
                                        <input class="form-control"  type="password" id="inPasswordConf" name="inPasswordConf" maxlength="15">    
                                    </div>
                             </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" id="RegistroEncuesta" class="btn btn-success btn-md pull-right"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
                    <button type="button" id="Continuar" class="btn btn-danger btn-md pull-left"><span class="fa fa-close"></span> Omitir registro</button>
                </div>
            </div>
        </div>
    </div>
</div>
</cfoutput>