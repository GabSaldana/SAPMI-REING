<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="admonAcc_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <cfoutput>
        <h2>Acciones del Sistema</h2>
        <ol class="breadcrumb">
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li>
                <a href="#event.buildLink('admonPri/admonPri')#">Administración de Roles </a>
            </li>
            <li class="active">
                <strong>Administración de Acciones</strong>
            </li>
        </ol>
        </cfoutput>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="btn-group btn-group-justified" role="group" aria-label="...">
        <div class="btn-group" role="group">
            <button type="button" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnAdmGral" data-toggle="modal" onclick="secDoc()"><span class="fa fa-arrow-left"></span> Administración General</button>
        </div>
              
        <div class="btn-group" role="group">
            <button type="button2" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnAdmRol" data-toggle="modal" onclick="thrDoc()"><span class="fa fa-external-link-square"></span> Administrar Roles</button>
        </div>
    </div>
    <div class="ibox float-e-margins">
        <div class="ibox-title guiaPrivAdmAcc">
            <h5 class="selecciona-tema"> Administración de acciones</h5>
        </div>
		<div class="ibox-content">
			<form role="form" id="form-accion" class="form-horizontal">
				<div class="form-group">
                    <input type="hidden" id="pkTemario" value="0">
		           	<label class="control-label col-sm-2" for="">Módulo del sistema:</label>
					<div class="col-sm-10">
		             	<select class="form-control m-b guiaPrivSelect" id="inrol" name="inrol" onchange="consultarAcciones()"> 
		             		<option value="0" selected="selected">Seleccionar un módulo</option>
		                    <cfset total_records = request.modulos.recordcount>
		                    <cfloop index="x" from="1" to="#total_records#">
		                        <cfoutput><option value="#request.modulos.PK[x]#">#request.modulos.vertiente[x]# - #request.modulos.Nombre[x]#</option></cfoutput>
	                    	</cfloop>           
		              	</select>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div class="ibox float-e-margins">
        <div class="ibox-title guiaPrivAdmTemas">
            <h5 class="temario">Temas registrados</h5>
        </div>            
        <div class="ibox-content">
            <div class="lft-btn text-center">
                <button type="button2" class="btn btn-primary btn-outline dim btn-crear guiaPrivBtnNewAcc" data-toggle="modal" href="#mdl-admon-accion"><span class="glyphicon glyphicon-plus"></span> Agregar una nueva Acción</button>
            </div>
        	<div id="eval-accion"></div>
            <div id="eval-accion2"></div>
    	</div>
	
	</div>
</div>

<div id="mdl-admon-accion" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 9999 !important;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="validaAccion2" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Nueva Acción</h3>                      
                        
                        <div>
                            <label class="control-label">Acción:</label>
                            <div class="input-group">   
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-tag"></span>
                                </span>                                                 
                                <input type="text" id="inAccion" name="inAccion" class="form-control" placeholder="Ingresar el titulo de la acción" />
                            </div>                    
                        </div>                    
                        <div>
                            <label class="control-label">Descripción:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-comment"></span>
                                </span>                                                 
                                <input type="text" id="inCom" name="inCom" class="form-control" placeholder="Ingresar descripción de las funciones de la acción" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Orden</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="fa fa-list-ol"></span>
                                </span>                     
                                <input type="text" id="inOrden" name="inOrden" class="form-control" placeholder="Ingresar valor 1"  />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Clave</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </span>                     
                                <input type="text" id="inClave" name="inClave" class="form-control" placeholder="Ingresar la clave de la acción"  />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Icono:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-comment"></span>
                                </span>                                                 
                                <input type="text" id="inIcon" name="inIcon" class="form-control"  onkeyup="search(this)" placeholder="fa fa-icons" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Vista Previa Icono</label>
                            <br>
                            <div class="input-group">  
                                <button id= "viewIcon" name = "viewIcon" type="button" class="btn btn-default " ></button><span class="nav-label"></span>
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
<div class="modal inmodal fade modaltext" id="mdl-estado-accion" tabindex="-1" role="dialog" aria-hidden="true" style="z-index: 9999 !important;">
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
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnAdmRol">
        <div> Administrar Roles <br>
            Puede ir a la sección se administran roles.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivAdmAcc">
        <div> Administración de acciones <br>
            En esta sección se configuran las acciones.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivSelect">
        <div> Módulo <br>
            Seleccione el módulo correspondiente al sistema.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivAdmTemas">
        <div> Temas registrados <br>
            En esta sección se muestran los temas registrados.
        </div>
    </li>   
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivBtnNewAcc">
        <div> Agregar nueva Acción <br>
            Puede agregar una nueva Acción.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div> Búsqueda <br>
            Puede realizar la búsqueda de un rol.
        </div>
    </li>
    <!--- Guia tablaAccion--->
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivEditar">
        <div> Editar <br>
            Puede editar la acción.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivDesactivar">
        <div> Desactivar <br>
            Puede desactivar la acción.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaPrivValidar">
        <div> Validar <br>
            Puede validar la acción.
        </div>
    </li>

</ul>
 
