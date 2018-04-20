<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="avisos_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de avisos</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li class="active">
                    <strong>Administración de avisos</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>Avisos registrados</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim" onclick="abreModal();"><span class="glyphicon glyphicon-plus"></span> Agregar aviso</button>
            </div>
            <div id="listadoAvisos"></div>
        </div>
    </div>

</div>

<div id="mdl-admon-avisos" class="modal inmodal fade modaltext" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Avisos</h4>
            </div>
            <div class="modal-body">
                <input id="pkAvisoEditar" type="hidden" value="0">
                <div>
                    <label class="control-label">Nombre</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-font"></span>
                        </span>
                        <input id="nombre" type="text" class="form-control" placeholder="Ingresar nombre"/>
                    </div>
                </div>
                <div>
                    <label class="control-label">Mensaje</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-envelope"></span>
                        </span>
                        <input id="mnsj" type="text" class="form-control" placeholder="Ingresar mensaje"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <label class="control-label">Fecha inicio</label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                            <input id="fecIni" type="text" class="form-control date" placeholder="Fecha inicio" readonly>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <label class="control-label">Fecha Fin</label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                            <input id="fecFin" type="text" class="form-control date" placeholder="Fecha fin" readonly>
                        </div>
                    </div>
                </div>
                <div>
                    <label class="control-label">Redirecciónamiento</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-share-alt"></span>
                        </span>
                        <input id="redir" type="text" class="form-control" placeholder="Ruta del módulo"/>
                    </div>
                </div><br>
                <h3>Roles por vertiente</h3>
                <div>
                    <label class="control-label">Vertiente</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-share-alt"></span>
                        </span>
                        <select id="inVert" class="form-control" onchange="getRoles();">     
                            <option value="-1" selected="selected">Seleccionar acrónimo</option>
                            <cfset total_records = prc.vertiente.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.vertiente.PK[x]#" >#prc.vertiente.VERT[x]#</option></cfoutput>    
                            </cfloop>               
                        </select>
                    </div>
                </div>

                <div class="rolesVert"></div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right btn-cambio"></button>
            </div>
        </div>
    </div>
</div>
