<!----
* ================================
* IPN – CSII
* Sistema:     SIIIP (Sistema Institucional de Información de Investigación y Posgrado)
* Modulo:      Convenios
* Sub modulo:  Administracion de Instituciones
* Fecha:       6 de Febrero de 2018
* Descripcion: Vista donde se puede administrar la información de las modalidades de los convenios
* Autor:       Juan Carlos Hernández
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="V_admonModalidades_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de modalidades</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Administración de modalidades</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim btn-crear" data-toggle="modal" href="#mdl-admon-modalidad"><span class="fa fa-plus"></span> Agregar nueva modalidad </button>
            </div>            
            <div id="listaModalidades"></div>
        </div>
    </div>
</div>

<div id="mdl-admon-modalidad" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 9999 !important;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="validaModalidad" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Agregar Nueva Modalidad </h3>
                        <div>
                            <label class="control-label">Nombre</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </span>                     
                                <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar el nombre de la modalidad"  />
                            </div>                    
                        </div>    
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-admon-modalidad"></button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade modaltext" id="mdl-estado-modalidad" tabindex="-1" role="dialog" aria-hidden="true" style="z-index: 9999 !important;">
    <div class="modal-dialog <!--- modal-sm --->">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar Modalidad</h4>
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" id="btn-estado-modalidad"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>
