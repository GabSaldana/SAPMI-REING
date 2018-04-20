<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       22 de mayo de 2017
* Descripcion: Vista donde se puede consultar la informacion de todos los convenios y modificar cada uno de ellos
* Autor:       Jose Luis Granados Chavez
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">
<link href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">

<cfinclude template="V_Consulta_js.cfm">

<input type="hidden" id="hfPkConvenio"    value="0">
<input type="hidden" id="hfPkResponsable" value="0">

<div class="row noPadding">
    <!--- INI PANEL LISTADO --->
    <div class="col-md-12" id="divPanelListado">
        <div class="panel panel-convenio" id="PanelListado" style="margin-bottom: 63px;">
            <div class="panel-heading panelBotonera-encabezado">
                <div class="panelBotonera-titulo">
                    <strong>Listado de convenios</strong>
                </div>
            </div>
            <cfif (Session.cbstorage.usuario.ROL neq application.SIIIP_CTES.ROLES.ANALISTADEP and Session.cbstorage.usuario.ROL neq application.SIIIP_CTES.ROLES.RESPONSABLEDEP and Session.cbstorage.usuario.ROL neq application.SIIIP_CTES.ROLES.TITULARDEP)>
                <div class="col-md-2 pt10">
                     <select id="ddlTipo" name="ddlTipo" class="form-control guiaSelectTipo" onchange="getSelectEstados();">
                        <option value="0">Seleccione tipo...</option>
                        <option value="2">FIRMA AUTÓGRAFA</option>
                        <option value="1">FIRMA ELECTRÓNICA</option>
                        <option value="3">UC-MEXUS</option>
                    </select>
                </div>
                <div class="col-md-2 pt10">
                     <select id="ddlEstado" name="ddlEstado" class="form-control guiaSelectEstado" onchange="getTablaConvenios();" disabled>
                        <option value="0">Seleccione estado...</option>
                    </select>
                </div>
                <div class="col-md-3 pt10">
                     <select id="ddlURClasificacion" name="ddlURClasificacion" class="form-control guiaSelectClasificacion" onchange="selectURClasificacion();">
                        <option value="0">Seleccione clasificación...</option>
                        <cfset total_records = prc.URClasificacion.recordcount />
                        <cfloop index="x" from="1" to="#total_records#">
                            <cfoutput><option value="#prc.URClasificacion.PK[x]#">#prc.URClasificacion.NOMBRE[x]#</option></cfoutput>
                        </cfloop>
                    </select>
                </div>
                <div class="col-md-3 pt10">
                    <select id="ddlUR" name="ddlUR" class="form-control guiaSelectDependencias" disabled="true" onchange="getTablaConvenios();">
                        <option value="0">Seleccione dependencias...</option>
                    </select>
                </div>
            </cfif>
            <div id="contenidoTablaConvenios" style="padding: 0px 15px 15px 15px;"></div>
        </div>
    </div>
    <!--- FIN PANEL LISTADO --->
    <!--- INI PANEL CONSULTA CONVENIO --->
    <div class="hide col-md-12 animated fadeInLeft" id="divPanelConsulta" style="margin-bottom: 63px;">
        <div class="panel panel-convenio" id="PanelConsulta">
            <div class="panel-heading panelBotonera-encabezado">
                <div class="panelBotonera-titulo">
                    <strong><label id="lblTitConConvenio"></label></strong>
                </div>
            </div>
            <div class="panel-body panelFondo pt10 pb10">
                <div id="informacionConvenio"></div>
            </div>
        </div>
    </div>
    <!--- FIN PANEL CONSULTA CONVENIO --->
    <!--- INI PANEL CONTROL ESTADOS --->
    <div class="hide col-md-0 animated fadeInLeft" id="divPanelControlEstados" style="margin-bottom: 63px;">
        <div class="panel panel-convenio" id="PanelControlEstados">
            <div class="panel-heading panelBotonera-encabezado">
                <div class="panelBotonera-titulo">
                    <strong>Control de estados</strong>
                </div>
            </div>
            <div class="panel-body panelFondo pt10 pb10">
                <div id="divControlEstados"></div>
            </div>
        </div>
    </div>
    <!--- FIN PANEL CONTROL ESTADOS --->
    <div class="footer fixed text-center">
    <!--- INI BOTONERA CONSULTA --->
        <cfif Session.cbstorage.usuario.ROL eq application.SIIIP_CTES.ROLES.ANALISTADEP>
            <button type="button" class="btn btn-convenio btn-circle btn-lg mr10" onclick="MuestraAgregar();" data-toggle="tooltip" data-placement="top" data-original-title="Agregar nuevo convenio" id="btn-agregarConvenio">
                <i class="fa fa-plus" aria-hidden="true"></i>
            </button>
        </cfif>
        <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnConValidar" onclick="ValidarConvenio();" data-toggle="tooltip" data-placement="top" data-original-title="Validar convenio" id="btn-validarConvenio">
            <i class="fa fa-unlock-alt" aria-hidden="true"></i>
        </button>
        <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnConRechazar" onclick="RechazarConvenio();" data-toggle="tooltip" data-placement="top" data-original-title="Rechazar convenio" id="btn-rechazarConvenio">
            <i class="fa fa-share icon-flipped" aria-hidden="true"></i>
        </button>
        <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnConConsultar" onclick="MuestraListado();" data-toggle="tooltip" data-placement="top" data-original-title="Búsqueda convenios" id="btn-buscarConvenio">
            <i class="fa fa fa-search" aria-hidden="true"></i>
        </button>
        <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnComrntar" data-toggle="tooltip" data-placement="top" data-original-title="Comentar convenio" id="comentarCom">
            <i class="fa fa fa-comment-o" aria-hidden="true"></i>
        </button>
        <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnConsultar" data-toggle="tooltip" data-placement="top" data-original-title="Consultar comentarios" id="consultarCom">
            <i class="fa fa fa-comment" aria-hidden="true"></i>
        </button>
        <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnEstados" onclick="ControlEstados();" data-toggle="tooltip" data-placement="top" data-original-title="Control de Estados" id="btn-controlEdos">
            <i class="fa fa fa-list-ol" aria-hidden="true"></i>
        </button>
        <!--- FIN BOTONERA CONSULTA --->
    </div>
    
    <!--- INI PANEL ANEXO --->
    <div class="hide col-md-12" id="divPanelAnexo">
        <div class="panel panel-convenio panelFondo" id="PanelAnexo">
            <div class="panel-heading panelBotonera-encabezado">
                <div class="panelBotonera-titulo">
                    <strong>Convenio</strong>
                </div>
                <div class="panelBotonera">
                    <button type="button" class="btn btn-convenio btn-circle" data-toggle="modal" data-target="#divModalAnexo" data-toggle="tooltip" data-placement="top" data-original-title="Ver PDF del convenio">
                        <i class="fa fa-clone fa-lg" aria-hidden="true"></i>
                    </button>
                    <button type="button" class="btn btn-convenio btn-circle fullscreen-link" data-toggle="tooltip" data-placement="top" data-original-title="Expander PDF">
                        <i class="fa fa-expand fa-lg" aria-hidden="true"></i>
                    </button>
                    <button type="button" class="btn btn-convenio btn-circle close-link" id="cierraPanelAnexo" data-toggle="tooltip" data-placement="top" data-original-title="Cerrar">
                        <i class="fa fa fa-times fa-lg" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
            <div class="panel-body">
                <div class="embed-responsive embed-responsive-4by3">
                    <iframe id="frmAnexo" frameborder="0" class="embed-responsive-item" src="…"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!--- FIN PANEL ANEXO --->  
