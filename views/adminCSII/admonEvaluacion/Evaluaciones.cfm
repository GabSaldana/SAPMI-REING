<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="evaluaciones_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administracion de Evaluaciones</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li class="active">
                    <strong>Administracion de Evaluaciones</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5 class="selecciona-evaluacion"> Evaluaciones</h5>
        </div>
        <div class="ibox-content">
            <button  style="background-color: #cdcbcb" type="button" class="btn btn-default btn-outline dim btn-crear" data-toggle="modal" onclick="modalAgregarEvaluacion();"><span class="glyphicon glyphicon-plus"></span> AGREGAR EVALUACION </button><br><br>
            <form role="form" id="form-evaluacion" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2" for="">Nombre de la Evaluacion:</label>
                    <div class="col-sm-10">
                        <select class="form-control m-b" id="inEvaluacion" name="inEvaluacion"> 
                            <option value="" selected="selected">Seleccionar Evaluacion</option>
                            <cfoutput query="prc.eval">
                                    <option value="#PKEVAL#">#EVALUACION#</option>
                            </cfoutput>        
                        </select>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5 class="seccion">Secciones de la Evaluacion</h5>
        </div>
        <div class="ibox-content">
            <div id="tabla-seccionEval"></div>
        </div>
    </div>
</div>

<!-- MODAL PARA AGREGAR UNA EVALUACION -->
<div id="mdl-admon-evaluacion" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Agregar una Evaluacion</h4>
            </div>
            
            <div class="modal-body">
                <form id="valida-agrega-evaluacion" class="form-horizontal" role="form" onsubmit="return false;">
                    <div class="form-group nombre">                    
                        <label class="control-label col-sm-2">Nombre:</label>
                        <div class="col-sm-10">                                                
                            <input id="nombre" name="nombre" type="text" class="form-control" maxlength="100"/>
                        </div>                    
                    </div>

                    <div class="form-group" id="data_1">
                        <label class="control-label col-sm-2" >Fecha Inicial: </label>
                        <div class="col-sm-4">
                            <div class="input-group dateini">
                                <input type="text" class="form-control date" readonly="readonly" id="fchIni" name="fchIni"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" id="data_2">
                        <label class="control-label col-sm-2" >Fecha Final: </label>
                        <div class="col-sm-4">
                            <div class="input-group datefin">
                                <input type="text" class="form-control date" readonly="readonly" id="fchFin" name="fchFin"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div class="form-group">
                    <button type="button" class="btn btn-primary btn-lg cancelar" data-dismiss="modal" onclick="limpiarCamposAgregarEval();"><span class="fa fa-times"></span> Cancelar</button>
                    <button type="button" class="btn btn-default btn-lg pull-right" id="guardar" onclick="guardarEvaluacion()"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<style type="text/css">
    .date{
        z-index: 100000 !important;
    }
</style>
<!-- FIN DEL MODAL PARA AGREGAR UNA EVALUACION -->


<!-- MODAL PARA AGREGAR ASPECTOS DE UNA SECCION A LA ENCUESTA -->
<div id="mdl-agregar-campos" class="modal fade" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Agregar Aspectos</h4>
            </div>
            
            <input type="hidden" id="campoPkSeccion" value="">
            <div class="modal-body">
                
                    <fieldset class="form-horizontal">
                        <h2>Agregar un Aspecto a la seccion</h2>
                        <form id="valida-agrega-aspectos" class="form-horizontal" role="form" onsubmit="return false;">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="">Nombre: </label>
                                <div class="col-sm-10">
                                    <input id="nomAspec" name="nomAspec" type="text" class="form-control" maxlength="100"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" >Escala: </label>
                                <div class="col-sm-8">
                                    <select class="form-control a" id="escalaAspec" name="escalaAspec"> 
                                        <option value="" selected="selected">Seleccionar Escala</option>
                                        <cfoutput query="prc.esca">
                                            <option value="#PKESC#">#NOMESC#</option>
                                        </cfoutput>
                                    </select>
                                </div>
                                <div class="col-sm-2">
                                    <div class="input-group">
                                        <a class="btn btn-primary glyphicon glyphicon-plus" id="btn-agregar-aspecto" data-tooltip="tooltip" title="Agregar"></a>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <h2>Listado de los aspectos de la seccion</h2>
                        <table data-toggle="table" id="tabla-agregar-aspectos" class="table table-striped table-responsive" data-pagination="true" data-page-size="5" data-unique-id="num">
                            <thead>
                                <tr>
                                    <th data-field="num">#</th>
                                    <th class="text-center" data-field="nombre" data-sortable="true">Nombre</th>
                                    <th class="text-center" data-field="escala" data-sortable="true">Escala</th>
                                    <th class="text-center" data-field="keyEscala" data-sortable="true">PrimaryKeyEscala</th>
                                    <th class="text-center" data-field="pk" data-sortable="true">pk</th>
                                    <th class="text-center" data-field="orden" data-sortable="true">Orden</th>
                                    <th class="text-center" data-field="accion" data-formatter="setAccion" data-events="actionEvents">Eliminar</th>
                                </tr>
                            </thead>
                        </table><br>
                        <button type="button" class="btn btn-default btn-lg" onclick="modalCambiarOrden();"><span class="glyphicon glyphicon-refresh"></span> Cambiar Orden de los Aspectos</button>
                    </fieldset>
            </div>

            <div class="modal-footer">
                <div class="form-group">
                    <button type="button" class="btn btn-primary btn-lg cancelar" data-dismiss="modal" onclick="limpiarCamposEditarAspectos();"><span class="fa fa-times"></span> Cancelar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- FIN DEL MODAL PARA AGREGAR ASPECTOS DE UNA SECCION A LA ENCUESTA -->


<!-- MODAL PARA AGREGAR SECCIONES A LA ENCUESTA -->
<div id="modal-Agregar-Seccion" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog">

    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Agregar Seccion</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <label class="control-label col-sm-2" for="">Nombre: </label>
            <div class="col-sm-10">
                <input id="nomSecc" type="text" class="form-control" maxlength="150"/>
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-lg cancelar" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
        <button type="button" class="btn btn-default btn-lg pull-right" id="guardar" onclick="guardarSeccion();"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
      </div>
    </div>

  </div>
</div>
<!-- FIN DEL MODAL PARA AGREGAR SECCIONES A LA ENCUESTA -->


<!-- MODAL PARA AGREGAR SECCIONES A LA ENCUESTA -->
<div id="modal-CambiarOrden" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog">

    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title"><h4>
      </div>
      <div class="modal-body">
        <ol id="ordenarElementos">
        </ol>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-lg cancelar" data-dismiss="modal" onclick="modalOpacidadAspectos();"><span class="fa fa-times"></span> Cancelar</button>
        <button type="button" class="btn btn-default btn-lg pull-right" id="btnBGuardarOrdenElmentos"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
      </div>
    </div>

  </div>
</div>
<!-- FIN DEL MODAL PARA AGREGAR SECCIONES A LA ENCUESTA -->


<!-- MODAL PARA CONFIRMAR ELIMINACION Y AGREGAR ACCIONES Y ASPECTOS -->
<div id="modal-cambiarEstado" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body"></div>
            <input id="estadoModal" type="hidden" value="">
            <input id="pkModal" type="hidden" value="">
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-primary btn-eliminar" onclick="cambiarEstado();">Sí</button>
            </div>
        </div>
    </div>
</div>
<!-- FIN DEL MODAL PARA CONFIRMAR ELIMINACION Y AGREGAR ACCIONES Y ASPECTOS -->