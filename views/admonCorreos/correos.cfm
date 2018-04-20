<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="correos_js.cfm">

<script>
    tinymce.init({
        selector: '.mytextarea',
        language: 'es_MX',
        height: 400,
        resize: false,
        plugins: 'textcolor textpattern table hr charmap preview',
        toolbar: 'undo redo | fontselect | fontsizeselect | bold italic | forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',
    }); 
</script>

<style type="text/css">
    .slick-prev:before,
    .slick-next:before {
        color: black;
    }
</style>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de usuarios</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Administración de correos</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div id="cajaCorreos" class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-title listaUsuarios">
            <h5>CORREOS REGISTRADOS</h5>
            <div class="ibox-tools"></div>
        </div>
        <div class="ibox-content">
            <div id="correos"></div>
        </div>
    </div>
</div>

<div class="panel panel-primary" id="panel-historial" style="display: none;">
    <div class="panel-heading">
        <b>Historial de Correos</b>
        <span class="btn btn-primary btn-xs pull-right" onclick="verCajaCorreos();" data-toggle="tooltip" title="Cerrar Historial">
            <i class="fa fa-times"></i>
        </span>
    </div>
    <div class="panel-body" style="position: relative;">
        <div class="col-md-12">
            <div class="col-sm-9">
                <div class="col-sm-5">
                    <div class="form-group date guiaHistorialInicio">
                        <label class="font-normal"> Despu&#233;s de:</label>
                        <div class="input-group">
                            <input id="fechaInicio" name="fechaInicio" type="text" value="" class="form-control buscador" disabled>
                            <span class="input-group-addon" data-toggle="tooltip" data-placement="top" title="" data-original-title="Seleccionar Fecha de Inicio">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-5">
                    <div class="form-group date guiaHistorialFin">
                        <label class="font-normal"> Antes de:</label>
                        <div class="input-group">
                            <input id="fechaFin" name="fechaFin" type="text" value="" class="form-control buscador" disabled>
                            <span class="input-group-addon" data-toggle="tooltip" data-placement="top" title="" data-original-title="Seleccionar Fecha de Fin">
                                <span class="fa fa-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div id="historialCorreos"></div>
        </div>
    </div>
</div>

