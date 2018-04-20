<cfprocessingdirective pageEncoding="utf-8">
<div class="container" style="width:100%;">
	<div class="row">
		<div class="col-md-12">
			<br>
			<div id="contenedorTabla" >
				<input id="pkProductoPadre" type="hidden" value="<cfoutput>#prc.pkProducto#</cfoutput>">
				<ul class="agile-list">
					<cfset conteoProductos = 0>
					<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
						<cfset producto = prc.productos[numReporte].reporte>
						<cfset ruta =  prc.productos[numReporte].ruta>
						<cfset filas = producto.getFilas()>
						<cfset encabezado = producto.getEncabezado()>
						<cfset columnas = encabezado.getColumnas()>
						<cfset pkReporte = producto.getPkReporte()>
						<cfset pkformato = producto.getPkTFormato()>
						<cfset pkPeriodo = producto.getPkPeriodo()>
						<cfset conteoProductos = conteoProductos + arraylen(filas)><!--- para contar los productos capturados en esta seleccion --->
						<cfif arraylen(filas) GT 0>
							<li class="success-element">
								<div class="row">
									<div class="col-sm-12" >
									<button class="btn btn-white cierra-lista"><span class="fa fa-minus"></span></button>
									<cfloop array="#ruta#" index="rprod">
										<span class="label label-primary guiaRuta" style="font-size:15px;"><cfoutput>#rprod#</cfoutput></span>
									</cfloop>
									</br>
									</br>
									</div>
								</div>
								<div class="lista-productos">
									<ul class="agile-list">
										<cfloop array="#filas#" index="fila">
											<li class="info-element productosBusqueda" id="fila<cfoutput>#fila.getPK_FILA()#</cfoutput>" >
												<div class="row">
													<cfloop  array="#columnas#" index="columna">
														<cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
															<div class="col-xs-6 col-sm-4 col-md-3">
																	<cfoutput><small>#columna.getNOM_COLUMNA()#:</small></cfoutput>
																	<cftry>
																		<label class="control-label"><cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput></label>
																	<cfcatch>
																		Dato no disponible
																	</cfcatch>
																</cftry>
															</div>
														</cfif>
													</cfloop>
												</div>
							
												<div class="row">
													<div class="col-sm-5">
														<cfoutput>
														<hr>
															<table class="table table-hover no-margins">
                                            					<thead>
																	<th colspan="2">
																		<label class="control-label">Documentos Anexos</label>
																	</th>
																</thead>
																<tbody>
													
								                                <cfloop  array="#columnas#" index="columna">
																	<cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
																		<tr>
								                            				<td>
								                            					<small><cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:</small>
																			</td>
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
																	</cfif>
																</cfloop>
									                        
					                                            </tbody>
					                                        </table>
														</cfoutput>
													</div>
													
													<div class="col-sm-7">
														<cfoutput>
														<div class="pull-right" style="margin-top:140px;">
															<cfif fila.getTPP_EVALUADO() neq 0>
																<span class="badge badge-warning">Producto evaluado</span>
															<cfelse>
																<button class="btn btn-primary guiaEditProd" onclick="editarFila(#pkformato#,#pkPeriodo#,#pkReporte#,#fila.getPK_FILA()#);">Editar <span class="fa fa-edit"></span></button>
																<cfif fila.getPRODUCTO_ELIMINAR() eq 0 || fila.getPRODUCTO_ELIMINAR() eq '' >
																	<button class="btn btn-danger" onclick="eliminarFila(#fila.getPK_FILA()#);">Eliminar <span class="fa fa-trash"></span></button>
																</cfif>
															</cfif>
														</div>	
														</cfoutput>
													</div>
												</div>
											</li>
										</cfloop>		
									</ul>
								</div>
							</li>
						</cfif>
					</cfloop>
				</ul>
				<cfif conteoProductos EQ 0>
					<div style="padding_top:200px;">
						<h3>No se encontraron productos capturados en esta sección</h3>
					</div>
				</cfif>
					
			</div>
		</div>
	</div>
</div>

<form id="downloadComprobante" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="get" target="_blank">
    <input type="hidden" id="pkCatFmt2"   name="pkCatFmt">
    <input type="hidden" id="pkColDown"  name="pkColDown">
    <input type="hidden" id="pkFilaDown" name="pkFilaDown">
</form>

<script>
	$(document).ready(function () {
		$('.cierra-lista').click(function(){
			$(this).children().toggleClass('fa-minus').toggleClass('fa-plus');
			$(this).parent().parent().siblings('.lista-productos').slideToggle( 1000,'easeOutExpo');
		});
		
		$('.cierra-listasT').click(function(){
			$(this).children().toggleClass('fa-minus').toggleClass('fa-plus');
			$('.lista-productos').slideToggle( 1000,'easeOutExpo');
			$('.cierra-lista').children().toggleClass('fa-minus').toggleClass('fa-plus');
		});
		$('.btn-addNuevoProducto').attr('onclick', 'capNuevoProducto(<cfoutput>#prc.pkproducto#</cfoutput>, <cfoutput>#prc.revistaissn#</cfoutput>);');
	});

	function editarFila (formato, periodo, reporte,pkfila) {
		$('#formularioLlenado').html('');
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.productosEdicion")#</cfoutput>', {
			formato: formato,
			periodo: periodo,
			reporte: reporte,
		}, function(data){
			$("#boxesContraparte").show();
			$("#divTabla").slideToggle( 1000,'easeOutExpo');
			$('#formularioLlenado').html(data);	
			$("#pkFila").val(pkfila);
			obtenerDatosFila(pkfila);
		});
    }

    function eliminarFila(pkFila) {
    	swal({
			title:              "ELIMINAR producto",
			text:				"NO es posible recuperar los productos eliminados.",
			type:               "error",
			confirmButtonText:  "Aceptar",
			cancelButtonText:   "Cerrar",
			showCancelButton:   true,
			closeOnConfirm:     true,
		}, function () {
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.eliminarProducto")#</cfoutput>', {
				pkFila: pkFila
			}, function(data){
				if(data > 0 )
					$("#fila"+pkFila).remove();
				else
					toastr.error("Error al borrar el producto.");
			});
		});
    }
    
	<!---
    * Fecha : Noviembre de 2017
    * Autor : Marco Torres
    * Comentario: descarga los archivos.
    --->
    function descargaComprobanteConsulta(pkformato, pkfila, pkcol){
    	$("#pkColDown").val(pkcol);
    	$("#pkFilaDown").val(pkfila);
    	$("#pkCatFmt2").val(pkformato);
    	$('#downloadComprobante').submit();
    }
	
	function busquedaInv(){
		var tex = $('#buscar_inv').val();
		$('.productosBusqueda').hide();
		$('.productosBusqueda').each(function(){
			if(tex == '')
				$('.productosBusqueda').show();
			else if($(this).text().toUpperCase().indexOf(tex.toUpperCase()) != -1){
		    	$(this).show();
		   	}
		});
  	}
	
</script>