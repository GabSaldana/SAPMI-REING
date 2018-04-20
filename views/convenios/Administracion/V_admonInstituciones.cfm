<!----
* ================================
* IPN – CSII
* Sistema:     SIIIP (Sistema Institucional de Información de Investigación y Posgrado)
* Modulo:      Convenios
* Sub modulo:  Administracion de Instituciones
* Fecha:       1 de Febrero de 2018
* Descripcion: Vista donde se puede administrar la información de las instituciones
* Autor:       Juan Carlos Hernández
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="V_admonInstituciones_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de instituciones</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Administración de instituciones</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim btn-crear" data-toggle="modal" href="#mdl-admon-institucion"><span class="fa fa-plus"></span> Agregar nueva institución </button>
            </div>            
            <div id="listaInstituciones"></div>
        </div>
    </div>
</div>

<div id="mdl-admon-institucion" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 9999 !important;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="validaInstitucion" class="form-horizontal" role="form" onsubmit="return false;">
                        <h3> Agregar Nueva Institución </h3>
                        <div>
                            <label class="control-label">Nombre</label>
                            <div class="input-group">                           
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-home"></span>
                                </span>                     
                                <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar el nombre de la institución"  />
                            </div>                    
                        </div>
                        <div>
                            <label class="control-label">Ubicación:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-map-marker"></span>
                                </span>                                                 
                                <input type="text" id="inUbicacion" name="inUbicacion" class="form-control" placeholder="Ingresar la dirección donde se ubica la institución" />
                            </div>                   
                        </div>
                        <div>
                            <label class="control-label">Descripción:</label>
                            <div class="input-group">  
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-comment"></span>
                                </span>                                                 
                                <input type="text" id="inDescripcion" name="inDescripcion" class="form-control" placeholder="Ingresar descripción de la función principal de la institución" />
                            </div>                   
                        </div>      
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-admon-institucion"></button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade modaltext" id="mdl-estado-institucion" tabindex="-1" role="dialog" aria-hidden="true" style="z-index: 9999 !important;">
    <div class="modal-dialog <!--- modal-sm --->">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar Institución</h4>
            </div>
            <div class="modal-body"></div>

            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" id="btn-estado-institucion"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>
