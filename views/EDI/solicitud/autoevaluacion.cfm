<cfprocessingdirective pageEncoding="utf-8">
<cfset totalAnios = (prc.PROCESO.getFECHAFINPROC() + 1) - prc.PROCESO.getFECHAINIPROC()>
<cfset totalActividades = 0>
<!--- <cfdump var="#prc.productos#" abort="false"> --->
<!--- <cfdump var="#structKeyList(prc.AUTOEVALUACION)#" abort="false"> --->

<style type="text/css">
	.hr-line-dashed {
		border-top: 1px dashed #00695c;
	}
	thead > tr > th {
		text-transform: uppercase;
		vertical-align: middle !important;
	}
	.h2{
		font-size: 24px;
	}
	a:hover{
		text-decoration: none;
		color: #fff;
	}
</style>

<div class="row">
	<div class="col-sm-12">
		<div class="tabs-container">
			<ul class="nav nav-tabs">
				<!--- <li class="active"><a data-toggle="tab" href="#tabAutoevaluacion" aria-expanded="true"> <i class="fa fa-check-square-o"></i> Autoevaluación </a></li>
				<li class=""><a data-toggle="tab" href="#tabDetallesAutoevaluacion" aria-expanded="false"><i class="fa fa-list"></i> Detalles </a></li> --->				
				<li class="active"><a data-toggle="tab" href="#tabDetallesAutoevaluacion" aria-expanded="false"><i class="fa fa-list"></i> Detalles </a></li>
			</ul>			
			<div class="tab-content">
				<!--- <div id="tabAutoevaluacion" class="tab-pane active"> --->
				<div id="tabAutoevaluacion" class="tab-pane">
					<div class="panel-body">
						<div class="row">
														
							
							<div class="col-sm-10 col-sm-offset-1">
							<!--- <div class="col-sm-12"> --->																	
								<div class="alert alert-warning text-center"><b>La información presentada carece de validez oficial para la asignación de nivel, solo es un ejercicio de autoevaluación.</b></div>
									
								<cfoutput>
										<cfloop array="#ListToArray(listSort(structKeyList(prc.AUTOEVALUACION),"numeric"))#" index="x">									
										<!--- <cfloop collection="#prc.AUTOEVALUACION#" item="x"> --->
										<cfif x LTE 3>
											<table id="tabla_#x#" class="table table-bordered table-hover text-center tablaAutoEvaluacion" data-toggle="table">
												<thead>
													<tr>
														<th class="text-center" colspan="#totalAnios+2#">#prc.AUTOEVALUACION[x]["ROMANO"]# - #prc.AUTOEVALUACION[x].NOMBRE#</th>
													</tr>
													<tr>
														<th class="text-center">Actividad</th>
														<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="i">
															<th class="text-center">#i#</th>
														</cfloop>
														<th class="text-center">PUNTOS</th>
													</tr>
												</thead>
												<tbody>
													<cfloop collection="#prc.AUTOEVALUACION[x]#" item="subclasificacion">
														<cfif compare(subclasificacion,"NOMBRE") NEQ 0 AND compare(subclasificacion,"PUNTAJECLASIFICACION") NEQ 0 AND compare(subclasificacion,"ROMANO") NEQ 0>
															<tr>
																<td>#prc.AUTOEVALUACION[x]["ROMANO"]#.#prc.AUTOEVALUACION[x][subclasificacion]["ROMANO"]#</td>
																<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="i">
																	<cfif structKeyExists(prc.AUTOEVALUACION[x][subclasificacion],i)>
																		<td>#prc.AUTOEVALUACION[x][subclasificacion][i]["PUNTAJE"]#</td>											
																	</cfif>
																</cfloop>
																<td>#prc.AUTOEVALUACION[x][subclasificacion]["PUNTAJESUBCLASIFICACION"]#</td>
															</tr>
														</cfif>
													</cfloop>
													<tr>
														<td class="text-right" colspan="#totalAnios+1#"><b>TOTAL</b></td>
														<td>#prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]#</td>
													</tr>
												</tbody>
											</table>
											<br>
											<div class="hr-line-dashed"></div>
											<br>
											<cfset totalActividades += prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]>
										<cfelseif x EQ 4>
											<table id="tabla_#x#" class="table table-bordered table-hover text-center tablaAutoEvaluacion" data-toggle="table">
												<thead>
													<tr>
														<th class="text-center" rowspan="2">20% DEL TOTAL DE LA SUMA DE I + II + III</th>
														<th class="text-center" colspan="2">#prc.AUTOEVALUACION[x]["ROMANO"]# - #prc.AUTOEVALUACION[x].NOMBRE#</th>
														<th class="text-center" rowspan="2">PUNTAJE EFECTIVO</th>
														<th class="text-center" rowspan="2">TOTAL</th>
													</tr>
													<tr>
														<th class="text-center">Actividad</th>
														<th class="text-center">PUNTOS</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<cfset suma = 0>
														<cfif structKeyExists(prc.AUTOEVALUACION,1)>
															<cfset suma += prc.AUTOEVALUACION[1]["PUNTAJECLASIFICACION"]>
														</cfif>
														<cfif structKeyExists(prc.AUTOEVALUACION,2)>
															<cfset suma += prc.AUTOEVALUACION[2]["PUNTAJECLASIFICACION"]>
														</cfif>
														<cfif structKeyExists(prc.AUTOEVALUACION,3)>
															<cfset suma += prc.AUTOEVALUACION[3]["PUNTAJECLASIFICACION"]>
														</cfif>
														<cfset suma *= 0.20>
														<td>#suma#</td>
														<td>#prc.AUTOEVALUACION[x]["ROMANO"]#</td>
														<td>#prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]#</td>
														<cfif prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"] GT suma >
															<td>#suma#</td>
															<td>#suma#</td>
															<cfset totalActividades += suma>
														<cfelse>								
															<td>#prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]#</td>
															<td>#prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]#</td>
															<cfset totalActividades += prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]>
														</cfif>																
													</tr>
												</tbody>
											</table>
											<br>
											<div class="hr-line-dashed"></div>
											<br>
										<cfelse>
											<table id="tabla_#x#" class="table table-bordered table-hover text-center tablaAutoEvaluacion" data-toggle="table">
												<thead>
													<tr>								
														<th class="text-center" colspan="2">#prc.AUTOEVALUACION[x]["ROMANO"]# - #prc.AUTOEVALUACION[x].NOMBRE#</th>								
													</tr>
													<tr>
														<th class="text-center">Actividad</th>
														<th class="text-center">PUNTOS</th>
													</tr>
												</thead>
												<tbody>
													<cfloop collection="#prc.AUTOEVALUACION[x]#" item="subclasificacion">
														<cfif compare(subclasificacion,"NOMBRE") NEQ 0 AND compare(subclasificacion,"PUNTAJECLASIFICACION") NEQ 0 AND compare(subclasificacion,"ROMANO") NEQ 0>
															<tr>
																<td>#prc.AUTOEVALUACION[x]["ROMANO"]#.#prc.AUTOEVALUACION[x][subclasificacion]["ROMANO"]#</td>
																<td>#prc.AUTOEVALUACION[x][subclasificacion]["PUNTAJESUBCLASIFICACION"]#</td>
															</tr>
															<tr>
																<td class="text-right"><b>TOTAL</b></td>
																<td>#prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]#</td>
															</tr>
														</cfif>								
													</cfloop>							
												</tbody>
											</table>
											<br>
											<div class="hr-line-dashed"></div>
											<br>
											<cfset totalActividades += prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]>
										</cfif>
									</cfloop>								
									<!--- <h1 class="bg-primary p-md text-right"><span class="fa fa-2x fa-check-square-o" style=" vertical-align: middle;"></span><b>&nbsp;&nbsp;TOTAL ACTIVIDADES: #totalActividades#</b></h1> --->
									<h1 class="bg-primary p-md b-r-md"><span class="fa fa-2x fa-check-square-o" style=" vertical-align: middle;"></span><b>&nbsp;&nbsp;PUNTAJE TOTAL DE ACTIVIDADES: #totalActividades#</b></h1>
								</cfoutput>
							</div>
						</div>										
					</div>
				</div>
				<!--- <div id="tabDetallesAutoevaluacion" class="tab-pane"> --->
				<div id="tabDetallesAutoevaluacion" class="tab-pane active">
				<div class="panel-body">
						<div class="row">
							
							<!--- <div class="alert alert-warning text-center"><b>La información mostrada puede no ser definitiva.</b></div> --->
							
							<div class="col-sm-10 col-sm-offset-1">
								<!--- <div class="col-sm-12"> --->		
								<!--- <button onclick="pdfAutoeval();">PDF</button>	 --->														
								<div class="alert alert-warning text-center"><b>La información presentada carece de validez oficial para la asignación de nivel, solo es un ejercicio de autoevaluación.</b></div>																	
								<button class="btn btn-danger  btn-rounded btn-outline btnFile pull-right" onclick="pdfAutoeval();">PDF <span class="fa fa-file-pdf-o"></span></button>
								<br>
								<br>
								<div id="detalle_productos">
									<ul id="agrupaciones" class="sortable-list connectList agile-list ui-sortable">
										<cfoutput>
											<cfloop array="#ListToArray(listSort(structKeyList(prc.AUTOEVALUACION),"numeric"))#" index="x">
												<li id="clasif_#x#">
													<div class="row">
														<div class="col-sm-11 text-center">
															<h3>#prc.AUTOEVALUACION[x]["ROMANO"]#.&nbsp;#prc.AUTOEVALUACION[x]["NOMBRE"]#</h3>															
														</div>
														<div class="col-sm-1 text-center">															
															<span class="btn btn-default pull-right fa fa-minus minimizarCategoria" data-abierto="1"></span>
														</div>														
													</div>		
													<div class="prodContainer">
														<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="anio">
															<div class="row">
																<div class="col-sm-12">								
																	<h3>#anio#:</h3>																							
																	<div id="clasif_#x#_#anio#" class="m-b m-b-md producto_anio">																							
																	</div>
																</div>
															</div>																
														</cfloop>			
													</div>
													<h4 class="bg-primary p-sm b-r-md"><span class="fa fa-check-square-o" style=" vertical-align: middle;"></span><b>&nbsp;&nbsp;PUNTAJE DE CLASIFICACIÓN : #prc.AUTOEVALUACION[x]["PUNTAJECLASIFICACION"]#</b></h4>																	
												</li>														
											</cfloop>
											<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="anio">
												<cfloop array="#prc.productos#" index="elem">
													<cfset producto = elem.REPORTE>
													<cfset ruta = elem.RUTA>
													<cfset filas = producto.getFilas()>
													<cfset encabezado = producto.getEncabezado()>
													<cfset columnas = encabezado.getColumnas()>
													<cfset pkReporte = producto.getPkReporte()>
													<cfset pkformato = producto.getPkTFormato()>	
																						
													<cfloop array="#producto.getFILAS()#" index="fila">
														<cfif fila.getANIO() EQ anio>
															<div class="panel panel-info producto" data-clasifnombre="#elem.RUTA[1]#" data-clasif="#fila.getCLASIFICACION()#" data-subclasif="#fila.getSUBCLASIFICACION()#" data-anio="#fila.getANIO()#">
																<div class="panel-heading text-white clearfix">																																							
																	<!--- <a class="fa fa-chevron-down pull-right"></a> --->
																	<span class="btn btn-default btn-xs pull-right fa fa-minus minimizarProducto" data-abierto="1"></span>													
																	#fila.getCLASIFICACION()#.#fila.getSUBCLASIFICACION()# - #arrayToList(ruta," / ")#																											
																</div>
																<div class="panel-body">
																	<div id="#fila.getPK_FILA()#_fila" >
																		<div class="label label-primary">Puntaje Máximo del Producto: #fila.getMAX_PUNTUACION()#</div>					
																		<br>
																		<br>
																		<div class="widget-text-box datos no-margins">
																			<table class="table table-hover no-margins">
																										 <thead>
																					<th colspan="2"><label class="control-label">Información General</label></th>
																				</thead>
																				<tbody>							
																					<cfloop  array="#columnas#" index="columna">
																					<tr>
																						<cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
																							<td>
																								<cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
																								<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:
																							</td>
																							<td>
																								<cftry>
																									<label class="control-label"><cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput></label>
																									<cfcatch>
																									</cfcatch>
																								</cftry>
																							</td>
																						</cfif>
																					</cfloop>
																					</tr>
																				</tbody>
																			</table>
																			<cfoutput>
																				<div class="row">
																				<table class="table table-hover no-margins">
																					<thead>
																						<th colspan="2">
																							<label class="control-label">Documentos Anexos</label>
																						</th>
																					</thead>
																					<tbody>
																					<cfloop  array="#columnas#" index="columna">
																						<tr>
																						<cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
																							<div class="col-sm-12">
																								<td><cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
																								<cfoutput>#columna.getNOM_COLUMNA()# </cfoutput>:</td>
																							</div>
																							<div class="col-sm-12">
																								<cftry>
																									
																								<cfif TRIM(fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()) EQ ''>
																									<td><small>	Sin Archivo Adjunto</small></td>
																								<cfelse>
																									<td>
																										<button class="btn btn-success btn-xs btn-rounded btn-outline btnFile pull-right" onclick="descargaComprobanteConsulta(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);"><small>Descargar</small> <span class="fa fa-download"></span></button>
																									</td>
																								</cfif>
																								
																									<cfcatch>
																										Dato no disponible
																									</cfcatch>
																								</cftry>
																								
																								
																								
																							</div>
																						</cfif>
																						</tr>
																					</cfloop>
																					</tbody>
																					</table>
																					
																				</div>																				
																			</cfoutput>																			
																		</div>																		
																	</div>																															
																</div>
															</div>
														</cfif>																							
													</cfloop>										
												</cfloop>
											</cfloop>
											<!--- <h1 class="bg-primary p-sm b-r-md"><span class="fa fa-check-square-o" style=" vertical-align: middle;"></span><b>&nbsp;&nbsp;PUNTAJE TOTAL DE ACTIVIDADES: #totalActividades#</b></h1> --->
										</cfoutput>
									</ul>
									<div id="clasif_productos">
										
									</div>									
									
								</div>

							</div>
						</div>										
					</div>
				</div>
			</div>
		</div>	
	</div>
