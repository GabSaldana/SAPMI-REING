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

    <title>SIIIP | IPN</title>

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

    <cfinclude template="registro_js.cfm">
</head>

<body class="gray-bg">
				    
   <div id="mdl-cambia-pwd" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Cambiar Contraseña</h4>
                </div>
                
                <div class="modal-body">
                    <input type="hidden" id="pkUsuario" name="pkUsuario" class="form-control"/>
                    <form id="registroForm" class="form-horizontal" role="form">

                        <div class="form-group">
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="fa fa-key"></span>
                                </span>                     
                                <input type="password" id="inActual" name="inActual" class="form-control" placeholder="Contraseña actual"/>
                            </div>                    
                        </div>
                        <div class="form-group">
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="fa fa-key"></span>
                                </span>                     
                                <input type="password" id="inPassword" name="inPassword" class="form-control" placeholder="Define una nueva contraseña"/>
                            </div>                    
                        </div>
                        <div class="form-group">
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="fa fa-key"></span>
                                </span>                     
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirma tu contraseña"/>
                            </div>                    
                        </div>                    
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="form-group">
                        <cfoutput>
                        <a class="btn btn-primary btn-lg cancelar" href="#event.buildLink('login.cerrarSesion')#">Cancelar</a>
                        </cfoutput>
                        <button type="button" id="cambiaPwd" class="btn btn-default btn-lg pull-right"><span class="glyphicon glyphicon-floppy-disk"></span> Registrar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div id="mdl-usuario" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Actualizar información</h4>
                </div>
                <div class="modal-body">
                    <form id="validaUsuario" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Datos personales</h3>
                        <div>
                            <label class="control-label">Nombre</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                     
                                <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar nombre"  />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Apellido Paterno</label>
                            <div class="input-group">   
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                                                 
                                <input type="text" id="inPaterno" name="inPaterno" class="form-control" placeholder="Ingresar apellido paterno" />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Apellido Materno</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                                                 
                                <input type="text" id="inMaterno" name="inMaterno" class="form-control" placeholder="Ingresar apellido materno" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Género</label>
                            <div class="radio" data-toggle="buttons">
                                <label for="opcM" class="btn btn-default active"> <span class="fa fa-male"></span>
                                    <input type="radio" name="inGenero" id="opcM" value="1" checked="checked"> &nbsp; Masculino
                                </label>
                                <label for="opcF" class="btn btn-default"> <span class="fa fa-female"></span>
                                    <input type="radio" name="inGenero" id="opcF" value="2"> &nbsp; Femenino 
                                </label>
                            </div>
                        </div>
                        <hr>
                        <h3> Datos institucionales</h3>
                        <div class="row">
                            <div class="col-sm-6">
                                <label style="text-align:right;" class="control-label">Unidad Responsable</label>  
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select id="inUr" name="inUr" class="form-control">     
                                        <option value="" selected="selected">Seleccionar UR</option>
                                        
					
					<!---<cfset total_records = Request.ur.recordcount/>
                                        <cfloop index="x" from="1" to="#total_records#">
                                            <cfoutput><option value="#Request.ur.PK[x]#" >#Request.ur.UR[x]#</option></cfoutput>    
                                        </cfloop>--->               
                                    </select>
                                </div>                     
                            </div>
                            <div class="col-sm-6">
                                <label style="text-align:right;" class="control-label">Acrónimo</label>  
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-tags"></span>
                                    </span>                     
                                    <select id="inAcr" name="inAcr" class="form-control">     
                                        <option value="" selected="selected">Seleccionar acrónimo</option>
                                        <cfset total_records = Request.acron.recordcount/>
                                        <cfloop index="x" from="1" to="#total_records#">
                                            <cfoutput><option value="#Request.acron.PK[x]#" >#Request.acron.ACRONIM[x]#</option></cfoutput>    
                                        </cfloop>               
                                    </select>
                                </div>                     
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="control-label">Teléfono</label>
                                <div class="input-group">   
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-earphone"></span>
                                    </span>                                                                         
                                    <input type="text" name="inTel" class="form-control" id="inTel" placeholder="Ingresar teléfono"  />
                                </div>                     
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label">Extensión</label>
                                <div class="input-group">                           
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-option-horizontal"></span>
                                    </span>                        
                                    <input type="text" id="inExt" name="inExt" class="form-control" maxlength="5" placeholder="Ingresar extensión"  />
                                </div>                     
                            </div>
                        </div>
                        <div>
                          <label class="control-label">Correo Electrónico</label>
                          <div class="input-group">
                             <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope"></span>
                             </span>
                             <input type="email" name="inEmail" class="form-control"  id="inEmail" placeholder="Ingresar correo electrónico" />
                          </div>
                        </div>
                        <hr>
                        <h3> Cuenta de usuario</h3>
                        <div class="row">
                            <div class="col-sm-6">
                                    <label style="text-align:right;" class="control-label">Rol</label>  
                                    <div class="input-group ">                           
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-tags"></span>
                                        </span>                     
                                        <select id="inRol" name="inRol" class="form-control">
                                            <option value="" selected="selected">Seleccionar rol</option>
                                            <cfset total_records = Request.rol.recordcount/>
                                            <cfloop index="x" from="1" to="#total_records#">
                                                <cfoutput><option value="#Request.rol.CVE[x]#" >#Request.rol.ROL[x]#</option></cfoutput>    
                                            </cfloop>
                                        </select>
                                    </div>
                            </div>
                            <div class="col-sm-6">
                                    <label class="control-label">Nombre de usuario</label>
                                    <div class="input-group">                           
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-user"></span>
                                        </span>
                                        <span class="input-group-addon" id="inPref" style="width:52px"></span>
                                        <input class="form-control" style="text-transform:uppercase;" type="text" id="inUser" name="inUser">
                                        
                                    </div>
                                        <p class="text-small">Nombre de usuario sugerido por el sistema.</p>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" id="actualizaUsr" class="btn btn-success btn-lg pull-right">Actualizar</button>
                </div>
            </div>
        </div>
    </div>

    <form id="nuevo" class="m-t" action="<cfoutput>#event.buildLink('login.autenticacion')#</cfoutput>" method="post">
        <input type="hidden" name="user" id="user">
        <input type="hidden" name="password" id="password">
    </form>

</body>

</html>
