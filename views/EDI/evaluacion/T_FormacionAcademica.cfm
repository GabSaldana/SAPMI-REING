<cfif prc.validaciones.recordcount GT 0>
<cfprocessingdirective pageEncoding="utf-8">

<cfset accionesValidacion = queryGetRow(prc.validaciones, 1)>

<cfinclude template="T_FormacionAcademica_js.cfm">

<style type="text/css">
	.escolaridadEvaluada{
		background-color: #ebfaeb !important;
	}
	.escolaridadNoEvaluada{
		background-color:#ffe6e6 !important;
	}
</style>

<cfif prc.escolaridad.recordcount GT 0 >

	<!--- <cfdump var="#prc.escolaridad#">
	<cfdump var="#prc.proceso#"> --->

	<div class="row"><h4><center>EVALUACIÓN DE LA FORMACIÓN ACADÉMICA</center></h4></div>

	<ul class="sortable-list connectList agile-list ui-sortable listaJust">
		<cfoutput>
			<cfloop query="#prc.escolaridad#">			
				<cfif compare(TES_PUNTAJEOBTENIDO, "") NEQ 0>
					<cfset escolaridadEvaluada = "escolaridadEvaluada">			
				<cfelse>
					<cfset escolaridadEvaluada = "escolaridadNoEvaluada">
				</cfif>					
				<li class="success-element filaEscolaridad" data-clasif="#CES_CLASIFICACION#" data-subclasif="#CES_SUBCLASIFICACION#" data-accion="#CET_ACC_CVE#">
					<h5 class="p-xs bg-primary b-r-sm"><span style="font-size: 16px; text-decoration: underline overline;">#CES_CLASIFICACION_ROMANO#.#CES_SUBCLASIFICACION_ROMANO#</span> - Formación Académica / #CES_ESCOLARIDAD#</h5>
					<ul class="agile-list" style="padding: 5px;">
						<li class="info-element #escolaridadEvaluada#">
							<div class="row">
								<div class="col-sm-3">
									<span>Campo de Conocimiento:</span>
									<label>#TES_CAMPO_CONOCIMIENTO#</label>
								</div>						
								<div class="col-sm-3">
									<span>Escuela:</span>
									<label>#TES_ESCUELA#</label>
								</div>
								<div class="col-sm-3">
									<span>Cédula Profesional:</span>
									<label>#TES_CEDULAPROFECIONAL#</label>
								</div>
								<div class="col-sm-3">
									<span>¿Estuvo en PNPC?:</span>
									<label>#IIF((TES_PNCP EQ 1),de("Si"),de("No"))#</label>
								</div>
								<div class="col-sm-3">
									<span>Fecha de Inicio:</span>
									<label>#LSDateFormat(TES_FECHAINICIO,"dd/mm/yyyy")#</label>
								</div>
								<div class="col-sm-3">
									<span>Fecha de Fin:</span>
									<label>#LSDateFormat(TES_FECHATERMINO,"dd/mm/yyyy")#</label>
								</div>
								<div class="col-sm-3">
									<span>Fecha de Obtención:</span>
									<label>#LSDateFormat(TES_FECHAOBTENCION,"dd/mm/yyyy")#</label>
								</div>
							</div>				
							<div class="row">
								<div class="col-sm-12">
									<ul class="list-group clear-list m-t">
										<li class="list-group-item fist-item">
											<span>Copia del Diploma:</span>
											<button class="btn btn-white btn-rounded btnFile pull-right" onclick="descargaComprobanteConsulta(#Session.cbstorage.usuario.VERTIENTE#,377,#TES_PK_TESCOLARIDAD#);">Descargar <span class="fa fa-download"></span></button>
										</li>
									</ul>
								</div>
							</div>
							<hr>
							<h4 class="text-center">Evaluación</h4>						
							<div class="row">
								<div class="col-sm-12">
									<table class="table table-hover">
										<thead>
											<tr>
												<th class="text-center" width="33%" style="font-weight: normal;">Evaluación</th>
												<th class="text-center" width="33%" style="font-weight: normal;">Puntaje Obtenido</th>											
												<th class="text-center" width="33%" style="font-weight: normal;">Fecha de Evaluación</th>											
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="text-center"><h4>#CET_NOMBRE#</h4></td>
												<td class="text-center">						
													<cfif listFind(accionesValidacion.ACCIONESCVE,CET_ACC_CVE,"$")>		
														<cfif compare(TES_PUNTAJEOBTENIDO, "") NEQ 0 AND TES_PUNTAJEOBTENIDO NEQ 0>
															<select data-accion="#CET_ACC_CVE#" data-pktog="#TES_FK_OBTENCIONGRADO#" data-pkeval="#TES_PK_EVALUACIONESCOLARIDAD#" class="form-control setEvaluacionEscolaridad">
																<option value="0">0</option>
																<option selected value="#CES_PUNTAJE#">#CES_PUNTAJE#</option>
															</select>							
														<cfelse>
															<select data-accion="#CET_ACC_CVE#" data-pktog="#TES_FK_OBTENCIONGRADO#" data-pkeval="#TES_PK_EVALUACIONESCOLARIDAD#" class="form-control setEvaluacionEscolaridad">
																<option selected value="0">0</option>
																<option value="#CES_PUNTAJE#">#CES_PUNTAJE#</option>
															</select>
														</cfif>
													<cfelse>
														<span>#numberFormat(TES_PUNTAJEOBTENIDO)#</span>
													</cfif>			
												</td>
												<td class="text-center">
													<cfif compare(TES_FECHACAPTURA, "") NEQ 0>
														#LSDateFormat(TES_FECHACAPTURA,"dd/mm/yyyy")#<small>#lsTimeFormat(TES_FECHACAPTURA,"hh:mm:ss tt")#</small>
													</cfif>												
												</td>											
											</tr>										
										</tbody>
									</table>
								</div>
							</div>
						</li>
					</ul>
				</li>			
			</cfloop>
		</cfoutput>
	</ul>



	<form id="downloadComprobanteEscolaridad" action="<cfoutput>#event.buildLink('adminCSII.ftp.archivo.descargarArchivo')#</cfoutput>" method="POST" target="_blank">
		<input type="hidden" id="pkFrmCatArchEscolaridad" name="pkCatalogo">
		<input type="hidden" id="pkFrmEscolaridad" name="pkObjeto">
	</form>

	<div class="modal inmodal fade modaltext modalCalificacionCeroEscolaridad" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
					<h4 class="modal-title">Observaciones de la Formación Académica</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="pkEtapaCeroEscolaridad" value="">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-pushpin"></span>
							</span>
							<select id="inMotivoEscolaridad" name="inMotivo" class="form-control">
								<option value="" selected="selected">Seleccione una opción</option>
								<cfoutput>
									<cfloop query="#prc.motivo#">
										<option value="#PK_MOTIVO#" >#DESC_MOTIVO#</option>
									</cfloop>
								</cfoutput>								
							</select>						
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="cancelarCeroEscolaridad();">Cancelar</button>
					<button type="button" class="btn btn-success btn-lg pull-right" onclick="guardaCeroEscolaridad();">Calificar</button>
				</div>
			</div>
		</div>
	</div>
</cfif>

</cfif>
