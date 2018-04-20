<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Revision
* Fecha:       22 de mayo de 2017
* Descripcion: Vista donde se puede revisar la informacion de todos los convenios
* Autor:       Jose Luis Granados Chavez
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8">
<link href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">

<cfinclude template="V_Revision_js.cfm">

<!--- INI VARIABLES AUXILIARES --->
<cfoutput>
    <input id="arbolStr" hidden value="#prc.jsonArbol#"/>
    <input id="tipoConv" hidden value="#prc.tipo#"/>    
</cfoutput>
<!--- FIN VARIABLES AUXILIARES --->  



<!--- INI IDBODY --->
<div id="idBody">
    <div id="shield" ></div>
    <a href="javascript:void(0)" id="dragbarY" ></a>
    <a href="javascript:void(0)" id="dragbarX" ></a>
    <!--- INI CONTENEDOR --->  
    <div id="container">
        <div id="menuOverlay" class="w3-overlay w3-transparent" style="cursor:pointer;z-index:4"></div>
        <!--- INI CONTENEDOR 1 ---> 
        <div id="iframecontainer1"  class="guiaSeccArbol">
            <div id="iframe1">         
                <div id="iframewrapper1">
                    <div id="iframeResult1" name="iframeResult1" >
                        <div class="mq-encabezado mq-wraper" >
                            <span id="mq-tit-f1">Convenios de <span id="tituloConvenios"></span></span>
                            <span id="mq-ico-f1" class="fa arrow"  onclick="toggleFrame1();"></span>
                       </div>
                       <div id="mq-cont-f1" class="mq-scroll-y" > 
                          <div id="divArbolConvenios" ></div>
                       </div>
                    </div>
                </div>
            </div>

            <!--- INI PANEL INFORMACION --->
            <div class="hide col-md-9" id="divPanelInfo">
                <div class="panel panel-convenio" id="PanelInfo">
                    <div class="panel-heading panelBotonera-encabezado">
                        <div class="panelBotonera-titulo">
                            <strong>Convenios/Firma autógrafa/Cecytes/Cecyt 12</strong>
                        </div>
                    </div> 
                    <div class="panelFondo" id="contenidoTablaRevision"></div>
                </div>
            </div>
            <!--- FIN PANEL LISTADO --->

        </div>
        <!--- FIN CONTENEDOR 1 --->

        <!--- INI CONTENEDOR 2 --->
        <div id="iframecontainer2"  class="guiaSeccArriba">
            <div id="iframe2">
                <div id="iframewrapper2">
                    <div id="iframeResult2" name="iframeResult2" >                   
                        <!--- INI PANEL DETALLE --->
                        <div class="mq-encabezado mq-wraper">
                           <span >Detalle del convenio</span>
                        </div>
                        <input type="hidden" id="hfPkConvenio" value="0">
                        <div class="hide mq-conv-f2" id="divPanelDetalle">
                            <!--- INI CONTENIDO DE LA INFORMACION DEL CONVENIO --->
                            <div>

                                <!--- INI PANEL CONSULTA CONVENIO --->
                                <div class="col-md-12 animated fadeInLeft" id="divPanelConsulta">
                                    <div class="panel panel-convenio" id="PanelConsulta">
                                        <div class="panel-body panelFondo pt10 pb10">
                                            <div id="rev_informacionConvenio"></div>
                                        </div>
                                    </div>
                                </div>
                                <!--- FIN PANEL CONSULTA CONVENIO --->
                                <!--- INI PANEL CONTROL ESTADOS --->
                                <div class="hide col-md-0 animated fadeInLeft" id="divPanelControlEstados">
                                    <div class="panel panel-convenio" id="PanelControlEstados">
                                        <div class="panel-body panelFondo pt10 pb10">
                                            <div id="divControlEstados"></div>
                                        </div>
                                    </div>
                                </div>
                                <!--- FIN PANEL CONTROL ESTADOS --->

                            </div>
                            <div class="mq-fondo col-md-12">
                                <div class="panel-body text-center">
                                    <cfif ArrayContains(Session.cbstorage.grant,'busqueda.validar')>
                                        <button type="button" class="btn btn-convenio btn-circle btn-lg mr10 guiaBtnConValidar hide" onclick="ValidarConvenio();" data-tooltip="tooltip" title="Validar convenio" id="botonValidado">
                                            <i class="fa fa-unlock-alt" aria-hidden="true"></i>
                                        </button>
                                    </cfif>
                                    <cfif ArrayContains(Session.cbstorage.grant,'busqueda.rechazar')>
                                        <button type="button" class="btn btn-convenio btn-circle btn-lg mr10 guiaBtnConRechazar hide" onclick="RechazarConvenio();" data-tooltip="tooltip" title="Rechazar convenio" id="botonRechazado">
                                            <i class="fa fa-share icon-flipped" aria-hidden="true"></i>
                                        </button>
                                    </cfif>
                                    <button type="button" class="hide btn btn-convenio btn-circle btn-lg mr10 guiaBtnEstados" onclick="ControlEstados();" data-toggle="tooltip" data-placement="top" data-original-title="Control de Estados" id="btn-controlEdos">
                                    <i class="fa fa fa-list-ol" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </div>
                            <!--- FIN CONTENIDO DE LA INFORMACION DEL CONVENIO --->
                        </div>
                        <!--- FIN PANEL DETALLE --->
                    </div>
                </div>
            </div>
        </div>
       <!--- FIN CONTENEDOR 2 --->

       <!--- INI CONTENEDOR 3 ---> 
        <div id="iframecontainer3" class="guiaSeccAbajo">
            <div id="iframe3">
                <div id="iframewrapper3">
                  
                    <div id="iframeResult3" name="iframeResult3">
                        <!--- INI PANEL ANEXO --->
                            <!--- <div id="panelEncabezado" class="mq-encabezado mq-panelBotonera">
                                
                                <button type="button" class="btn btn-convenio btn-circle close-link mq-botonera" id="cierraPanelAnexo" data-toggle="tooltip" data-placement="top" data-original-title="Cerrar">
                                    <i class="fa fa fa-times fa-lg" aria-hidden="true"></i>
                                </button>
                                <button type="button" class="btn btn-convenio btn-circle fullscreen-link mq-botonera" data-toggle="tooltip" data-placement="top" data-original-title="Expander PDF">
                                    <i class="fa fa-expand fa-lg" aria-hidden="true"></i>
                                </button>
                            </div> --->
                            <!--- <div id="mq-pdf-embed-responsive-4by3" class="embed-responsive embed-responsive-4by3" style="height:90%"> --->

                            <div class='mq-encabezado mq-wraper'>
                                <span>Archivo convenio</span>
                                <i class="fa fa-expand fa-fw fullscreen-link mq-botonera" aria-hidden="true" data-toggle="tooltip" data-placement="top" data-original-title="Expander PDF"></i>
                            </div>
                            <div class="embed-responsive" style="height:100%">
                                <div id="agregarDocto"></div>
                            </div>
                        <!--- FIN PANEL ANEXO --->    
                    </div>
                </div>
            </div>
        </div>
        <!--- FIN CONTENEDOR 3 --->

    </div>
    <!--- FIN CONTENEDOR --->
</div>
<!--- FIN IDBODY --->

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

<!--- Modal de comentario al validar --->
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
                <button type="button" class="btn btn-default ml5" onclick="cambiarEstado(0);">Omitir</button>
                <button type="button" class="btn btn-success pull-right ml5" onclick="cambiarEstado(1);">Guardar comentario</button>
            </div>
        </div>
    </div>
</div>
<!--- END Modal de comentario al validar --->

<ul id="tlyPageGuide" data-tourtitle="Listado de convenios">
    <li class="tlypageguide_top" data-tourtarget=".guiaSeccArbol">
        <div>
            Sección donde se muestra la cantidad de convenios existentes por clasificación y dependencia
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaSeccArriba">
        <div>
            Sección donde se muestra la información detallada del convenio, su responsable y sus archivos
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaSeccAbajo">
        <div>
            Sección donde se muestra la vista rápida de los documentos anexados dentro del convenio
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaBtnConValidar">
        <div>
            De clic aquí para realizar la validación del convenio
        </div>
    </li>
</ul>
