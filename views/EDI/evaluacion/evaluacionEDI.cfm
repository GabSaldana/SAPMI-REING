<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<cfinclude template="evaluacionEDI_js.cfm">
<style>
  .btn-circle.btn-lg{
    padding: 0px !important;
  }  
  .jstree li > a > .jstree-icon {  display:none !important; }
  .jstree {overflow-x: auto;}
</style>


<cfoutput>
    <input type="hidden" id="pkPersona"    value="#prc.pkPersona#">
    <input type="hidden" id="pkVertiente"  value="#prc.pkVertiente#">
    <input type="hidden" id="pkUsuario"    value="#prc.pkUsuario#">
		<input type="hidden" id="pkMovimiento" value="#prc.pkMovimiento#">
		<input type="hidden" id="clasifSeleccionada" value="#prc.clasifSel#">
		<input type="hidden" id="subClasifSeleccionada" value="#prc.subClasifSel#">

    <input type="hidden" id="falgTabResumenSolicitudes" value="0">
    <input type="hidden" id="falgTabActivAlternas"      value="0">
</cfoutput>
<div class="ibox float-e-margins divevaluacionInvr">	

  <div class="ibox-title">
		<h5><div id="nombreInvestigador"></div></h5>
		<div class="ibox-tools">			
			<a class="close-link" onclick="cancelarTinyMCE();">
        <i class="fa fa-times fa-2x" id="cerrarEvaluacion"></i>
      </a>
		</div>
	</div>
  <div class="ibox-content">
    <div class="tabs-container">
      <ul class="nav nav-tabs">
        <li class=""><a data-toggle="tab" href="#tab-1" aria-expanded="true">Datos del investigador</a></li>
        <li class="active"><a data-toggle="tab" href="#tab-2" aria-expanded="false">Evaluación EDI</a></li>
        <li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">Trabajo Evaluado</a></li>
        <li class=""><a data-toggle="tab" href="#tab-4" aria-expanded="false">Solicitudes al Comité Académico</a></li>
        <li class=""><a data-toggle="tab" href="#tab-5" aria-expanded="false">Documentos de ayuda</a></li>
      </ul>
      <div class="tab-content">
        <div id="tab-1" class="tab-pane">
          
            <div class="panel-body">
              <cfoutput>    
                <div class="row">
                  <div class="col-sm-5">
                    <label class="control-label">Nombre:</label>
                    <p id="inNombreInvestigador" class="form-control" disabled>#prc.datosInvestigador.NOMBRE# #prc.datosInvestigador.APPAT# #prc.datosInvestigador.APMAT#</p>
                  </div>
                  <div class="col-sm-3">
                    <label class="control-label">Nivel SNI:</label>
                    <div class="input-group">
                      <p id="inNIvelSNI" class="form-control" disabled>#prc.datosInvestigadorNivel.NIVEL#</p>
                      <span class="input-group-btn">
                        <button class="btn btn-success ml5 btn-verDoctoNivelSNI" data-tooltip="tooltip" title="Documento Nivel SNI" id_nivel="#prc.datosInvestigadorNivel.PKSNI#" id="verDoctoNivelSNI">
                            <i class="fa fa-file"></i>
                        </button> 
                      </span>
                    </div>
                  </div>
                  <div class="col-sm-3">
                    <label class="control-label">Nivel EDI:</label>
                    <p id="inNivelActual" class="form-control" disabled>#prc.datosInvestigadorNivel.EDI#</p>
                  </div>
                </div>
                
                <div class="row">

                  <div class="col-sm-4">
                    <label class="control-label">Red de Investigadores o de Expertos:</label>
                    <div class="input-group">
                      <p id="inNIvelSNI" class="form-control" disabled style="overflow: auto;">#prc.datosInvestigadorRed.REDLISTA#</p>
                      <span class="input-group-btn">
                        <button class="btn btn-success ml5 btn-verDoctoRedes" data-tooltip="tooltip" title="Documento movimiento" id_persona="#prc.datosInvestigador.FK_PERSONA#">
                            <i class="fa fa-file"></i>
                        </button> 
                      </span>
                    </div>
                  </div>
                  <div class="col-sm-4">
                    <label class="control-label">Estatus del Investigador:</label>
                    <p id="inEstatusInvestigador" class="form-control" disabled>#prc.datosInvestigador.ESTADOPERSONA#</p>
                  </div>
                  <div class="col-sm-4">
                    <label class="control-label">Solicitud:</label>
                    <p id="inEstatusInvestigador" class="form-control" disabled>#prc.datosInvestigador.MOVIMIENTO#</p>
                  </div>
                </div>
              </cfoutput>              

              <br>
              <div class="row"><h4><center>PLAZAS</center></h4></div>
              <div id="contenidoTablaPlazas"></div>

              <br>
              <div class="row"><h4><center>FORMACIÓN ACADÉMICA</center></h4></div>
              <div id="contenidoTablaFormacionAcademicaConsulta"></div>

              <br>
              <div class="row"><h4><center>PROYECTOS DE INVESTIGACIÓN</center></h4></div>
              <div id="contenidoTablaProyectos"></div>
            </div>
          
        </div>
        <div id="tab-2" class="tab-pane active">
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-3">
                <div class="ibox float-e-margins">
                  <h3>Productos:</h3>
                  <div id="jstree">
                    <ul>
                      <cfoutput>            
                        <cfloop collection="#prc.productos#" item="x">
                          <cfif arrayLen(prc.productos[x])>
                            <li data-toggle="tooltip" data-clasif="#prc.productos[x][1]["CLASIFICACION"]#" title="#prc.productos[x][1]["CLASIFICACION_ROMANO"]# - #prc.productos[x][1]["RUTAPRODUCTOSARRAY"][1]#" class="verClasif">
                              <span class="fa fa-lg fa-folder"></span> #prc.productos[x][1]["CLASIFICACION_ROMANO"]# - #prc.productos[x][1]["RUTAPRODUCTOSARRAY"][1]#
                              <ul>
                              <cfloop array="#prc.productos[x]#" index="producto">
                                <li data-clasif="#producto.CLASIFICACION#" data-subclasif="#producto.SUBCLASIFICACION#" pkProducto="#producto.PKPRODUCTO#" pkPadre="#producto.PKPADRE#" data-toggle="tooltip" title="#producto.CLASIFICACION_ROMANO#.#producto.SUBCLASIFICACION_ROMANO#" class="verProducto">
                                  <span class="fa fa-lg fa-folder"></span>
                                  #producto.CLASIFICACION_ROMANO#.#producto.SUBCLASIFICACION_ROMANO# - #arrayToList(arraySlice(producto.RUTAPRODUCTOSARRAY,2)," / ")#
                                </li>                                    
                              </cfloop>
                              </ul>
                            </li>
                          </cfif>
                        </cfloop>
                    </cfoutput>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-lg-9 info" id="divSelectProductos"></div>
            </div>
            <div class="row">
              <div class="col-md-9 col-md-offset-3">
                <br>                
                <div id="contenidoTablaEscolaridad"></div>
              </div>
            </div>
          </div>
          <div class="footer-botones footer fixed text-center accionesEvaluacion" id="footerAcciones">
            <button class="btn btn-lg btn-circle btn-success fa fa-address-card" data-toggle="tooltip" title="Resumen de la Evaluacion" onclick="mostrarResumenEvaluacion();"></button>
            <button class="btn btn-lg btn-circle btn-primary validaEvaluacion2 fa fa-save" data-toggle="tooltip" title="Guardar puntajes"></button>
            <button class="btn btn-lg btn-circle btn-success btn-observacion fa fa-eye" data-toggle="tooltip" title="Observaciones" onclick="getObservaciones(); $('#mdl-registroObservaciones').modal('show');"></button>
          </div>
        </div>
        <div id="tab-3" class="tab-pane">
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-4">
                <div class="ibox float-e-margins">
                  <h3>Productos:</h3>
                  <div id="jstree2">
                    <ul>
                      <cfoutput>            
                        <cfloop collection="#prc.productosEval#" item="x">
                          <cfif arrayLen(prc.productosEval[x])>
                            <li data-toggle="tooltip" data-clasif="#prc.productosEval[x][1]["CLASIFICACION"]#" title="#prc.productosEval[x][1]["CLASIFICACION_ROMANO"]# - #prc.productosEval[x][1]["RUTAPRODUCTOSARRAY"][1]#" class="verClasifEval">
                              <span class="fa fa-lg fa-folder"></span> #prc.productosEval[x][1]["CLASIFICACION_ROMANO"]# - #prc.productosEval[x][1]["RUTAPRODUCTOSARRAY"][1]#
                              <ul>
                              <cfloop array="#prc.productosEval[x]#" index="producto">
                                <li data-clasif="#producto.CLASIFICACION#" data-subclasif="#producto.SUBCLASIFICACION#" pkProducto="#producto.PKPRODUCTO#" pkPadre="#producto.PKPADRE#" data-toggle="tooltip" title="#producto.CLASIFICACION_ROMANO#.#producto.SUBCLASIFICACION_ROMANO#" class="verProductoEval">
                                  <span class="fa fa-lg fa-folder"></span>
                                  #producto.CLASIFICACION_ROMANO#.#producto.SUBCLASIFICACION_ROMANO# - #arrayToList(arraySlice(producto.RUTAPRODUCTOSARRAY,2)," / ")#
                                </li>                                    
                              </cfloop>
                              </ul>
                            </li>
                          </cfif>
                        </cfloop>                        
                    </cfoutput>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-lg-8 info" id="divSelectEvalProductos"></div>
			  	
            </div>
          </div>
        </div>
  
        <div id="tab-4" class="tab-pane">
          <div class="panel-body">
            <div class="col-md-12">
              <div id="divSolicitudComite"></div>
              <br>
              <div id="divSolicitudResidencia"></div>
            </div>
          </div>
        </div>
  
        <div id="tab-5" class="tab-pane">
          <div class="panel-body">
            <div class="row">
              <div class="col-md-12">
                <div class="alert alert-warning text-uppercase text-center"><b>“Esta información es exclusiva para su uso en las evaluaciones de expedientes EDI, no se permite su copia ni reproducción para otros fines.”</b></div>            
                  <div class="table-responsive">
                    <table class="table table-striped table-hover">
                      <tbody>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><label class="text-info" onclick="mostrarDoc('/includes/docAyudaSIIIP/REGLAMENTO_EDI_2013.pdf');">Acuerdo por el que se expide el Reglamento del Programa de Estímulos al Desempeño de los Investigadores 2013.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><label class="text-info" onclick="mostrarDoc('/includes/docAyudaSIIIP/REGLAMENTO_2004.pdf');">Acuerdo por el que se modifica el Reglamento del Programa de Estímulos al Desempeño de los Investigadores 2004.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><label class="text-info" onclick="mostrarDoc('/includes/docAyudaSIIIP/CALENDARIO_PNPC_2017.pdf');">Calendario PNPC.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><label class="text-info" onclick="mostrarDoc('/includes/docAyudaSIIIP/CREDITOS_IPN.pdf');">Oficio de formato para dar créditos IPN.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><label class="text-info" onclick="mostrarDoc('/includes/docAyudaSIIIP/DISTINCIONES_Y_PREMIOS_2017.pdf');">Catálogo de distinciones y premios.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/ANIO_DE_GRACIA.xlsx" download="ANIO_DE_GRACIA.xlsx"><label class="text-info">Listado de investigadores con año de gracia.</label></a></td>
                        </tr>
                        <!--- <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/REVISTAS-2013.xlsx" download="REVISTAS-2013.xlsx"><label class="text-info">Índice de Revistas del IPN 2013.</label></a></td>
                        </tr> --->
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/REVISTAS-2014.xlsx" download="REVISTAS-2014.xlsx"><label class="text-info">Índice de Revistas del IPN 2014.</label></a></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/REVISTAS-2015.xlsx" download="REVISTAS-2015.xlsx"><label class="text-info">Índice de Revistas del IPN 2015.</label></a></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                           <td><a href="/includes/docAyudaSIIIP/REVISTAS-2016.xlsx" download="REVISTAS-2016.xlsx"><label class="text-info">Índice de Revistas del IPN 2016.</label></a></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/REVISTAS-2017.xlsx" download="REVISTAS-2017.xlsx"><label class="text-info">Índice de Revistas del IPN 2017.</label></a></td>
                        </tr>
                        <!--- <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/SNI_vigentes_2017.xlsx" download="SNI_vigentes_2017.xlsx"><label class="text-info">Listado de SNI vigentes de 2017.</label></a></td>
                        </tr> --->
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/SNI_VIGENTES_2018.xls" download="SNI_VIGENTES_2018.xls"><label class="text-info">Listado de SNI vigentes de 2018.</label></a></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td onclick="mostrarDoc('/includes/docAyudaSIIIP/REVISTAS_dudosas.pdf');"><label class="text-info">Información de revistas de dudosa calidad.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><label class="text-info" onclick="mostrarDoc('/includes/docAyudaSIIIP/guia_rapida2018.pdf');">Guia rápida para la comisiones evaluadoras del programa de Estímulos al Desempeño de los Investigadores (EDI) 2018 - 2020.</label></td>
                        </tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td onclick="mostrarDoc('/includes/docAyudaSIIIP/GuiaCA.pdf');"><label class="text-info">Presentación para evaluación del Comité Académico Auxiliar 2018-2020.</label></td>
                        </tr>
                        <tr>
                        <tr>
                          <td class="contact-type"><i class="fa fa-cicle"></i></td>
                          <td><a href="/includes/docAyudaSIIIP/PROPUESTA_DE_PUNTAJE_2017.xlsx" download="PROPUESTA_DE_PUNTAJE_2017.xlsx"><label class="text-info">Propuesta de puntaje del rubro II.3 Derechos de Autor.</label></a></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</div>