</div>

<!--- INI MODAL ARCHIVO ANEXO --->
<div id="divModalAnexo" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Acta de nacimiento</h4>
            </div>
            <div class="modal-body">
                <div class="embed-responsive embed-responsive-4by3">
                    <iframe src="" frameborder="0" class="embed-responsive-item"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<!--- FIN MODAL ARCHIVO ANEXO --->

<!--- INI MODAL AGREGA ARCHIVO --->
<div id="divModalAgregarArchivo" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Agrega archivo del convenio</h4>
            </div>
            <div class="modal-body">

                <!--- INI FORMULARIO ARCHIVOS --->
                <div class="form row">
                    <div class="form-group col-md-10 col-md-offset-1">
                        <label class="control-label">Descripción :</label></br>
                        <input type="text" class="form-control" id="txtDescripcion">
                    </div>
                    <div class="form-group col-md-4 col-md-offset-1">
                        <label class="control-label">Tipo :</label></br>
                        <label class="control-label">Convenio</label>
                    </div>
                    <div class="form-group col-md-5">
                        <label class="control-label">Archivo :</label></br>
                        <input type="file" class="form-control" name="fileupload" value="fileupload" id="fileupload">
                    </div>
                    <div class="form-group col-md-1 mt25">
                        <button type="button" class="btn btn-convenio btn-circle" data-toggle="tooltip" data-placement="top" data-original-title="Agregar archivo">
                            <i class="fa fa-plus fa-lg" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
                <!--- FIN FORMULARIO ARCHIVOS --->

            </div>
        </div>
    </div>
