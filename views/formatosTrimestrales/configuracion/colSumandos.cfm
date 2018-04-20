<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:    
* Descripcion:	
* Autor: 
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<div class="container">
	<div class="row">
		<div class="col-md-12" id="guardar" style=" " >
			<cfset encabezado = prc.reporte.getEncabezado()>
			<!--- <CFDUMP VAR="#encabezado#" abort="TRUE"> --->
			<cfset columnaSumable  = prc.columna.columna>
			<cfset columnas = encabezado.getColumnas()>
			<div style="overflow-x: auto">
				<table class="table table-bordered" >
					<cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
						<cfif i lt encabezado.getniveles()+1>
							<tr style="background-color:#1c84c6; color:#fff">
								<cfloop  array="#columnas#" index="columna">
									<cfif columna.getNivel() eq i>
										<cfoutput>
											<td align="center" colspan="#columna.gettotalHijosUltimoNivel()#">
											&nbsp;&nbsp;#columna.getNOM_COLUMNA()#&nbsp;&nbsp;
											</td>
										</cfoutput>
									</cfif>
								</cfloop>
							</tr>
						<cfelse>
							<tr>
								<cfloop  array="#columnas#" index="columna">
									<cfif columna.getNivel()+1 eq i>
										<cfoutput>
											<td align="center" colspan="#columna.gettotalHijosUltimoNivel()#">
												<cfif columna.getpk_columna() eq columnaSumable.getpk_columna()>
													<button class="btn btn-success btn-xs" data-pkdest="#columnaSumable.getpk_columna()#"  data-pkcol="#columna.getpk_columna()#"><span class="fa fa-check-circle"></span></button>
												<cfelse>
												    <cfset colsum = arrayfind(columnaSumable.getsumandos(),columna.getpk_columna())>
													<cfif colsum  NEQ 0 >
														<cfset arrOperando = columnaSumable.getoperandos()>
														<cfif arrOperando[colsum] EQ 1> 
															<button class="bt-eliminarSumando btn btn-info btn-xs" data-pkdest="#columnaSumable.getpk_columna()#"  data-pkcol="#columna.getpk_columna()#"><span class="fa fa-plus"></span></button>												
														<cfelse>
															<button class="bt-eliminarResta btn btn-info btn-xs" data-pkdest="#columnaSumable.getpk_columna()#"  data-pkcol="#columna.getpk_columna()#"><span class="fa fa-minus"></span></button>
														</cfif>
													<cfelse>
														<button class="bt-agregarSumando btn btn-default btn-xs" data-pkdest="#columnaSumable.getpk_columna()#"  data-pkcol="#columna.getpk_columna()#"><span class="fa fa-circle-o"></span></button>												
													</cfif>
												</cfif>
											</td>
										</cfoutput>
									</cfif>
								</cfloop>
							</tr>
						</cfif>
					</cfloop>
				</table>
			</div>
			<br>
			<div class="alert alert-info row">
  				<strong>Info!</strong><br>
  				<div class="col-md-3"><button class="btn btn-info btn-xs" disabled><span class="fa fa-plus"></span></button> Indicador de celdas a sumar usadas para obtener la sumatoria de la celda actual</div>  
  				<div class="col-md-3"><button class="btn btn-info btn-xs" disabled><span class="fa fa fa-minus"></span></button> Indicador de celdas a restar usadas para obtener la sumatoria de la celda actual</div>
				<div class="col-md-3"><button class="btn btn-success btn-xs" disabled><span class="fa fa-check-circle"></span></button> Indicador de celda actual</div>
  				<div class="col-md-3"><button class="btn btn-default btn-xs" disabled><span class="fa fa-circle-o"></span></button> Indicador de celda sin usar</div>			  			
			</div>
		</div>
	</div>
	
</div>



<script>	
	$(document).ready(function () {
		$('.bt-agregarSumando').click(function(){
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.registrarOperando")#</cfoutput>",
				data:{									
					pkColumna: $(this).data('pkcol'),					
					pkDestino: $(this).data('pkdest'),
					operacion: 1
				},
				success:function(data){
					if(data > 0){
						toastr.success('Agregado','Sumando');
					}
					else{
						toastr.error('En la actualización','Error');
					}
				}
			}); 			
 			verSumandos();
 			cargarTablap3();
 		});
 		
 		$('.bt-eliminarSumando').click(function(){ 			
 			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.actualizarOperando")#</cfoutput>",
				data:{									
					pkColumna: $(this).data('pkcol'),					
					pkDestino: $(this).data('pkdest'),
					operacion: 2
				},
				success:function(data){
					if(data > 0){
						toastr.success('Agregado','Resta');
					}
					else{
						toastr.error('En la actualización','Error');
					}
				}
			}); 			
 			verSumandos();
 			cargarTablap3();
 		});
 		
 		 $('.bt-eliminarResta').click(function(){ 			
 			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.eliminarOperando")#</cfoutput>",
				data:{									
					pkColumna: $(this).data('pkcol'),					
					pkDestino: $(this).data('pkdest')					
				},
				success:function(data){
					if(data > 0){
						toastr.success('Eliminado','Sumando');
					}
					else{
						toastr.error('En la actualización','Error');
					}
				}
			}); 			
 			verSumandos();
 			cargarTablap3();
 		});

	});
	
</script>