</div>
<div class=" col-lg-8 pull-right" id="boxesContraparte" style="display:none; width:100%; margin: auto;">
	<div class="panel panel-primary" style="margin:0px -15px 85px -15px;">
        <div class="panel-heading"> Edición del producto seleccionado
        	<span class="btn btn-primary btn-xs pull-right guiaCierraEdit" data-toggle="tooltip" title="cerrar" onclick="cierraPanelCelda();">
				<i class="fa fa-times"></i>
			</span>
        </div>
        <div class="panel-body">
        	<div id="formularioLlenado"></div>
		</div>
    </div>
</div>



<div class="modal fade" id="mdlDocsAyuda">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><i class="fa fa-times fa-lg"></i></button>
                <h4 class="modal-title">Documentos de ayuda</h4>
            </div>
            <div class="modal-body">
                <object id="objetoPfd" type="application/pdf" width="100%" height="600">Documento</object>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mdlResumenEvaluacion">
  <div class="modal-dialog modal-lg" style="width: 90%;">
      <div class="modal-content">
          <input type="hidden" id="accionValSol"           value="">
          <input type="hidden" id="pkAspProcValSol"        value="">
          <input type="hidden" id="pkTipoEvaluacionValSol" value="">

          <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" onclick="cancelarTinyMCE();"><i class="fa fa-times fa-lg"></i></button>
              <h4 class="modal-title">Resumen de la Evaluación</h4>
          </div>
          <div class="modal-body">   

            <div class="row">
              <div id="divFormulario">

                <button type="button" class="btn btn-success btn-lg btnValEval" style="width: 100%;" onclick="cambiaEdoAspProc();">Validar evaluación</button>
          
                <p><br><strong>Nivel SNI:</strong></p>
                <div class="input-group">
                  <p id="inNivelSNIObs" class="form-control" disabled></p>
                  <span class="input-group-btn">
                    <button class="btn btn-success ml5 btn-verDoctoNivelSNIObs" data-tooltip="tooltip" title="Documento Nivel SNI" id="verDoctoNivelSNIObs">
                        <i class="fa fa-file"></i>
                    </button> 
                  </span>
                </div>

                <div id="nivelesAsignacion"></div>

                <form id="formObservacionesNivel" role="form" onsubmit="return false;">
                  
                  <div id="elemAsignacion"></div>

                  <p><br><strong>Nivel EDI:</strong></p>
                  <select id="ddlNivelEDI" name="ddlNivelEDI" class="form-control">
                      <option value="">Seleccione nivel...</option>
                      <cfoutput query="prc.nivelEDI">
                          <option value="#PK#">#NOMBRE#</option>
                      </cfoutput>
                  </select>
                  <br>

                  <cfif isQuery(prc.ultimoGradoEstudios) AND prc.ultimoGradoEstudios.recordcount GT 0>
                    <p><br><strong>Último Grado de Estudios:</strong></p>
                    <cfoutput>
                      <div class="alert alert-info">
                        <span class="btn btn-success pull-right" title="Copia del Diploma" onclick="descargaComprobanteConsulta(#Session.cbstorage.usuario.VERTIENTE#,377,#prc.ultimoGradoEstudios.PK_ESCOLARIDAD[1]#);"><i class="fa fa-file"></i></span>
                        <p>Grado Obtenido<br><b>#prc.ultimoGradoEstudios.GRADO[1]#</b></p>
                        <p>Fecha de Obtención<br><b>#lsDateFormat(prc.ultimoGradoEstudios.FECHA_OBTENCION[1],"dd/mm/yyyy")#</b></p>
                      </div>
                    </cfoutput>
                  </cfif>                                

                  <p><br><strong>Observaciones:</strong></p>
                  <textarea id="inObservaciones" name="inObservaciones" class="form-control textarea" rows="10" placeholder="Capture las observaciones"></textarea>
                </form>
              </div>
              <div id="mdlResumenEvaluacionBody" class="divScroll" style="width:100%"> </div>
            </div>
          </div>
      </div>
  </div>
