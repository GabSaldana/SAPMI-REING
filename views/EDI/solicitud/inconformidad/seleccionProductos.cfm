<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de registro de inconformidades
* Descripcion: Vista con la informacion de todos los registros
* Autor:       JLGC    
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<cfinclude template="seleccionProductos_js.cfm">
<style type="text/css">
    .content {
        height: 55vh !important;
    }
	thead > tr > th {
		text-transform: uppercase;
		vertical-align: middle !important;
	}
	.tablaResumenProductos th{
		text-align: center !important;
	}
	.tablaResumenProductos td, .tablaResumenProductos th{    
		vertical-align: middle !important;
	}
	td .panel {
		margin: 0px;
	}
	.producto_evaluado{    
		color: #FF6600;
	}
	@media (max-width : 720px) {
		.modal-lg{
		width: 95%;
	}    
</style>

<div class="container contenidoInconformidad" style="width:100%; padding: 0px;">

	<input id="inPkProducto"      type="hidden" value="0">
	<input id="inPkFila"          type="hidden" value="0">
	<input id="inSelection"       type="hidden" value="0">
    <input id="hElementSeleccion" type="hidden" value="0">

	<div class="wrapper wrapper-content animated fadeIn" style="width:100%; padding: 0px;">
	    <form id="formInconformidad" class="form-horizontal" role="form" onsubmit="return false;">
	        <h3>Selecccion de productos</h3>
	        <section style="width: 100%; background-color: #ffffff;">
	            <!--- INI SELECCION01 --->
				<div class="row">
	      			<cfset totElementos = 0>
	      			<ul id="agrupaciones" class="sortable-list connectList agile-list ui-sortable">
	              	<cfoutput>
	                <cfloop array="#ListToArray(listSort(structKeyList(prc.RESUMEN),"numeric"))#" index="x">
	                	<li id="clasif_#x#" style="list-style: none;">
	                	<div class="row">
	                    	<div class="col-sm-11 text-center">
	                        	<h3>#prc.RESUMEN[x]["ROMANO"]#.&nbsp;#prc.RESUMEN[x]["NOMBRE"]#</h3>
	                        </div>
	                        <div class="col-sm-1 text-center">                                                            
	                        	<span class="btn btn-default pull-right fa fa-minus minimizarCategoria" data-abierto="1"></span>
	                        </div>                                                        
	                    </div>
	                    <br>
	                    <div class="prodContainer">                          
	                    	<div class="row">
	                        	<div class="col-sm-12">               
	                            	<table id="tabla_#x#" class="table table-bordered text-center tablaResumenProductos" data-toggle="table">
	                            	<thead>
	                        		<tr>
										<cfloop query="#prc.tiposEvaluacion#">
											<cfif PK_TIPOEVALUACION EQ 3>
												<th style="width:60%;">Producto</th>
												<th>Año</th>
												<th>Evaluaciones #NOMBRE_TIPOEVALUACION#</th>
												<th style="max-width:25%;">Observaciones #NOMBRE_TIPOEVALUACION#</th>
												<th>Inconformar</th>
											</cfif>
										</cfloop>  
									</tr>
									</thead>
	                                <tbody id="tableBody_#x#">
	                                	<cfloop array="#prc.productos#" index="elem">
											<cfset producto   = elem.REPORTE>
											<cfset ruta       = elem.RUTA>
											<cfset filas      = producto.getFilas()>
											<cfset encabezado = producto.getEncabezado()>
											<cfset columnas   = encabezado.getColumnas()>
											<cfset pkReporte  = producto.getPkReporte()>
											<cfset pkformato  = producto.getPkTFormato()>  
	                    
											<cfloop array="#producto.getFILAS()#" index="fila">
												<cfif fila.getCLASIFICACION() EQ x>
	              
													<tr class="producto" data-clasifnombre="#elem.RUTA[1]#" data-clasif="#fila.getCLASIFICACION()#" data-subclasif="#fila.getSUBCLASIFICACION()#" data-anio="#fila.getANIO()#">
														<td class="text-left">
															<div class="panel panel-info">
																<div class="panel-heading text-white clearfix">
																	#fila.getCLASIFICACION_ROMANO()#.#fila.getSUBCLASIFICACION_ROMANO()# - #UCase(fila.getNombreProducto())#                         
																	<span class="btn btn-default btn-xs pull-right fa fa-plus minimizarProducto" data-abierto="0"></span>                                                 
														        </div>
																<div class="panel-body" style="display: none; padding: 0px">
																	<div id="#fila.getPK_FILA()#_fila">                                                    
																		<div class="widget-text-box datos no-margins" style="padding: 0px;">
																			
																			<table class="table table-hover no-margins">
																			<tbody> 
																			<tr>#arrayToList(ruta," / ")#</tr>                      
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
																				<div class="widget-text-box no-margins" style="padding: 0px;">
																					<table class="table table-hover no-margins">
																					<thead id="numDocs#fila.getPK_FILA()#">
																						<th colspan="2">
																							<label class="control-label">Documentos Anexos</label>
																						</th>
																					</thead>
																					<tbody>
																						<cfset totArch = 0>
																						<cfloop  array="#columnas#" index="columna">
																							<tr>
																								<cftry>  
																									<cfif TRIM(fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()) NEQ ''>

																										<cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
																											<cfset totArch = totArch + 1>
																											<div class="col-sm-12">
																												<td>
																													<cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
																													<cfoutput>#columna.getNOM_COLUMNA()# </cfoutput>:
																												</td>
																											</div>
																											<div class="col-sm-12">
																												<td>
																													<button class="btn btn-success btn-xs btn-rounded btn-outline btnFile pull-right" onclick="descargaComprobanteConsulta(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);"><small>Descargar</small> <span class="fa fa-download"></span></button>
																												</td>
																											</div>
																										</cfif>

																									</cfif>
																								<cfcatch>
																								Dato no disponible
																								</cfcatch>
																								</cftry>
																							</tr>
																						</cfloop>
																						<script>
																							if (#totArch# == 0) { $('##numDocs#fila.getPK_FILA()#').addClass('hide'); }
																						</script>
																					</tbody>
																					</table>                                        
																				</div>                                        
																			</cfoutput>                                                   
																		</div>                                                                      
																	</div>
																</div>
															</div>
														</td>   

														<!--- Si la fila(producto) corresponde a el proceso actual --->
														<cfif fila.getPROCESO() EQ prc.proceso.getPKPROCESO()>
															<cfset claseFila ="">
														<!--- Si NO corresponde al proceso actual --->
														<cfelse>
															<cfset claseFila ="producto_evaluado">
														</cfif>

														<td class="#claseFila#">
															#fila.getANIO()#
														</td>

														<cfset conEtapas= 0>
														<!--- <cfdump var = "#fila.getEVALUACION_ETAPAS()#" abort="true">	 --->
														<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="evaluacion">
															<cfif evaluacion.getFK_TIPO_EVALUACION() EQ 3>
																<cfif Len(evaluacion.getFECHA_CAPTURA())>
																	<cfif fila.getPKTPRODUCTOEDI() NEQ evaluacion.getFK_RECLASIFICACION() AND Len(evaluacion.getFK_RECLASIFICACION()) GT 0>
																		<td class="#claseFila#">#val(evaluacion.getPUNTAJE_OBTENIDO())#<span class="text-danger">*</span></td>                            
																	<cfelse>
																		<td class="#claseFila#">#val(evaluacion.getPUNTAJE_OBTENIDO())#</td>                            
																	</cfif>
																<cfelse>
																	<td class="#claseFila#">-</td>
																</cfif>
																<cfset conEtapas++>
															</cfif>
														</cfloop>

														<!--- <cfloop from="#conEtapas#" to="4" index="abd">
															<td class="#claseFila#"></td>
														</cfloop> --->

														<td class="text-justify #claseFila#">
															<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="evaluacion">
																<cfif evaluacion.getFK_TIPO_EVALUACION() EQ 3>
																	<cfif Len(evaluacion.getCOMENT_EVAL())>
																		<p>
																			<b>#evaluacion.getNOMBRE_TIPO_EVALUACION()#:</b>
																			#REReplace(evaluacion.getCOMENT_EVAL(), "<p>|</p>|<pre>|</pre>", "" , "all")#
																		</p>
																	</cfif>
																</cfif>
															</cfloop>
														</td>
														<td class="#claseFila#">
															<!--- INI CHECK INCONFORMAR --->
															<div class="checkbox checkbox-primary checkInconformar">
																<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="aInconformidad">
																	<cfif aInconformidad.getFK_TIPO_EVALUACION() EQ "4">
																		<cfset flagSeleccion = 2>
																	<cfelse>
																		<cfset flagSeleccion = 0>
																	</cfif>
																</cfloop>

				                                                <label for="checkInconf<cfoutput>#fila.getPK_FILA()#</cfoutput>" style="font-size: 2.5em">
				                                                <input id="checkInconf<cfoutput>#fila.getPK_FILA()#</cfoutput>" name="checkInconf<cfoutput>#fila.getPK_FILA()#</cfoutput>" 
				                                                    fila="<cfoutput>#fila.getPK_FILA()#</cfoutput>"
				                                                    evaluacionProductoEDI="<cfoutput>#fila.getEVALUACIONPRODUCTOEDI()#</cfoutput>"
				                                                    selectionInc="<cfoutput>#flagSeleccion#</cfoutput>" 
				                                                    class="fa-3x selectInconformidad checkbox-primary" 
				                                                    type="checkbox" <cfif flagSeleccion EQ 2> checked</cfif> >
				                                                <span class="cr"><i class="cr-icon fa fa-check"></i></span>
				                                                </label>
				                                                <input id="inPkProceso" type="hidden" value="<cfoutput>#fila.getPROCESO()#</cfoutput>">
				                                                <cfif flagSeleccion EQ 2>
				                                                    <cfset totElementos = totElementos + 1>
				                                                </cfif>
				                                            </div>
															<!--- FIN CHECK INCONFORMAR --->
														</td>
													</tr>
	                                        	</cfif>                                                                                                           
	                                    	</cfloop>                                    
										</cfloop>
									</tbody>
	                                </table>
	                            </div>
	                        </div>                                                                                          
	                    </div>
						</li>
					</cfloop>                   
					</cfoutput>
					</ul>       
	            </div>
				<script type="text/javascript">
	                elementosSeleccion(<cfoutput>#totElementos#</cfoutput>);
	            </script>
	            <!--- FIN SELECCION01 --->
	        </section>
	     
	        <h3>Narración de hechos</h3>
	        <section style="width: 100%; background-color: #ffffff;">
				<!--- INI SELECCION02 --->
	            <div class="row">
	                <div class="col-md-12">
	                    <div>
	                        <p><strong>Narración de los hechos</strong></p>
	                        <textarea id="inHechos" name="inHechos" class="form-control textarea" rows="5" placeholder="Solicitud al comité"></textarea>
	                    </div>
	                </div>
	                <div class="col-md-12">
	                    <br><p>"Si requiere adjuntar algún archivo no relacionado y distinto a los probatorios de los productos, lo puede hacer en este apartado"</p>
	                    <div id="otrosAdjuntosN"> </div>
	                    <div id="otrosAdjuntos" class="panel-group"> </div>                         
	                </div>
	            </div>
				<!--- FIN SELECCION02 --->
	        </section>
	    </form>
	</div>

</div>	

<form id="downloadComprobanteInv" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="POST" target="_blank">
    <input type="hidden" id="pkCatFmtInv"       name="pkCatFmt">
    <input type="hidden" id="pkColDownInv"      name="pkColDown">
    <input type="hidden" id="pkFilaDownInv"     name="pkFilaDown">
</form>

<div id="mdl-registroInconformidad" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 999999 !important;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 30px 30px 70px;">
                <button type="button" class="close CheckReresh" data-dismiss="modal" aria-hidden="true" style="margin-top: -10px;"><h1><strong>&times;</strong></h1></button>
                <h2 class="pull-left">Observación</h2>
            </div>
            <div class="modal-body">
                <textarea id="inComent" name="inComent"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default ml5 CheckReresh" class="close" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-success pull-right ml5" onclick="guardarInconformidad();">Guardar</button>
            </div>
        </div>
    </div>
</div>