</div>

<form id="downloadComprobanteInv" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="POST" target="_blank">
	<input type="hidden" id="pkCatFmtInv"		name="pkCatFmt">
	<input type="hidden" id="pkColDownInv"		name="pkColDown">
	<input type="hidden" id="pkFilaDownInv"		name="pkFilaDown">
</form>

<script>

	function ordenarProductos(selector){
		return $($(selector).toArray().sort((a,b) => {
      var clasifA = parseInt($(a).data('clasif'));
      var clasifB = parseInt($(b).data('clasif'));
      var subclasifA = parseInt($(a).data('subclasif'));
      var subclasifB = parseInt($(b).data('subclasif'));      
      return clasifA - clasifB || subclasifA - subclasifB;      
    }));		
	}

	function descargaComprobanteConsulta(pkformato, pkfila, pkcol){
		$("#pkColDownInv").val(pkcol);
		$("#pkFilaDownInv").val(pkfila);
		$("#pkCatFmtInv").val(pkformato);
		$('#downloadComprobanteInv').submit();
	}

	function pdfAutoeval(){
		window.open('/index.cfm/EDI/solicitud/autoevaluacionPDF');
	}

	$(function(){
		
		var productosOrdenados = ordenarProductos('.producto');
		var clasif_array = [];
		$.each(productosOrdenados,(indice,elemento) => clasif_array.push($(elemento).data('clasif')));
		clasif_array = clasif_array.filter((elemento,indice) => clasif_array.indexOf(elemento) == indice);				
		$.each(productosOrdenados,(indice,elemento) => {
			var clasificacion = $(elemento).data('clasif');
			var subclasificacion = $(elemento).data('subclasif');
			var clasificacionNombre = $(elemento).data('clasif');
			var anio = $(elemento).data('anio');
			$('#clasif_'+clasificacion+'_'+anio).append(elemento);
		});
		$.each($('.producto_anio'), (indice,elemento) => { 
				if(!$(elemento).find('.producto').length){
					$(elemento).parent().hide();					
				}	
		});

		<!--- debugger; --->

		$('.minimizarCategoria').click(function (e) { 
			var data_abierto = $(this).data('abierto');
			if(data_abierto){			
				$(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
				$(this).parent().parent().parent().find('.prodContainer').slideUp(300);
			}else{
				$(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
				$(this).parent().parent().parent().find('.prodContainer').slideDown(300);
			}	
		});


		$('.minimizarProducto').click(function (e) { 
			var data_abierto = $(this).data('abierto');
			if(data_abierto){			
				$(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
				$(this).parent().parent().find('.panel-body').slideUp(250);
			}else{
				$(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
				$(this).parent().parent().find('.panel-body').slideDown(250);
			}		
		});		
	});

</script>