</div>

<div class="modal inmodal fade modaltext mdl-comentarEval" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" onclick="cancelarTinyMCE();" aria-hidden="true"><i class="fa fa-times fa-lg"></i></button>
                <h4 class="modal-title">Comentario evaluación</h4>
            </div>

            <div class="modal-body saveComentario">
              <input type="hidden" id="pkEvalComent">
              <textarea id="inContentCorreo" name="inContentCorreo" class="mytextarea"></textarea>
            </div>

            <div class="modal-body getComentario"> </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="cancelarTinyMCE();"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right guardaComent" onclick="saveComentEval();"><span class="fa fa-check"></span> Guardar</button>           
            </div>
        </div>
    </div>
</div>

<div id="mdl-registroObservaciones" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 999999 !important;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 10px 30px 70px;">
                <button type="button" class="close CheckReresh" data-dismiss="modal" onclick="cancelarTinyMCE();" aria-hidden="true" style="margin-top: -20px;"><h1><strong>&times;</strong></h1></button>
                <h2 class="pull-left">Observación</h2>
            </div>
            <div class="modal-body">
                <textarea id="inComent" name="inComent"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default ml5 CheckReresh" class="close" data-dismiss="modal" onclick="cancelarTinyMCE();">Cancelar</button>
                <button type="button" class="btn btn-success pull-right ml5" onclick="guardarRegistroObservaciones();">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade modaltext modal_reclasificacion" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h4 class="modal-title">Reclasificación de productos</h4>
            </div>
            <div class="modal-body">
            	<input type="hidden" id="reclasificaProducto" 	value="0">
            	<input type="hidden" id="tipoPuntuacion" 		value="0">
            	<table id="tabla_reclasificacion" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-search-accent-neutralise="true">
				    <thead>
				        <th class="text-center" data-formatter="getIndex">#</th>
				        <th data-sortable='true' class="text-center">Clasificación</th>
				        <th data-sortable='true'>Producto</th>
				        <th data-sortable='true' class="text-center">Puntaje maximo</th>
				        <th data-sortable='true' class="text-center">Accion</th>
				    </thead>
				    <tbody>
						<cfset i = 0> 
				      	<cfoutput query="prc.clasificaciones">
				      		<form>
								<tr>
									<cfset i++>
									<td>#i#</td>
									<td>#CLASIF#. #SUBCLA#</td>
									<td>#NOMBRE_PROD#</td>
						            <td>#PUNTAJE_MAX#</td>
									<td>
			    						<input type="radio" name="optradio" onclick="reclasificaProducto(#PK_PROD#, '#CLASIF#', '#SUBCLA#', #PUNTAJE_MAX#);">
									</td>
								</tr>
							</form>
						</cfoutput>
				    </tbody>
				</table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="row" id="documentosRI" style="width:20%; position: fixed; bottom: 0; margin-left: 0; margin-right: 0; display:none;">
	<div class="panel panel-primary" style="margin: 0% -12% 20% 6%;">
		<div class="panel-heading">Documentos del recurso de inconformidad</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-md-12">
					<div id="otrosAdjuntosNRI"></div>
					<div id="otrosAdjuntosRI" class="panel-group"></div>
				</div>
			</div>
		</div>
	</div>
</div>
