<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="selectProducto_js.cfm">

<style type="text/css">
	.list-group.clear-list .list-group-item {
		background: transparent;
	}
</style>

<input type="hidden" id="pkUsuarioEvaluado" 		value="<cfoutput>#prc.pkUsuario#</cfoutput>">
<input type="hidden" id="tipoEvaluacion" 			value="">
<input type="hidden" id="tipoEvaluacionRealizada" 	value="">
<input type="hidden" id="pkAspiranteProceso" 		value="">

<form id="validaPuntajes" onsubmit="return false;">
<ul class="sortable-list connectList agile-list ui-sortable listaJust" id="prodContNoEval">
	
	<cfif arrayLen(prc.productos) EQ 0>
		<h1>No se encontraron productos.</h1>
	</cfif>
	<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
		<cfset producto 	= prc.productos[numReporte].reporte>
		<cfset ruta 		= prc.productos[numReporte].ruta>
		<cfset filas 		= producto.getFilas()>
		<cfset encabezado 	= producto.getEncabezado()>
		<cfset columnas 	= encabezado.getColumnas()>
		<cfset pkReporte 	= producto.getPkReporte()>
		<cfset pkformato 	= producto.getPkTFormato()>
		<cfset pkPeriodo 	= producto.getPkPeriodo()>
		
		<cfif arraylen(filas) GT 0>
			<cfset rotulo= false><!---SE UTILIZA PARA EVITAR UN ERROR AL MOMEMTO DE MOSTRAR LA NUMERACION DEL PRODUCTO --->
					<cfloop array="#filas#" index="fila">
						<cfif fila.getPROCESO() EQ prc.PROCESO.getPKPROCESO()>
						<cfif not rotulo>
						<li class="success-element productoEvaluacion" data-clasif="<cfoutput>#filas[1].getCLASIFICACION()#</cfoutput>" data-subclasif="<cfoutput>#filas[1].getSUBCLASIFICACION()#</cfoutput>">				
							<h5 class="p-xs bg-primary b-r-sm"><cfoutput><span style="font-size: 16px; text-decoration: underline overline;">#filas[1].getCLASIFICACION_ROMANO()#.#filas[1].getSUBCLASIFICACION_ROMANO()#</span> - #arrayToList(ruta," / ")#</cfoutput></h5>					
							<ul class="agile-list" style="padding: 5px;">
							<cfset rotulo= true>
						</cfif>
							<li class="info-element productoNoEvaluado" style="background-color:#ffe6e6">
								<cfif arraycontains(session.cbstorage.grant,'evalEDI.reclaEval')>
									<div class="row">
										<div class="col-sm-12">
											<cfoutput>
												<button class="btn btn-danger guiaEditProd pull-right" onclick="editarFila(#pkformato#,#pkPeriodo#,#pkReporte#,#fila.getPK_FILA()#);">Editar <span class="fa fa-edit"></span></button>
											</cfoutput>
										</div>						
									</div>
								</cfif>
								
								<div class="row">
									<cfloop array="#columnas#" index="columna">
										<cfif NOT (columna.getValidator() EQ "seleccionArchivo" OR columna.getValidator() EQ "archivoRequerido")>
											<div class="col-sm-3">
												<span><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</span>
												<cftry>
													<label><cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput></label>
												<cfcatch>
												</cfcatch>
												</cftry>
											</div>
										</cfif>
									</cfloop>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<cfoutput>
											<ul class="list-group clear-list m-t">
												<cfloop array="#columnas#" index="columna">
													<cfif columna.getValidator() EQ "seleccionArchivo" OR columna.getValidator() EQ "archivoRequerido">
														<cftry>
															<cfif NOT TRIM(#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#) EQ ''>
																<li class="list-group-item fist-item">
																	<span><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</span>
																	<button class="btn btn-white btn-rounded btnFile pull-right" onclick="descargaComprobante(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);">Descargar <span class="fa fa-download"></span></button>
																</li>
															</cfif>	
															<cfcatch>
															</cfcatch>
														</cftry>
													</cfif>
												</cfloop>
											</ul>
										</cfoutput>
									</div>
								</div>										
								
								<cfif arrayLen(fila.getEVALUACION_ETAPAS()) GT 0>
									<hr>
									<h4 class="text-center">Evaluación</h4>
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-hover">
												<thead>
													<tr >
														<th class="text-center" style="font-weight: normal;">Evaluación</th>
														<th class="text-center" style="font-weight: normal;">Puntaje Obtenido</th>
														<th class="text-center" style="font-weight: normal;">Reclasificación</th>			
														<th class="text-center" style="font-weight: normal;">Fecha de Evaluación</th>
														<th class="text-center" style="font-weight: normal;" width="40%">Comentarios</th>
													</tr>
												</thead>
												<tbody>


												<cfoutput>
													<cfset fila.setEtapasEditar(prc.validaciones.ACCIONESCVE)><!--- se define que etapas son editables --->
													<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="etapa">
															<cfif etapa.getEDITABLE()>
														
																<tr>
																	<td class="text-center"><h4>#etapa.getNOMBRE_TIPO_EVALUACION()#</h4></td>								
																	<td class="text-center">
																		<div class="seccionEval_#etapa.getPK_EVALUACIONETAPA()#">
																			<cfif #etapa.getNuevoTipoPuntuacion()# EQ 1>
																				<div class="form-group">
																					<select class="form-control guardaFija #etapa.getNOMBRE_TIPO_EVALUACION()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#" accion="#etapa.getCVETIPO()#" pk_evaluacion="#etapa.getPK_EVALUACION()#" id="#etapa.getPK_EVALUACIONETAPA()#" name="name_#etapa.getPK_EVALUACIONETAPA()#">
																						<option value="" selected>Elija un puntaje</option>
																						<option value="0">0</option>
																						<option value="#etapa.getNuevoPuntajeMaximo()#">#etapa.getNuevoPuntajeMaximo()#</option>
																					</select>
																				</div>
																			<cfelseif #etapa.getNuevoTipoPuntuacion()# EQ 2>
																				<input class="form-control guardaContinua #etapa.getNOMBRE_TIPO_EVALUACION()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#" accion="#etapa.getCVETIPO()#" pk_evaluacion="#etapa.getPK_EVALUACION()#" pk_estado="#etapa.getCESESTADO()#" id="#etapa.getPK_EVALUACIONETAPA()#" name="name_#etapa.getPK_EVALUACIONETAPA()#" placeholder="Seleccione una puntuación">
																			<cfelseif #etapa.getNuevoTipoPuntuacion()# EQ 3>
																				<div class="form-group">
																					Horas:
																					<input class="form-control calculaHoras #etapa.getNOMBRE_TIPO_EVALUACION()# et_#etapa.getPK_EVALUACIONETAPA()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#" pkEtapaHoras="#etapa.getPK_EVALUACIONETAPA()#" puntajeMax="#etapa.getNuevoPuntajeMaximo()#" pk_evaluacion="#etapa.getPK_EVALUACION()#" placeholder="Cantidad de horas">
																				</div>
																				<div class="form-group">
																					Valor redondeado del puntaje:
																					<input type="text" class="form-control guardaHoras" accion="#etapa.getCVETIPO()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#" pk_evaluacion="#etapa.getPK_EVALUACION()#" id="#etapa.getPK_EVALUACIONETAPA()#" disabled>
																				</div>
																			</cfif>
																		</div>
																	</td>
																	<td class="text-center" id="recla_#etapa.getPK_EVALUACIONETAPA()#"> 
																		<div>
																			<cfif #isNumeric(#etapa.getFK_RECLASIFICACION()#)#>
																				<button class="btn btn-danger fa fa-recycle btn-xs" title="Reclasificar" onclick="cambiarReclasificacion(#etapa.getPK_EVALUACIONETAPA()#, #etapa.getREC_TIPOPUNTUACION()#);"></button>
																				<span id="botRec_#etapa.getPK_EVALUACIONETAPA()#">
																					<button class="btn btn-success fa fa-reply btn-xs" title="Quitar reclacificación" onclick="desReclasificar(#etapa.getPK_EVALUACIONETAPA()#);"></button>
																				</span><br>
																				<span id="msgRec_#etapa.getPK_EVALUACIONETAPA()#">
																					<b class="text-success" style="font-size:18px">Reclasificado a #etapa.getREC_CLASIFICACION_ROMANO()#. #etapa.getREC_SUBCLASIFICACION()#</b>
																				</span>
																			<cfelse>
																				<button class="btn btn-danger fa fa-recycle btn-xs" title="Reclasificar" onclick="cambiarReclasificacion(#etapa.getPK_EVALUACIONETAPA()#, #etapa.getTIPO_PUNTUACION()#);"></button>
																			</cfif>
																		</div>
																	</td>
																	<td id="fecha#etapa.getPK_EVALUACIONETAPA()#" class="text-center">#dateTimeFormat(etapa.getFECHA_CAPTURA(),"dd/mm/yyyy")# <small>#dateTimeFormat(etapa.getFECHA_CAPTURA(),"hh:nn tt")#</small>
																	</td>
																	<td class="text-center">
																		<div id="coment1_#etapa.getPK_EVALUACIONETAPA()#">
																			<cfif #etapa.getCOMENT_EVAL()# NEQ ''>
																				<div id="coment2_#etapa.getPK_EVALUACIONETAPA()#" onclick="editaComentario(#etapa.getPK_EVALUACIONETAPA()#)">
																					#etapa.getCOMENT_EVAL2()#
																				</div>
																			<cfelse>
																				<div id="botCom_#etapa.getPK_EVALUACIONETAPA()#">
																					<button class="btn btn-primary fa fa-comment" title="Comentar evaluacion" onclick="modalComentarEval(#etapa.getPK_EVALUACIONETAPA()#);"></button>
																				</div>
																			</cfif>
																		</div>
																		<b class="text-success" style="font-size:18px">#etapa.getMOTIVO()#</b>
																	</td>
																</tr>
															<cfelse>
															
																<tr>
																	<td class="text-center"><h4>#etapa.getNOMBRE_TIPO_EVALUACION()#</h4></td>								
																	<td class="text-center">
																		<div>
																			<cfif #etapa.getNuevoTipoPuntuacion()# EQ 3>
																				<div class="form-group">
																					Horas:
																					<cfif etapa.getPUNTAJE_OBTENIDO() eq ''>
																					<input class="form-control productoNoEvaluado inProductoEvaluado"  id="#etapa.getPK_EVALUACIONETAPA()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#"  value="#0#" disabled>
																					<cfelse>
																					<input class="form-control productoNoEvaluado inProductoEvaluado"  id="#etapa.getPK_EVALUACIONETAPA()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#"  value="#Round(etapa.getPUNTAJE_OBTENIDO()/etapa.getNuevoPuntajeMaximo())#" disabled>
																					</cfif>
																				</div>
																				<div class="form-group">
																					Valor redondeado del puntaje:
																					<input type="text" value="#etapa.getPUNTAJE_OBTENIDO()#" disabled>
																				</div>
																			<cfelse>
																				<input class="form-control productoNoEvaluado inProductoEvaluado" id="#etapa.getPK_EVALUACIONETAPA()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#"  value="#etapa.getPUNTAJE_OBTENIDO()#" disabled>
																			</cfif>
																		</div>
																	</td>
																	<td class="text-center" id="recla_#etapa.getPK_EVALUACIONETAPA()#"> 
																		<div>
																			<cfif #isNumeric(#etapa.getFK_RECLASIFICACION()#)#>
																				<span id="msgRec_#etapa.getPK_EVALUACIONETAPA()#">
																					<b class="text-success" style="font-size:18px">Reclasificado a #etapa.getREC_CLASIFICACION_ROMANO()#. #etapa.getREC_SUBCLASIFICACION()#</b>
																				</span>
																			</cfif>
																		</div>
																	</td>
																	<td id="fecha#etapa.getPK_EVALUACIONETAPA()#" class="text-center">#dateTimeFormat(etapa.getFECHA_CAPTURA(),"dd/mm/yyyy")# <small>#dateTimeFormat(etapa.getFECHA_CAPTURA(),"hh:nn tt")#</small>
																	</td>
																	<td class="text-center">
																		<div id="coment1_#etapa.getPK_EVALUACIONETAPA()#">
																			<div id="coment2_#etapa.getPK_EVALUACIONETAPA()#">
																				#etapa.getCOMENT_EVAL2()#
																			</div>
																		</div>
																		<b class="text-success" style="font-size:18px">#etapa.getMOTIVO()#</b>
																	</td>
																</tr>
													

															</cfif>
													</cfloop>
												</cfoutput>					
												</tbody>
											</table>
										</div>
									</div>
								</cfif>
							</li>				
						</cfif>						
					</cfloop>		
				</ul>				
			</li>			
		</cfif>
	</cfloop>	
</ul>
</form>


<ul class="sortable-list connectList agile-list ui-sortable listaJust" id="prodContEval">
	
	<cfif arrayLen(prc.productos) EQ 0>
		<h1>No se encontraron productos.</h1>
	</cfif>
	<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
		<cfset producto = prc.productos[numReporte].reporte>
		<cfset ruta =  prc.productos[numReporte].ruta>
		<cfset filas = producto.getFilas()>
		<cfset encabezado = producto.getEncabezado()>
		<cfset columnas = encabezado.getColumnas()>
		<cfset pkReporte = producto.getPkReporte()>
		<cfset pkformato = producto.getPkTFormato()>
		<cfset pkPeriodo = producto.getPkPeriodo()>
		
		<cfif arraylen(filas) GT 0>
			<li class="success-element productoEvaluacionEval" data-clasif="<cfoutput>#filas[1].getCLASIFICACION()#</cfoutput>" data-subclasif="<cfoutput>#filas[1].getSUBCLASIFICACION()#</cfoutput>">				
				<cfloop array="#filas#" index="fila">						
					<cfif fila.getPROCESO() NEQ prc.PROCESO.getPKPROCESO()>
					<h5 class="p-xs bg-primary b-r-sm"><cfoutput><span style="font-size: 16px; text-decoration: underline overline;">#filas[1].getCLASIFICACION_ROMANO()#.#filas[1].getSUBCLASIFICACION_ROMANO()#</span> - #arrayToList(ruta," / ")#</cfoutput></h5>					
					<ul class="agile-list" style="padding: 5px;">
						<li class="info-element productoEvaluado">
							
							<cfif arraycontains(session.cbstorage.grant,'evalEDI.reclaEval')>
								<div class="row">
									<div class="col-sm-12">
										<cfoutput>
											<button class="btn btn-warning guiaEditProd pull-right" onclick="editarFila(#pkformato#,#pkPeriodo#,#pkReporte#,#fila.getPK_FILA()#);">Editar <span class="fa fa-edit"></span></button>
											<button class="btn btn-danger guiaEditProd pull-right" onclick="enviarToEvaluacion(#fila.getPK_FILA()#);">Enviar a evaluación<span class="fa fa-edit"></span></button>
										</cfoutput>
									</div>						
								</div>
							</cfif>
							<div class="row">
								<cfloop array="#columnas#" index="columna">
									<cfif NOT (columna.getValidator() EQ "seleccionArchivo" OR columna.getValidator() EQ "archivoRequerido")>
										<div class="col-sm-3">
											<label class="control-label"><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</label>
											<cftry>
												<cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput>
												<cfcatch>
													
												</cfcatch>
											</cftry>
										</div>
									</cfif>
								</cfloop>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<cfoutput>
										<ul class="list-group clear-list m-t">
											<cfloop array="#columnas#" index="columna">
												<cfif columna.getValidator() EQ "seleccionArchivo" OR columna.getValidator() EQ "archivoRequerido">
													<li class="list-group-item fist-item">
														<label class="control-label"><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</label>
														<cftry>
															<cfif TRIM(#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#) EQ ''>
																<span class="btn btn-white btn-rounded btnFile pull-right">Sin documento</span>
															<cfelse>
																<button class="btn btn-white btn-rounded btnFile pull-right" onclick="descargaComprobante(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);">Descargar <span class="fa fa-download"></span></button>
															</cfif>	
															<cfcatch>
															</cfcatch>
														</cftry>
														
													</li>
												</cfif>
											</cfloop>
										</ul>
									</cfoutput>
								</div>
							</div>	
							
								<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="etapa">
									<cfoutput>
										<div class="row">
										<div class="col-sm-12">
											<table  class="table table-hover">
												
												<thead>
															<tr>
																<th class="text-center">Evaluación</th>
																<th class="text-center">Puntaje Obtenido</th>
																<th class="text-center">Reclasificación</th>
															</tr>
														</thead>
												<tr>
													<td class="text-center"><h4>#etapa.getNOMBRE_TIPO_EVALUACION()#</h4></td>								
													<td class="text-center">
														<div class="seccionEval_#etapa.getPK_EVALUACIONETAPA()#">
																<input class="form-control guardaContinuaEvaluado #etapa.getNOMBRE_TIPO_EVALUACION()#" pk_etapa="#etapa.getPK_EVALUACIONETAPA()#"
																	pk_evaluacion="#etapa.getPK_EVALUACION()#" pk_estado="#etapa.getCESESTADO()#" id="#etapa.getPK_EVALUACIONETAPA()#" 
																	name="name_#etapa.getPK_EVALUACIONETAPA()#" placeholder="Seleccione una puntuación" value="#etapa.getPUNTAJE_OBTENIDO()#" >
														</div>
													</td>
													<td class="text-center" id="recla_#etapa.getPK_EVALUACIONETAPA()#"> 
														<div>
															<cfif #isNumeric(#etapa.getFK_RECLASIFICACION()#)#>
																<button class="btn btn-danger fa fa-recycle btn-xs" title="Reclasificar" onclick="cambiarReclasificacion(#etapa.getPK_EVALUACIONETAPA()#, #etapa.getREC_TIPOPUNTUACION()#);"></button>
																<span id="msgRec_#etapa.getPK_EVALUACIONETAPA()#">
																	<b class="text-success" style="font-size:18px">Reclasificado a #etapa.getREC_CLASIFICACION_ROMANO()#. #etapa.getREC_SUBCLASIFICACION()#</b>
																</span>
															<cfelse>
																<button class="btn btn-danger fa fa-recycle btn-xs" title="Reclasificar" onclick="cambiarReclasificacion(#etapa.getPK_EVALUACIONETAPA()#, #etapa.getTIPO_PUNTUACION()#);"></button>
															</cfif>
														</div>
													</td>
												</tr>
											</table>
										</div>
									</div>
									</cfoutput>
									
								</cfloop>
						</li>	
					</ul>				
					</cfif>						
				</cfloop>	
				
				
				
								
			</li>			
		</cfif>
	</cfloop>

</ul>




<form id="downloadComprobanteInv" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="POST" target="_blank">
	<input type="hidden" id="pkCatFmtInv"	name="pkCatFmt">
	<input type="hidden" id="pkColDownInv"	name="pkColDown">
	<input type="hidden" id="pkFilaDownInv"	name="pkFilaDown">
	<input type="hidden" id="vertiente"		name="vertiente">
</form>

<div class="modal inmodal fade modaltext modalCalificacionCero" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h4 class="modal-title">Observaciones de la calificaci&oacute;n</h4>
            </div>

            <div class="modal-body">
            	<input type="hidden" id="pkEtapaCero" 		value="">
            	<input type="hidden" id="pkEvaluacionCero" 	value="">
            	<input type="hidden" id="accionCero" 		value="">
            	
            	<div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-pushpin"></span>
                        </span>
                        <form id="validaMotivo" onsubmit="return false;">
	                        <select id="inMotivo" name="inMotivo" class="form-control">
	                            <option value="" selected="selected">Seleccione una opci&oacute;n</option>
	                            <cfset total_records = prc.motivo.recordcount/>
	                            <cfloop index="x" from="1" to="#total_records#">
	                                <cfoutput>
	                                    <option value="#prc.motivo.PK_MOTIVO[x]#" >#prc.motivo.DESC_MOTIVO[x]#</option>
	                                </cfoutput>
	                            </cfloop>
	                        </select>
	                    </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" onclick="guardaCero();">Calificar</button>
            </div>
        </div>
    </div>
</div>
