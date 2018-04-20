<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="usuarios_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de usuarios</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Administración de usuarios</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title listaUsuarios">
            <h5>USUARIOS REGISTRADOS</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim btn-crear" data-toggle="modal" href="#mdl-admon-usuario"><span class="glyphicon glyphicon-plus"></span> AGREGAR USUARIO</button>
            </div>
            <div id="usuarios"></div>
        </div>
    </div>

</div>

<!--- Modal (AGREGAR/EDITAR)--->
<div id="mdl-admon-usuario" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
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
                                        <cfset total_records = Request.ur.recordcount/>
                                        <cfloop index="x" from="1" to="#total_records#">
                                            <cfoutput><option value="#Request.ur.PK[x]#" >#Request.ur.UR[x]#</option></cfoutput>    
                                        </cfloop>               
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
                                        <p class="text-small" <!--- style="margin-left: 40px;" --->>Nombre de usuario sugerido por el sistema.</p>
                            </div>
                        </div>
                        
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-admon-usr"></button>
            </div>
        </div>
    </div>
</div>

<!-- ELIMINAR/VALIDAR/CANCELAR USUARIOS -->
<div class="modal inmodal fade modaltext" id="mdl-estado-usuario" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog <!--- modal-sm --->">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar usuario</h4>
                <input type="hidden" id="mail" value="">
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" id="btn-estado-usr"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>