</div>
<!--- FIN MODAL AGREGA ARCHIVO --->

<div id="mdl-addComentarioCambioEstado" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 999999 !important;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 10px 30px 70px;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -20px;"><h1><strong>&times;</strong></h1></button>
                <h2 class="pull-left">¿Desea agregar un comentario?</h2>
            </div>
            <div class="modal-body">
                <input id="inRegistro" type="hidden" value="">
                <input id="inAccion"   type="hidden" value="">

                <input type="hidden" id="comentDoc">
                <input type="hidden" id="comentEdo">

                <div class="panel-group hide" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" class="collapsed" style="color: #333;">
                                <h5 class="panel-title">Destinatarios<i class="fa fa-chevron-down pull-right"></i></h5>
                            </a>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                            <div class="panel-body destinatarios"></div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label pull-left"><h4>Asunto:</h4></label>
                    <div class="col-sm-11"><input id="inAsunto" type="text" class="form-control" value=""></div>
                </div>
                <br><br>
                <div class="checkbox checkbox-danger">&nbsp;&nbsp;&nbsp;
                    <input id="inPrior" class="styled" type="checkbox">
                    <label for="inPrior">
                        <i class='fa fa-exclamation'></i> Prioritario
                    </label>
                </div>
                <textarea id="inComent" name="inComent"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default ml5 cambiosEdo" onclick="cambiarEstado(0);">Omitir</button>
                <button type="button" class="btn btn-success pull-right ml5 cambiosEdo" onclick="cambiarEstado(1);">Guardar comentario</button>
                <button type="button" id="funcionComentGral" class="hide btn btn-success pull-right ml5">Comentar convenio</button>
                <button type="button" id="cerrarComent" class="hide btn btn-success pull-right ml5" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<style type="text/css">
    .mce-tooltip{
        z-index: 9999999 !important;
    }
    .mce-floatpanel{
        z-index: 9999999 !important;
    }
</style>


<input type="hidden" id="pkRegistroComentario">
<input type="hidden" id="pkTipoComentario">

<div class="modal inmodal fade modaltext" id="mdl-comentariosConvenio" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg contnido"> </div>
</div>



<ul id="tlyPageGuide" data-tourtitle="Listado de convenios">
    <li class="tlypageguide_top" data-tourtarget=".guiaSelectEstado">
        <div>
            Filtro de selección para mostrar en el listado por el estado del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaSelectClasificacion">
        <div>
            Filtro de selección para mostrar en el listado por la clasificación de dependencias del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaSelectDependencias">
        <div>
            Filtro de selección para mostrar en el listado por la dependencia del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div>
            Filtro de búsqueda rápida para mostrar en el listado por cualquier información del convenio 
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaEstado">
        <div>
            Estado actual del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnPDF">
        <div>
            De clic aquí para mostrar el documento PDF del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnValidar">
        <div>
            De clic aquí para realizar la validación del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnEditar">
        <div>
            De clic aquí para realizar la edición de la información del convenio, así como del representante y sus archivos anexos
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnBorrar">
        <div>
            De clic aquí para realizar el borrado del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnConsultar">
        <div>
            De clic aquí para ver de forma detallada la información del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnEstados">
        <div>
            De clic aquí para ver los estados de avance del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaInfoGral">
        <div>
            En esta pestaña se muestra de forma detallada la información general del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaInfoResponsable">
        <div>
            En esta pestaña se muestra de forma detallada la información general del responsable del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaInfoArchivos">
        <div>
            En esta pestaña se muestra de forma detallada la información general de los archivos contenidos en el convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnConValidar">
        <div>
            De clic aquí para realizar la validación del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnConRechazar">
        <div>
            De clic aquí para realizar el rechazo del convenio
        </div>
    </li>
     <li class="tlypageguide_top" data-tourtarget=".guiaBtnConConsultar">
        <div>
            De clic aquí para ver el listado de convenios
        </div>
    </li>
</ul>