<div class="row" id="pnl-ncorreo" style="display:none">
    <div class="col-md-12" style="margin-top:15px">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <button type="button" class="close" onclick="limpiaPanelCorreo();" aria-hidden="true">×</button>
                <h4 class="modal-title">Agregar correo</h4>
            </div>
            <div class="panel-body">
                <form id="nuevoCorreo" class="form-horizontal" role="form" onsubmit="return false;">
                    <input id="inPkCorreoNuevo" type="hidden" value="0">
                    <div>
                        <label class="control-label">Nombre</label>
                        <div class="input-group">   
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-pencil"></span>
                            </span>
                            <input type="text" id="inCorreo" name="inCorreo" class="form-control" placeholder="Ingresar nombre" />
                        </div>
                        <label class="control-label">Descripción</label>
                        <div class="input-group">   
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-menu-hamburger"></span>
                            </span>
                            <input type="text" id="inCorreoDesc" name="inCorreoDesc" class="form-control" placeholder="Ingresar descripción" />
                        </div>
                    </div>
                </form>
                <br>
                <label class="control-label">Cabecera</label>
                <section id="carruselHeader" class="carrusel slider" style="margin-right:20px; margin-left:20px;"></section>
                <table style="width:100%">
                    <tr>
                        <label style="width:75%" class="control-label">Contenido</label>
                        <input id="inPkBody" type="hidden" value="0">
                        <label style="width:25%" class="control-label">Etiquetas</label>
                    </tr>
                </table>
                <table style="width:100%">
                    <tr>
                        <th rowspan="2" style="width:75%"><input id="inContentCorreo" type="textarea" class="mytextarea" id="textCorreo" value=""></th>
                        <td style="width:10px"></td>
                        <td style="vertical-align:top;">
                            <label class="control-label">Nueva etiqueta</label>
                            <form id="nuevaEtiqueta" class="form-horizontal" role="form" onsubmit="return false;">
                                <input type="text" id="inEtiContenido" name="inEtiContenido" class="form-control" placeholder="Etiqueta" disabled="true"/>
                            </form>
                            <br>
                            <button id="botonAgregarEti" type="button" class="btn btn-default btn-sm" onclick="agregarEtiqueta();" disabled="true">Añadir Etiqueta</button>
                            <br><br>
                            <div id="info" class="alert alert-info">
                                <strong>Información!:</strong> Antes de poder agregar una etiqueta, es necesario guardar el correo.
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:10px"></td>
                        <td>
                            <label class="control-label">Etiquetas disponbles</label>
                            <ul id="listaEtiquetas" class="list-group">
                               <li class="list-group-item">Correo sin etiquetas</li>
                            </ul>
                        </td>
                    </tr>
                </table>
                <br>
                <label class="control-label">Pie de pagina</label>
                <div>
                    <section id="carruselFooter" class="carrusel slider" style="margin-right:20px; margin-left:20px;"></section>
                </div> 
            </div>
            <div class="panel-footer">
                <button type="button" class="btn btn-default btn-lg" onclick="limpiaPanelCorreo();"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" onclick="agregarCorreo();">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div id="mdl-plantillas" class="modal inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" onclick="limpiarVistaPre();" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <br>
                <button type="button" class="btn btn-success btn-lg btn-block" data-toggle="modal" data-target="#mdl-crear">Crear nuevo</button>
                <br><br>
                <div id="plantillas"></div>
                <br><br>
                <div class="panel panel-default">
                    <div class="panel-heading" id="encabezadoVista">Vista previa</div>
                    <div class="panel-body" id="plantillaVistaPre"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="limpiarVistaPre();"><span class="fa fa-times"></span> Cancelar</button>
            </div>
        </div>
    </div>
</div>

<div id="mdl-crear" class="modal inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" >
    <div class="modal-dialog modal-lg" style="width:75%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" onclick="limpiaModalPlant();" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <input id="tipoPlantilla" type="hidden" value="0">
                <input id="inPkPlant" type="hidden" value="0">
                <form id="nuevaPlant" class="form-horizontal" role="form" onsubmit="return false;">
                    <div>
                        <label class="control-label">Nombre</label>
                        <div class="input-group">   
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-pencil"></span>
                            </span>
                            <input type="text" id="inPlantilla" name="inPlantilla" class="form-control" placeholder="Ingresar nombre" />
                        </div>
                        <label class="control-label">Descripción</label>
                        <div class="input-group">   
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-menu-hamburger"></span>
                            </span>
                            <input type="text" id="inPlantillaDesc" name="inPlantillaDesc" class="form-control" placeholder="Ingresar descripción" />
                        </div>
                        <label class="control-label">Contenido</label>
                        <div class="input-group" style="width:100%">   
                            <input id="inContentPlant" type="textarea" class="mytextarea" id="textPlant" value="">
                        </div>
                    </div>
                </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="limpiaModalPlant();"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" onclick="agregarPlant();">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div id="mdl-confirma" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="limpiaOpacidadModal();">×</button>
                <h4 class="modal-title">Eliminar plantilla</h4>
            </div>
            <input id="inPkPlantConf" type="hidden" value="">
            <input id="tipoPlantillaConf" type="hidden" value="">
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" onclick="limpiaOpacidadModal();"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" onclick="cambiarEstadoPlant();"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>

<div id="mdl-confirmaEliminar" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar correo</h4>
            </div>
            <input id="inPkCorreo" type="hidden" value="0">
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" data-dismiss="modal" onclick="cambiarEstadoCorreo();"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>

<div id="mdl-vistacorreo" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Vista previa</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-default">
                    <div class="panel-heading">Vista previa</div>
                    <div id="vista" class="panel-body"></div>
                </div>
            </div>
        </div>
    </div>
</div>
