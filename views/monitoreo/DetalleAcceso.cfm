<script type="text/javascript">
<!--
	 $(document).ready(function(e) {
		$('[data-toggle="tooltip"]').tooltip();
		$('#accordion').on('hidden.bs.collapse', toggleChevron);
		$('#accordion').on('shown.bs.collapse', toggleChevron);
	});
	
	function toggleChevron(e) {
		$(e.target)
			.prev('.panel-heading')
			.find("i.indicator")
			.toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
	}
-->
</script>
<cfoutput>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Detalle del acceso</h3>
		</div>
		<div class="panel-body">
			<div class="panel panel-primary">
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-4">
									<label>UR:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<div class="text-center">#prc.informacion.ACCESO.UR[1]#</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-5">
									<label>Siglas:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<p class="text-center">#prc.informacion.ACCESO.SIGLAS_DEPENDENCIA[1]#</p>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-6 col-md-2">
							<label>Nombre de la dependencia:</label>
						</div>
						<div class="col-xs-12 col-sm-8 col-md-10">
							#prc.informacion.ACCESO.NOMBRE_DEPENDENCIA[1]#
						</div>
					</div>
					<div class="clearfix"><br /></div>
				</div>
			</div>
			<div class="panel panel-primary">
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-12">
									<cfif prc.informacion.ACCESO.FK_GENERO[1] EQ 1>
										<img src="/includes/img/userH2.png" width="70" height="70" alt="" class="img-responsive img-rounded center-block" data-toggle="tooltip"  title="Informaci&oacute;n del usuario" />
									<cfelseif prc.informacion.ACCESO.FK_GENERO[1] EQ 2>
										<img src="/includes/img/userM.png" width="70" height="70" alt="" class="img-responsive img-rounded center-block" data-toggle="tooltip"  title="Informaci&oacute;n del usuario" />
									</cfif>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-4">
									<label>Nombre del usuario:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<div class="text-center">#prc.informacion.ACCESO.NOMBRE_COMPLETO[1]#</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-4">
									<label>Tel&eacute;fono / Extensi&oacute;n:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<div class="text-center">#prc.informacion.ACCESO.TELEFONO[1]# / #prc.informacion.ACCESO.EXTENSION[1]#</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-5">
									<label>Usuario / Contrase&ntilde;a:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<p class="text-center">#prc.informacion.ACCESO.NOMBRE_USUARIO[1]# / *********</p>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
				</div>
			</div>
			<div class="panel panel-primary">
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-12">
									<img src="/includes/images/pc.png" width="150" height="105" alt="" class="img-responsive img-rounded center-block" data-toggle="tooltip"  title="Informaci&oacute;n del equipo" />
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">

							<div class="row">
								<div class="col-xs-6 col-md-6">
									<label>Fecha y hora de acceso:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-6">
									<div class="alert alert-info text-center" role="alert"><strong>#prc.informacion.ACCESO.FECHA_REGISTRO[1]#</strong></div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="row">
										<div class="col-xs-6 col-md-6">
											<label>Sistema Operativo:</label>
										</div>
										<div class="col-xs-12 col-sm-8 col-md-6">
											<div class="text-center">#prc.informacion.ACCESO.SISTEMA_OPERATIVO[1]#</div>
										</div>
									</div>
									<div class="clearfix"><br /></div>
								</div>
								<div class="col-md-6">
									<div class="row">
										<div class="col-xs-6 col-md-6">
											<label>Versi&oacute;n:</label>
										</div>
										<div class="col-xs-12 col-sm-8 col-md-6">
											<p class="text-center">#prc.informacion.ACCESO.VERSION_OS[1]#</p>
										</div>
									</div>
									<div class="clearfix"><br /></div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6 col-md-6">
									<label>Arquitectura:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-6">
									<p class="text-center">#prc.informacion.ACCESO.ARQUITECTURA_OS[1]#</p>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-4">
									<label>IP / HOST:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<div class="text-center">#prc.informacion.ACCESO.IP_HOST[1]#</div>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-xs-6 col-md-5">
									<label>Navegador / Idioma:</label>
								</div>
								<div class="col-xs-12 col-sm-8 col-md-7">
									<p class="text-center">#prc.informacion.ACCESO.NAVEGADOR[1]# / #prc.informacion.ACCESO.IDIOMA_NAVEGADOR[1]#</p>
								</div>
							</div>
							<div class="clearfix"><br /></div>
						</div>
					</div>
				</div>
			</div>
			<cfif prc.informacion.ACCIONES.recordCount GT 0>
				<div class="panel panel-primary">
					<div class="panel-body">
						<div class="row">
							<div class="col-md-12">
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-12">
										<img src="/includes/images/monitoreo.jpg" width="150" height="110" alt="" class="img-responsive img-rounded center-block" data-toggle="tooltip"  title="Monitoreo" />
									</div>
								</div>
								<div class="clearfix"><br /></div>
							</div>
						</div>
						<div class="row">
							<div class="panel-group" id="accordion">
								<cfloop index="w" from="1" to="#prc.informacion.ACCIONES.recordCount#">
									<cfset open = ''>
									<cfset icono = 'chevron-up'>
									<cfif w EQ 1>
										<cfset open = 'in'>
										<cfset icono = 'chevron-down'>
									</cfif>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">
												<a class="accordion-toggle btn btn-default" data-toggle="collapse" data-parent="##accordion" href="##collapse_#w#">
													Acceso: &nbsp;&nbsp;
													<div class="clearfix visible-xs-block"><br /></div>
													<span class="label label-default">#prc.informacion.ACCIONES.FECHA_PETICION[w]#</span>
												</a><i class="indicator glyphicon glyphicon-#icono#  pull-right"></i>
											</h4>
										</div>
										<div id="collapse_#w#" class="panel-collapse collapse #open#">
											<div class="panel-body">
												<div class="table-responsive">
													<table class="table table-hover">
														<tbody>
															<tr>
																<th class="text-left"><h6>M&eacute;todo del formulario:</h6></th>
																<td><h6>#prc.informacion.ACCIONES.METODO_FORMULARIO[w]#</h6></td>
															</tr>
															<tr>
																<th class="text-left"><h6>Tipo de contenido del formulario:</h6></th>
																<td><h6>#prc.informacion.ACCIONES.TIPO_CONTENIDO_FOMULARIO[w]#</h6></td>
															</tr>
															<tr>
																<th class="text-left"><h6>UR de referencia:</h6></th>
																<td><h6>#prc.informacion.ACCIONES.UR_REFERENCIA[w]#</h6></td>
															</tr>
															<tr>
																<th class="text-left"><h6>UR solicitada:</h6></th>
																<td><h6>#prc.informacion.ACCIONES.UR_SOLICITADA[w]#</h6></td>
															</tr>
															<cfif prc.informacion.ACCIONES.BAI_ACCION_PARAMETROS[w] NEQ "">
																<tr>
																	<th class="text-left"><h6>Par&aacute;metros:</h6></th>
																	<td><h6>#prc.informacion.ACCIONES.BAI_ACCION_PARAMETROS[w]#</h6></td>
																</tr>
															</cfif>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
								</cfloop>
							</div>
						</div>
					</div>
				</div>
			</cfif>
		</div>
	</div>
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