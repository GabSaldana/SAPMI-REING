<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="estadosRutas_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de estados</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li>
                    <a href="#event.buildLink('admonEdos/admonEdos')#">Control de estados</a>
                </li>
                <li>
                    <a href="#event.buildLink('admonEdos/admonEdos/setRutas')#?pkProcedimiento=<cfoutput>#prc.pkProced#</cfoutput>">Rutas</a>
                </li>
                <li class="active">
                    <strong>Estados</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>ESTADOS REGISTRADOS</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div id="tableRutas"></div>
        </div>
    </div>
</div>

<div id="mdl-estado" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Agregar estado</h4>
            </div>
            <div class="modal-body">
                <input id="inProced" type="hidden" value="<cfoutput>#prc.pkProced#</cfoutput>">
                <input id="inRuta" type="hidden" value="<cfoutput>#prc.pkRuta#</cfoutput>">
                <form id="validaEstado" class="form-horizontal" role="form" onsubmit="return false;">
                    <div>
                        <label class="control-label">Número de estado</label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-pencil"></span>
                            </span>
                            <input type="text" id="inNumero" name="inNumero" class="form-control" placeholder="Ingresar número de estado"  />
                        </div>
                    </div>
                    <div>
                        <label class="control-label">Nombre</label>
                        <div class="input-group">   
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-text-color"></span>
                            </span>
                            <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar nombre" />
                        </div>
                    </div>
                    <div>
                        <label class="control-label">Descripción</label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-menu-hamburger"></span>
                            </span>
                            <input type="text" id="inDescr" name="inDescr" class="form-control" placeholder="Ingresar descripción" />
                        </div>
                    </div>
                    <div>
                        <label class="control-label">Área:</label>
                        <div class="input-group">  
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-comment"></span>
                            </span>                                                 
                            <select id="inArea" name="inArea" class="form-control m-b selectpicker guiaEdoRutNewArea" data-live-search="true" data-style="btn-primary btn-outline" aria-invalid="false">
                                <cfoutput query="PRC.areas">
                                    <option value="#PK_UR#">#NOMBRE_UR#</option>
                                </cfoutput>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" onclick="limpiaModal();"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" onclick="addEstado();">Guardar</button>
            </div>
        </div>
    </div>
</div>


<div class="modal inmodal fade modaltext" id="mdl-borraEstado" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar estado</h4>
            </div>

            <input id="pkEstado" type="hidden" value="">
            <div class="modal-body"></div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" onclick="eliminaEstado();"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>
