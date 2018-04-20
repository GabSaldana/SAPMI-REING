<cfoutput>
	<script type="text/javascript">
	<!--
		<!---
		* Fecha:	Abril 20, 2015
		* @author	Sergio E. Cuevas Olivares
		* --->
		function verLineaError(objeto){
			$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.verErrorLinea")#</cfoutput>', {nomArchivo: $(objeto).attr('data-file') , numeroLinea: $(objeto).attr("data-line"), fechaError : $(objeto).attr("data-date-error") }, function(data){
				$('##modalInformacion>div>div>div>h4.modal-title').html( " C&oacute;digo fuente : " + $(objeto).attr('data-file') );
				$('##informacionID').html( data );
				$('##modalInformacion').modal('show');
			});
		}
		
		<!---
		* Fecha:	Abril 20, 2015
		* @author	Sergio E. Cuevas Olivares
		* --->
		function verReferencias(){
			$('##cargador-modal').modal('show');
			$.post('<cfoutput>#event.buildLink("adminCSII.administrador.error.error.verReferenciaDB_ORA")#</cfoutput>', function(data){
				$('##cargador-modal').modal('hide');
				setTimeout(function (){
					$('##modalInformacion>div>div>div>h4.modal-title').html( "Lista de errores " );
					$('##informacionID').html( data );
					$('##modalInformacion').modal('show');
				},800);
			});
		}
	-->
	</script>
	<cfif IsJSON(prc.informacion.DESCRIPCION_ERROR[1])>
		<cfset DESC_ERROR = DeserializeJSON(prc.informacion.DESCRIPCION_ERROR[1])>
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Detalle del error<span class="badge pull-right">##&nbsp;<strong>#prc.informacion.PK_ERROR[1]#</strong></span></h3>
			</div>
			<div class="panel-body">
				<div class="panel panel-primary">
					<div class="panel-body">
						<div class="row">
							<div class="col-md-6">
								<div class="row">
									<div class="col-xs-6 col-md-4">
										<label>Tipo error:</label>
									</div>
									<div class="col-xs-12 col-sm-8 col-md-8">
										<div class="alert alert-danger text-center" role="alert">#prc.informacion.CLAVE_ERROR[1]#</div>
									</div>
								</div>
								<div class="clearfix"><br /></div>
							</div>
							<div class="col-md-6">
								<div class="row">
									<div class="col-xs-6 col-md-5">
										<label>Fecha y hora de Registro:</label>
									</div>
									<div class="col-xs-12 col-sm-8 col-md-7">
										<p class="text-center">#REReplace(prc.informacion.FECHA_REGISTRO[1], " ", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", "all")#</p>
									</div>
								</div>
								<div class="clearfix"><br /></div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Usuario:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#prc.informacion.NOMBRE_COMPLETO[1]#
							</div>
						</div>
						<div class="clearfix"><br /></div>
					</div>
				</div>
				<div class="panel panel-primary">
					<div class="panel-body">
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Servidor:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#REReplace(DESC_ERROR.APPLICATION.HOST_SERVER, " ", "&nbsp;&nbsp;&nbsp; / &nbsp;&nbsp;&nbsp;", "all")#
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Navegador:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#DESC_ERROR.APPLICATION.BROWSER#
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Fecha y hora del error:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#DESC_ERROR.APPLICATION.BUG_DATE#
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<cfif IsDefined("DESC_ERROR.APPLICATION.REMOTE_ADDRESS")>
							<div class="row">
								<div class="col-xs-6 col-md-2">
									<label>Direci&oacute;n IP Remota:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									#DESC_ERROR.APPLICATION.REMOTE_ADDRESS#
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Plantilla:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#DESC_ERROR.APPLICATION.TEMPLATE_PATH#
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<cfif IsDefined("DESC_ERROR.APPLICATION.QUERY_STRING") AND DESC_ERROR.APPLICATION.QUERY_STRING NEQ "">
							<div class="row">
								<div class="col-xs-6 col-md-2">
									<label>Argumentos:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									#DESC_ERROR.APPLICATION.QUERY_STRING#
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Informaci&oacute;n del PATH:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#DESC_ERROR.APPLICATION.PATH_INFO#
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<div class="row">
							<div class="col-xs-6 col-md-2">
								<label>Evento registrado:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								#DESC_ERROR.APPLICATION.CURRENT_EVENT#
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<cfif IsDefined("DESC_ERROR.APPLICATION.CURRENT_LAYOUT") AND DESC_ERROR.APPLICATION.CURRENT_LAYOUT NEQ "">
							<div class="row">
								<div class="col-xs-6 col-md-2">
									<label>Layout:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									#DESC_ERROR.APPLICATION.CURRENT_LAYOUT#
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<cfif IsDefined("DESC_ERROR.APPLICATION.CURRET_VIEW") AND DESC_ERROR.APPLICATION.CURRET_VIEW NEQ "">
							<div class="row">
								<div class="col-xs-6 col-md-2">
									<label>Vista:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									#DESC_ERROR.APPLICATION.CURRET_VIEW#
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<cfif IsDefined("DESC_ERROR.APPLICATION.MISSING_FILE") AND DESC_ERROR.APPLICATION.MISSING_FILE NEQ "">
							<div class="row">
								<div class="col-xs-6 col-md-2">
									<label>Archivo no encontrado:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									#DESC_ERROR.APPLICATION.MISSING_FILE#
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<cfif IsDefined("DESC_ERROR.APPLICATION.COLDFUSION_ID")>
							<div class="row">
								<div class="col-xs-6 col-sm-3 col-md-2">
									<label>Coldfusion:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									<cfset cfCaracteristicas = DESC_ERROR.APPLICATION.COLDFUSION_ID>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="panel-title">Caracter&iacute;sticas</h3>
										</div>
										<div class="panel-body">
											<div class="table-responsive">
												<table class="table table-hover">
													<tbody>
														<cfloop collection="#cfCaracteristicas#" item="key">
															<cfif cfCaracteristicas[ key ] NEQ "">
																<tr>
																	<th class="text-left">#key#</th>
																	<td nowrap="nowrap">#htmlEditFormat( cfCaracteristicas[ key ] )#</td>
																</tr>
															</cfif>
														</cfloop>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</cfif>
						<div class="clearfix"><br /></div>
						<cfif IsStruct(DESC_ERROR.FORM_VARS) AND NOT StructIsEmpty(DESC_ERROR.FORM_VARS)>
							<div class="row">
								<div class="col-xs-6 col-sm-3 col-md-2">
									<label>Formulario:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									<cfset formVARS = DESC_ERROR.FORM_VARS>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="panel-title">Elementos</h3>
										</div>
										<div class="panel-body">
											<div class="table-responsive">
												<table class="table table-hover">
													<tbody>
														<cfloop collection="#formVARS#" item="key">
															<cfif formVARS[ key ] NEQ "">
																<cfif key NEQ "FIELDNAMES">
																	<tr>
																		<th class="text-left">#key#</th>
																		<td nowrap="nowrap">#htmlEditFormat( formVARS[ key ] )#</td>
																	</tr>
																</cfif>
															</cfif>
														</cfloop>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<cfif IsDefined("DESC_ERROR.APPLICATION.DATABASE_INFORMATION") AND IsStruct(DESC_ERROR.APPLICATION.DATABASE_INFORMATION)>
							<div class="row">
								<div class="col-xs-6 col-sm-3 col-md-2">
									<label>Base de Datos:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="panel-title">Detalles</h3>
										</div>
										<div class="panel-body">
											<div class="table-responsive">
												<table class="table table-hover">
													<tbody>
														<tr>
															<th class="text-left">Lista de errores:</th>
															<td><button type="button" class="btn btn-warning" onclick="verReferencias();"><span class="glyphicon glyphicon-search"></span></button></td>
														</tr>
														<tr>
															<th class="text-left">C&oacute;digo de error nativo:</th>
															<td>#DESC_ERROR.APPLICATION.DATABASE_INFORMATION.NATIVEERRORCODE#</td>
														</tr>
														<tr>
															<th class="text-left">Estado SQL:</th>
															<td>#DESC_ERROR.APPLICATION.DATABASE_INFORMATION.SQL_STATE#</td>
														</tr>
														<tr>
															<th class="text-left">SQL enviado:</th>
															<td>#DESC_ERROR.APPLICATION.DATABASE_INFORMATION.SQL_SENT#</td>
														</tr>
														<tr>
															<th class="text-left">Mensaje de error del Driver:</th>
															<td>#DESC_ERROR.APPLICATION.DATABASE_INFORMATION.DRIVER_ERROR_MSG#</td>
														</tr>
														<tr>
															<th class="text-left">Pares nombre-valor:</th>
															<td>#DESC_ERROR.APPLICATION.DATABASE_INFORMATION.NAME_VALUE_PAIRS#</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<div class="row">
							<div class="col-xs-6 col-sm-3 col-md-2">
								<label>Desglose del error:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">TAG CONTEXT</h3>
									</div>
									<div class="panel-body">
										<div class="table-responsive">
											<table class="table table-hover">
												<tbody>
													<cfloop index="s" from="1" to="#ArrayLen(DESC_ERROR.TAG_CONTEXT)#">
														<tr>
															<th class="text-left">#s#</th>
															<td nowrap="nowrap">
																<cfif StructKeyExists(DESC_ERROR.TAG_CONTEXT[s], "ID")>
																	<div class="row">
																		<div class="col-md-6">
																			<div class="row">
																				<div class="col-xs-6 col-md-4">
																					<label>TYPE:</label>
																				</div>
																				<div class="col-xs-12 col-sm-8 col-md-7">
																					#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].TYPE)#
																				</div>
																			</div>
																		</div>
																		<div class="col-md-6">
																			<div class="row">
																				<div class="col-xs-6 col-md-3">
																					<label>ID:</label>
																				</div>
																				<div class="col-xs-12 col-sm-8 col-md-7">
																					#DESC_ERROR.TAG_CONTEXT[s].ID#
																				</div>
																			</div>
																		</div>
																	</div>
																<cfelse>
																	<div class="row">
																		<div class="col-xs-6 col-md-2">
																			<label>TYPE:</label>
																		</div>
																		<div class="col-xs-12 col-sm-8 col-md-10">
																			#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].TYPE)#
																		</div>
																	</div>
																</cfif>
																<div class="row">
																	<div class="col-md-6">
																		<div class="row">
																			<div class="col-xs-6 col-md-4">
																				<label>LINE:</label>
																			</div>
																			<div class="col-xs-12 col-sm-8 col-md-7">
																				#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].LINE)#
																			</div>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="row">
																			<div class="col-xs-6 col-md-3">
																				<label>COLUMN:</label>
																			</div>
																			<div class="col-xs-12 col-sm-8 col-md-7">
																				#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].COLUMN)#
																			</div>
																		</div>
																	</div>
																</div>
																<div class="row">
																	<div class="col-xs-6 col-md-2">
																		<label>TEMPLATE:</label>
																	</div>
																	<div class="col-xs-12 col-sm-8 col-md-10">
																		<cfif s EQ 1>
																			<cfif FileExists(DESC_ERROR.TAG_CONTEXT[s].TEMPLATE)>
																				<cfif (StructKeyExists(DESC_ERROR.TAG_CONTEXT[s], "ID") 
																				AND ListFindNoCase('CF_CFPAGE,CF_DOTRESOLVER,??,CFSTOREDPROC',DESC_ERROR.TAG_CONTEXT[s].ID,',')) OR DESC_ERROR.TAG_CONTEXT[s].TYPE EQ 'SYNTAX'>
																					
																					<button type="button" class="btn btn-warning" data-line="#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].LINE)#" data-file="#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].TEMPLATE)#" data-date-error="#htmlEditFormat(prc.informacion.FECHA_REGISTRO[1])#" onclick="verLineaError(this);">
																						<span class="glyphicon glyphicon-zoom-in"></span>
																					</button>
																					
																				</cfif>
																			</cfif>
																		</cfif>
																		#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].TEMPLATE)#
																	</div>
																</div>
																<cfif StructKeyExists(DESC_ERROR.TAG_CONTEXT[s], "RAW_TRACE")>
																	<div class="row">
																		<div class="col-xs-6 col-md-2">
																			<label>RAW TRACE:</label>
																		</div>
																		<div class="col-xs-12 col-sm-8 col-md-10">
																			#htmlEditFormat(DESC_ERROR.TAG_CONTEXT[s].RAW_TRACE)#
																		</div>
																	</div>
																</cfif>
															</td>
														</tr>
													</cfloop>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"><br /></div>
						<cfif IsDefined("DESC_ERROR.SESSION_STORAGE.usuario")>
							<div class="row">
								<div class="col-xs-6 col-sm-3 col-md-2">
									<label>Sesi&oacute;n:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-10">
									<cfset sessioncbstorage = DESC_ERROR.SESSION_STORAGE>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h3 class="panel-title">Detalle de las variables</h3>
										</div>
										<div class="panel-body">
											<div class="table-responsive">
												<table class="table table-hover">
													<tbody>
														<cfif IsStruct(sessioncbstorage)>
															<cfloop collection="#sessioncbstorage#" item="key">
																<tr>
																	<cfif IsSimpleValue(sessioncbstorage[ key ])>
																		<th class="text-left">#key#</th>
																		<td nowrap="nowrap">#htmlEditFormat( sessioncbstorage[ key ] )#</td>
																	<cfelse>
																		<th class="text-left">
																			#key#
																		</th>
																		<td nowrap="nowrap">
																			<table width="100%" align="left" border="0" cellspacing="0" cellpadding="0" class="table table-striped">
																				<cfif IsStruct(sessioncbstorage[ key ])>
																					<cfset objeto = sessioncbstorage[ key ]>
																					<tbody>
																						<cfloop collection="#objeto#" item="clv">
																							<tr>
																								<cfif  IsStruct(objeto[ clv ])>
																									<th>#clv#</th>
																									<td><cfdump var="#objeto[ clv ]#"></td>
																								<cfelse>
																									<th>#clv#</th>
																									<td>#htmlEditFormat(objeto[ clv ])#</td>
																								</cfif>
																							</tr>
																						</cfloop>
																					</tbody>
																				</cfif>
																			</table>
																		</td>
																	</cfif>
																</tr>
															</cfloop>
														</cfif>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</cfif>
						<div class="row">
							<div class="col-xs-6 col-sm-3 col-md-2">
								<label for="justificacionTxt">Log:</label>
							</div>
							<div class="col-xs-12 col-sm-8 col-md-10">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">Stack Trace</h3>
									</div>
									<div class="panel-body">
										<div class="table-responsive">
											<table class="table table-hover">
												<tbody>
													<cfloop index="d" from="1" to="#ArrayLen(DESC_ERROR.STACK_TRACE)#">
														<tr>
															<th class="text-center"><h6>#d#</h6></th>
															<td>
																<cfif d EQ 1>
																	<h6><strong><em>#htmlEditFormat(DESC_ERROR.STACK_TRACE[d])#</em></strong></h6>
																<cfelse>
																	<h6>#htmlEditFormat(DESC_ERROR.STACK_TRACE[d])#</h6>
																</cfif>
															</td>
														</tr>
													</cfloop>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"><br /></div>
					</div>
				</div>
			</div>
		</div>
	</cfif>
	<div class="clearfix"><br /></div>
	<div id="modalInformacion" class="modal fade bs-example-modal-lg">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header alert-primary bg-primary">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="modal-title">&nbsp;</h4>
				</div>
				<div class="modal-body" id="modal-body">
					<div id="informacionID"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				</div>
			</div>
		</div>
	</div>
</cfoutput>