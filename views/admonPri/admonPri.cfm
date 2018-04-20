<cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="admonPri_js.cfm"> 
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de usuarios y privilegios</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Administración de usuarios y privilegios</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="btn-group btn-group-justified" role="group" aria-label="...">
        <div class="btn-group" role="group">
            <button type="button" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnAdmGral" data-toggle="modal" onclick="secDoc()"><span class="fa fa-arrow-left"></span> Administración General</button>
        </div>
              
        <div class="btn-group" role="group">
            <button type="button2" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnAdmAcc" data-toggle="modal" onclick="newDoc()"><span class="fa fa-external-link-square"></span> Administrar Acciones</button>
        </div>
    </div>
    <div class="ibox float-e-margins">
        <div class="ibox-title guiaPrivRegistrados">
            <h5>Configuración de asignación de privilegios a los roles</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnNewRol" data-toggle="modal" href="#mdl-admon-usuario"><span class="fa fa-user-plus"></span> Agregar nuevo Rol </button>
            </div>            
            <div id="lista"></div>
        </div>
    </div>
</div>

<div id="mdl-admon-usuario" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 9999 !important;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="validaUsuario" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Agregar Nuevo Rol de Acceso al Sistema</h3>
                        <div>
                            <label class="control-label">Nombre</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>                     
                                <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar el nombre del usuario"  />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Clave:</label>
                            <div class="input-group">   
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-tag"></span>
                                </span>                                                 
                                <input type="text" id="inClave" name="inClave" class="form-control" placeholder="Ingresar la clave asignada del usuario" />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Prefijo:</label>
                            <div class="input-group">   
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-tag"></span>
                                </span>                                                 
                                <input type="text" id="inPrefijo" name="inPrefijo" class="form-control" placeholder="Ingresar el prefijo identificator del usuario" />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Descripción:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-comment"></span>
                                </span>                                                 
                                <input type="text" id="inDesc" name="inDesc" class="form-control" placeholder="Ingresar descripción de las funciones del usuario" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Modulo en que inicia sesi&oacute;n:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-comment"></span>
                                </span>                                                 
                                <select id="inModulo" name="inModulo" class="form-control">
                                    <option value="0">Seleccione una opción</option>
                                    <cfset total_records = prc.modulos.recordcount>
                                    <cfloop index="x" from="1" to="#total_records#">
                                        <cfoutput>
                                            <option value="#prc.modulos.PK[x]#">#prc.modulos.NOMBRE[x]#</option>
                                        </cfoutput>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                        <div>
                            <label class="control-label">Vertiente:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-comment"></span>
                                </span>                                                 
                                <select id="inVert" name="inVert" class="form-control">
                                    <option value="-1">Seleccione una opción</option>
                                    <cfset total_records = prc.vertientes.recordcount>
                                    <cfloop index="x" from="1" to="#total_records#">
                                        <cfoutput>
                                            <option value="#prc.vertientes.PKVERT[x]#">#prc.vertientes.NOMVERTIENTE[x]#</option>
                                        </cfoutput>
                                    </cfloop>
                                </select>
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
<div class="modal inmodal fade modaltext" id="mdl-estado-usuario" tabindex="-1" role="dialog" aria-hidden="true" style="z-index: 9999 !important;">
    <div class="modal-dialog <!--- modal-sm --->">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar Rol</h4>
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" id="btn-estado-usr"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Privilegios.">
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnAdmGral">
        <div> Administración General <br>
            Puede ir a la sección se configura la asignación de privilegios a los roles.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnAdmAcc">
        <div> Administrar Acciones <br>
            Puede ir a la sección se administran las acciones.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivRegistrados">
        <div> Privilegios <br>
            En esta sección se encuentran los privilegios registrados.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnNewRol">
        <div> Agregar nuevo Rol <br>
            Puede agregar un nuevo rol.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div> Búsqueda <br>
            Puede realizar la búsqueda de un rol.
        </div>
    </li>
    <!--- Guia tablaRol--->
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivEditar">
        <div> Editar <br>
            Puede editar la información del rol.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivDesactivar">
        <div> Desactivar <br>
            Puede desactivar el rol seleccionado.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivValidar">
        <div> Validar <br>
            Puede validar el rol seleccionado.
        </div>
    </li>
</ul>