<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<script type="text/javascript">
	colores = [];
	clases = ['red','yellow','green'];
</script>
<style type="text/css">
	/*Propuesta de colores*/
	.red{
		background: #F7B8B8;
	}
	.yellow{
		background: #FDFEB9;
	}
	.green{
		background: #C1F1B2;	
	}
</style>
<cfset index = 1>
<div class="row">
	<div class="col-md-12" id="solicitudSiAcDocentes" style="display: inline;">
		<div class="alert alert-success">
		    <span class="fa fa-check"></span> Usted cuenta con actividades docentes dentro del Instituto.
		</div>
	</div>
	<div class="col-md-12 noProcede" id="solicitudNoAcDocentes" style="display: inline;">
		<div class="alert alert-danger">
		    <span class="fa fa-times"></span> Usted aún <strong>No</strong> ha cargado actividades docentes dentro del Instituto.<br>
		    No puede participar en el programa.
		</div>
	</div>
	<div class="tab-container">
		<ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#tab-docentes">Actividades de Docencia</a></li>
            <li class=""><a data-toggle="tab" href="#tab-otrasAct">Actividades Alternas</a></li>
        </ul>
	    <div class="tab-content">
	    	<div class="tab-pane active" id="tab-docentes">
	    		<br>
				<div class="col-md-12">
					<label class="control-label">
						Contar con actividades docentes dentro del Instituto.
					</label>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-12">
								<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
									<cfset producto = prc.productos[numReporte].reporte>
									<cfset ruta =  prc.productos[numReporte].ruta>
									<cfset filas = producto.getFilas()>
									<cfset encabezado = producto.getEncabezado()>
									<cfset columnas = encabezado.getColumnas()>
									<cfset pkReporte = producto.getPkReporte()>
									<cfset pkformato = producto.getPkTFormato()>
									<cfset pkperiodo = producto.getPkPeriodo()>
									<cfset nombre = producto.getNombre()>
									
									<cfif arraylen(filas) GT 0>
										<cfloop array="#filas#" index="fila">
											<div class="col-lg-12 actDocente">
												<div class="widget-head-color-box lazur-bg p-sm text-center">
													<div class="row">
														<div class="col-md-11">
													<cfloop  from="1" to="#arraylen(ruta)#" index="rprod">
														<b><cfif rprod neq 1>/</cfif><cfoutput>#ruta[rprod]# </cfoutput></b>
													</cfloop>
													</div>
													<div class="text-right col-md-1">
														<cfoutput>
															<button class="btn text-right lazur-bg edit<cfoutput>#index#</cfoutput>" onclick="editarFila(#pkformato#,#pkPeriodo#,#pkReporte#,#fila.getPK_FILA()#);"><span class="fa fa-edit fa-lg"></span></button>
														</cfoutput>
													</div>
												</div>
											</div>
												<cfset  color = 1>
												<div class="widget-text-box infoGeneralDocencia<cfoutput>#index#</cfoutput>">
													<cfloop  array="#columnas#" index="columna">
														<cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
															<div class="row">
																<div class="col-sm-6">
																	<label class="control-label"><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</label>
																</div>
																<div class="col-sm-6">
																	<cftry>
																			<cfset value = fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()> 
																			<cfoutput>#value#</cfoutput>
																			<cfif Len(Trim(value)) EQ 0 AND columna.getrequerido() eq 'true'>
																				<cfset color = 0>
																			</cfif>
																		<cfcatch>
																			No se encontro la celda
																			<cfif columna.getrequerido() eq 'true'>
																				<cfset color = 0>
																			</cfif>
																		</cfcatch>
																	</cftry>
																</div>
															</div>
														</cfif>
													</cfloop>
													<cfoutput>
														<div class="row">
															<cfloop  array="#columnas#" index="columna">
																<cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
																	<div class="col-sm-12">
																		<label class="control-label"><cfoutput>#columna.getNOM_COLUMNA()# </cfoutput>:</label>
																	</div>
																	<cftry>													
																		<cfif TRIM(fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()) EQ ''>
																			<div class="col-sm-12"><small>	Sin Archivo Adjunto</small></div>
																			<cfif columna.getrequerido() eq 'true'>
																				<cfset color = 0>
																			</cfif>
																		<cfelse>
																			<div class="col-sm-12">
																		<button class="btn btn-white btn-rounded btnFile " onclick="descargaComprobanteConsulta(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);">
																			Descargar 
																			<span class="fa fa-download"></span>
																		</button>
																	</div>

																		</cfif>
																		<cfcatch>
																			No se encontro la celda
																			<cfif columna.getrequerido() eq 'true'>
																				<cfset color = 0>
																			</cfif>
																		</cfcatch>
																	</cftry>
																</cfif>
															</cfloop>
														</div>
													</cfoutput>
													<div class="text-right checkbox checkbox-primary">
														<input id="checkAcadem<cfoutput>#fila.getPK_FILA()#</cfoutput>" indice="<cfoutput>#index#</cfoutput>" periodo="<cfoutput>#pkPeriodo#</cfoutput>" formato="<cfoutput>#pkFormato#</cfoutput>" reporte="<cfoutput>#pkReporte#</cfoutput>" fila="<cfoutput>#fila.getPK_FILA()#</cfoutput>" cproducto="<cfoutput>#fila.getPK_CPRODUCTO()#</cfoutput>" class="fa-3x selectAcadem" type="checkbox" <cfif fila.getSELECCIONADO() EQ 1> checked estado = "1" color="2" <cfelse> color="<cfoutput>#color#</cfoutput>" estado = "0" </cfif>>
														<label for="checkAcadem<cfoutput>#fila.getPK_FILA()#</cfoutput>">
															Seleccionar
														</label>
													</div>
													<!--- <cfif fila.getSELECCIONADO() EQ 1>
														<cfset color = 2>
													</cfif> --->
												</div>
											</div>
											<cfset index = index + 1>
											<!--- <script type="text/javascript">
												valor = {
													index : <cfoutput>#index#</cfoutput>,
													color : <cfoutput>#color#</cfoutput>
													};
												colores.push(valor);
												<cfset index = index + 1>
											</script> --->
										</cfloop>
									</cfif>
								</cfloop>
							</div>
						</div>
					</div>
				</div>
			</div>
		    <div class="tab-pane" id="tab-otrasAct">
		    	<br>
				<div class="col-md-12">
					<label class="control-label">
						Coordinación o participación en comités tutoriales de alumnos de posgrado para el seguimiento de las actividades curriculares y tesis de alumnos del Instituto.
					</label>
				</div>
				<div class="form-group">
					<div class="row">
						<div class="col-sm-12">
							<div id="documentosComites"></div>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<label class="control-label">
						Impartición de seminarios de titulación, cursos de propósito específico de 21 horas o más, cursos de educación continua de 21 horas o más, o diplomados, registrados en la Secretaría, o en la Secretaría Académica o en la Coordinación General de Formación e Innovación Educativa.
					</label>
				</div>
				<div class="form-group">
					<div class="row">
						<div class="col-sm-12">
							<div id="documentosSeminarios"></div>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<label class="control-label">
						Asesoría a alumnos o personal académico en laboratorios de investigación por un mínimo de dos horas diarias.
					</label>
				</div>
				<div class="form-group">
					<div class="row">
						<div class="col-sm-12">
							<div id="documentosAsesorias"></div>
						</div>
					</div>
				</div>
		   	</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		documentosComites();
		documentosSeminarios();
		documentosAsesorias();
		existenActividadesAcademicas();
		pintaEstadoDoc();
	});

	function pintaEstadoDoc(){
		$('.selectAcadem').each(function(){
			$('.infoGeneralDocencia'+$(this).attr('indice')).addClass(clases[$(this).attr('color')]);
		});
		//var seleccionados = 0;
		// for(i = 0; i < colores.length; i++){
		// 	// if(colores[i].color == 2){
		// 	// 	seleccionados = seleccionados + 1;
		// 	// }
		// 	$('.infoGeneralDocencia'+colores[i].index).addClass(clases[colores[i].color]);
		// }
		/*Pinta el contador de productos seleccionados*/
		//$('.contProductos').text(seleccionados);
	}

	function existenActividadesAcademicas(){
		var estado = 0;
		if($(".selectAcadem:checked").length > 0 || $('#existe'+757).val() == 1 || $('#existe'+758).val() == 1 || $('#existe'+759).val() == 1 ){
			$('#solicitudSiAcDocentes').css('display', 'inline');
			$('#solicitudNoAcDocentes').css('display', 'none');
			estado = 2;
		} else {
			$('#solicitudNoAcDocentes').css('display', 'inline');
			$('#solicitudSiAcDocentes').css('display', 'none');
			estado = 0;
		}
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionActDocentes")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado: estado
		}, function(data){
			if(data.CONSULTA == 2){
				toastr.success('Usted tiene activiadades docentes');
			}
		});
	}

	$('body').undelegate('.selectAcadem', 'click');
	$('body').on('click', '.selectAcadem', function(){
		indice = $(this).attr('indice');
		pkFormato = $(this).attr('formato');
		pkReporte = $(this).attr('reporte');
		pkPeriodo = $(this).attr('periodo'); 
		pkFila = $(this).attr('fila');
		pkEstado = $(this).is(":checked")? 2:0;
		pkProducto = $(this).attr('cproducto');
		pkEstado = $(this).is(":checked")? 2:0;
		color = $(this).attr('color');
		if(color == 0){
				swal({
        			title: 'Aviso',
        			text: "Este producto no se puede seleccionar, ya que falta por capturar campos requeridos. \n ¿Desea capturarlos ahora?",
        			type: "warning",
        			showCancelButton: true,
        			confirmButtonText: "Si",
        			cancelButtonText: "No",
        			closeOnConfirm: true,
        			closeOnCancel: true
      				},
      				function(isConfirm){
        				if (isConfirm) {
          					editarFila(pkFormato,pkPeriodo,pkReporte,pkFila);
        				} else {
        					
        				}
      			});
				return false;
			}
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.addEvaluacionProducto")#</cfoutput>', {
			pkFila: pkFila,
			pkProducto: pkProducto,
			pkEstado:pkEstado
		}, function(data){
			if(data > 0){
				toastr.success('Se ha actualizado la información');
				if(color == 2){
						 $('.contProductos').text(Number($('.contProductos').text()) - 1);
						$('.infoGeneralDocencia'+indice).removeClass(clases[2]).addClass(clases[1]);
						$('#checkAcadem'+pkFila).attr('color','1');
						$('#checkInv'+pkFila).attr('color','1');
						indiceProd = $('.selectInvestigacion[fila="'+pkFila+'"]').attr('indice');
						$('.infoGeneral'+indiceProd).removeClass(clases[2]).addClass(clases[1]);
						$('#checkInv'+pkFila).prop( "checked", false );
						
						
					}else{
						 $('.contProductos').text(Number($('.contProductos').text()) + 1);
						$('.infoGeneralDocencia'+indice).removeClass(clases[1]).addClass(clases[2]);
						$('#checkAcadem'+pkFila).attr('color','2');
						$('#checkInv'+pkFila).attr('color','2');
						indiceProd = $('.selectInvestigacion[fila="'+pkFila+'"]').attr('indice');
						$('.infoGeneral'+indiceProd).removeClass(clases[1]).addClass(clases[2]);
						$('#checkInv'+pkFila).prop( "checked", true );
						
					}
			}

			else{
				toastr.error('Error en el servidor, intente más tarde');
				return false;
			}
		});
		existenActividadesAcademicas();
	});

	function documentosComites(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	757,
			requerido:	0,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#pkAspirante').val(),
			recargar:	'documentosComites();'
		}, function(data) {
			$("#documentosComites").html(data);
			$('.modal-backdrop').remove();
			addAspiranteRequisitoComites($('#existe'+757).val() == 0 ? 0 : 2);
		});
	}

	function documentosSeminarios(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	758,
			requerido:	0,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#pkAspirante').val(),
			recargar:	'documentosSeminarios();'
		}, function(data) {
			$("#documentosSeminarios").html(data);
			$('.modal-backdrop').remove();
			addAspiranteRequisitoSeminarios($('#existe'+758).val() == 0 ? 0 : 2);
		});
	}

	function documentosAsesorias(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	759,
			requerido:	0,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#pkAspirante').val(),
			recargar:	'documentosAsesorias();'
		}, function(data) {
			$("#documentosAsesorias").html(data);
			$('.modal-backdrop').remove();
			addAspiranteRequisitoAsesorias($('#existe'+759).val() == 0 ? 0 : 2);
		});
	}

	function addAspiranteRequisitoComites(estado){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionComites")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado:	estado
		}, function(data){
			existenActividadesAcademicas();
		});
	}
	
	function addAspiranteRequisitoSeminarios(estado){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionSeminarios")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado:	estado
		}, function(data){
			existenActividadesAcademicas();
		});
	}

	function addAspiranteRequisitoAsesorias(estado){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionAsesorias")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado:	estado
		}, function(data){
			existenActividadesAcademicas();
		});
	}

</script>