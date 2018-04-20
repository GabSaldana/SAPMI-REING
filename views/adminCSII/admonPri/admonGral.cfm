<cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="admonGral_js.cfm">
  
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de usuarios y privilegios</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li class="active">
                    <strong>Administración General de usuarios y privilegios</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="btn-group btn-group-justified" role="group" aria-label="...">
        <div class="btn-group" role="group">
            <button type="button" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnAdmUsr" data-toggle="modal" onclick="thrDoc()"><span class="fa fa-external-link-square"></span> Administrar Usuarios</button>
        </div>
        <div class="btn-group" role="group">
            <button type="button2" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnAdmAcc" data-toggle="modal" onclick="secDoc()"><span class="fa fa-external-link-square"></span> Administrar Acciones</button>
        </div>
    </div>

    <div class="ibox float-e-margins">
        <div class="ibox-title guiaPrivSecRoles">
            <h5>Configuración de asignación de privilegios a los roles</h5>
            <div class="ibox-tools">
            </div>
        </div>

        <div class="ibox-content">
            <form role="form" id="form-accion" class="form-horizontal">
                <div class="form-group">          <!--- poner atención al campo --->
                    <input type="hidden" id="pkTemario" value="0">
                    <label class="control-label col-sm-2" class="control-label">Módulo del sistema:</label>
                    <div class="col-sm-4">
                        <select class="form-control m-b guiaPrivSelect" id="inModulo" name="inModulo" onchange="consultarSeccion()"> 
                            <option value="0" selected="selected">Seleccionar un módulo</option>
                            <cfset total_records = request.modulos.recordcount>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput>
                                    <option value="#request.modulos.PK[x]#">#request.modulos.vertiente[x]# - #request.modulos.Nombre[x]#</option>
                                </cfoutput>
                            </cfloop>           
                        </select>
                    </div>
                </div>
            </form>
            <form role="form" id="form-accion" class="form-horizontal">
                <div class="form-group">          <!--- poner atención al campo --->
                    <input type="hidden" id="pkTemario" value="0">
                    <label class="control-label col-sm-2" class="control-label">Roles de usuario:</label>
                    <div id= "recuadros_contenedor" class="col-sm-8"> 
                        <div id="recuadros-roles"></div>                       
                    </div>
                </div>
            </form>
        </div>

        <div class="ibox-title guiaPrivSecRelacion">
            <h5 class="temario">Relación Acción/Rol</h5>
        </div>            
        <div class="ibox-content">
            <div class="ibox-content">
                <div id="columna-uno"></div>
            </div>       
        </div>
    </div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Privilegios.">
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnAdmUsr">
        <div> Administrar Usuarios <br>
            Puede ir a la sección se administran los usuarios.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnAdmAcc">
        <div> Administrar Acciones <br>
            Puede ir a la sección se administran las acciones.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivSecRoles">
        <div> Administración de usuarios y privilegios <br>
            En esta sección se configura la asignación de privilegios a los roles.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivSelect">
        <div> Módulo <br>
            Seleccione el módulo correspondiente al sistema.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivSecRelacion">
        <div> Relación Acción/Rol <br>
            En esta sección se activan las relaciones de Acción/Rol.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnDesAccionRol">
        <div> Desactivar Acción/Rol <br>
            Puede desactivar la relación Acción/Rol del elemento seleccionado.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnActAccionRol">
        <div> Activar Acción/Rol <br>
            Puede activar la relación Acción/Rol del elemento seleccionado.
        </div>
    </li>
   
</ul>
 