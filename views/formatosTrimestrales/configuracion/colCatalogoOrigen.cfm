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
			<cfset informacion = prc.reporte.getInformacionGeneral()>
			<cfset columnaCatalogo = prc.columna.columna>
			<cfset columnas = encabezado.getColumnas()>
			<cfset informacion = prc.informacion>
			<cfset asociaciones = prc.asociaciones>			
			<!--- <cfdump var="#columnaCatalogo#" abort="true"> --->
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
												<cfif columna.getpk_columna() eq columnaCatalogo.getpk_columna()>
													<button class="btn btn-success btn-xs" data-pkdestino="#columnaCatalogo.getpk_columna()#" data-pkorigen="#columna.getpk_columna()#"><span class="fa fa-circle"></span></button>
												<cfelse>
													<cfif informacion.getpkCatalogoOrigen() eq columna.getpk_columna()>
														<!--- <cfset pkColCopiable = columnaCatalogo.getCOL_ORIGEN()> --->
														<button class="bt-eliminarColumnaOrigen btn btn-info btn-xs" data-pkdestino="#columnaCatalogo.getpk_columna()#" data-pkorigen="#columna.getpk_columna()#"><span class="fa fa-dot-circle-o"></span></button>
													<cfelse>
														<cfif columna.getType() eq 'dropdown'>
															<button class="bt-agregarColumnaOrigen btn btn-default btn-xs" data-pkdestino="#columnaCatalogo.getpk_columna()#" data-pkorigen="#columna.getpk_columna()#"><span class="fa fa-circle-o"></span></button>
														<cfelse>
															<button disabled class="btn btn-danger btn-xs" data-pkdestino="#columnaCatalogo.getpk_columna()#" data-pkorigen="#columna.getpk_columna()#"><span class="fa fa-ban"></span></button>
														</cfif>														
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
  				<div class="col-md-3"><button class="btn btn-success btn-xs" disabled><span class="fa fa-circle"></span></button> Indicador de celda actual</div>
  				<div class="col-md-3"><button class="btn btn-info btn-xs" disabled><span class="fa fa-dot-circle-o"></span></button> Indicador de celda origen que se ocupa para obtener informaci&oacute;n</div>
  				<div class="col-md-3"><button class="btn btn-default btn-xs" disabled><span class="fa fa-circle-o"></span></button> Indicador de celda sin usar</div>
  				<div class="col-md-3"><button class="btn btn-danger btn-xs" disabled><span class="fa fa-ban"></span></button> Indicador de celda sin catalogo</div>
			</div>
			<br>
			<h4>Seleccione una asociación entre éstos catálogos</h4>
			<div class="list-group" id="listaAsociaciones">								
				<cfif asociaciones.recordcount gt 0 >
					<cfloop query="#asociaciones#">
						<cfoutput>
							<cfif informacion.getpkAsociacion() eq asociaciones.CVE>
								<div class="list-group-item clearfix"><span class="elemento">#asociaciones.NOMBRE#</span>
									<span class="pull-right">
										<button onclick="quitarAsociacionCatalogos()" class="btn btn-xs btn-success eliminar">
											<span class="fa fa-check"></span> ASOCIACIÓN SELECCIONADA
										</button>
									</span>
								</div>
							<cfelse>
								<div class="list-group-item clearfix"><span class="elemento">#asociaciones.NOMBRE#</span>
									<span class="pull-right">
										<button onclick="seleccionarAsociacionCatalogos(#asociaciones.CVE#)" class="btn btn-xs btn-primary eliminar">
											<span class="fa fa-check"></span> SELECCIONAR
										</button>
									</span>
								</div>								
							</cfif>							
						</cfoutput>
					</cfloop>
				<cfelse>
					<p>Sin asociaciones disponibles</p>
				</cfif>
			</div>						
		</div>
	</div>	
</div>



<script>	

	function seleccionarAsociacionCatalogos(pkAsociacion){		
		$.ajax({
			type:"POST",
			async:false,
			url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.seleccionarAsociacionCatalogos")#</cfoutput>",
			data:{									
				pkFormato: <cfoutput>#informacion.getpkTFormato()#</cfoutput>,				
				pkAsociacion: pkAsociacion				
			},
			success:function(data){
				if(data > 0){
					toastr.success('Seleccionada','Asociacion');
				}
				else{
					toastr.error('En la actualización','Error');
				}
			}
		}); 
		catalogoOrigen();
 		cargarTablap3();	
	}

	function quitarAsociacionCatalogos(){
		$.ajax({
			type:"POST",
			async:false,
			url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.quitarAsociacionCatalogos")#</cfoutput>",
			data:{									
				pkFormato: <cfoutput>#informacion.getpkTFormato()#</cfoutput>,
			},
			success:function(data){
				if(data > 0){
					toastr.success('Deseleccionada','Asociacion');
				}
				else{
					toastr.error('En la actualización','Error');
				}
			}
		}); 
		catalogoOrigen();
 		cargarTablap3();
	}

	$(document).ready(function () {
		$('.bt-agregarColumnaOrigen').click(function(){			
			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.seleccionarColumnaOrigen")#</cfoutput>",
				data:{
					pkFormato: <cfoutput>#informacion.getpkTFormato()#</cfoutput>,							
					pkOrigen: $(this).data('pkorigen'),					
					pkDestino: $(this).data('pkdestino')				
				},
				success:function(data){
					if(data > 0){
						toastr.success('Agregada','Dependencia');
					}
					else{
						toastr.error('En la actualización','Error');
					}
				}
			}); 			
 			catalogoOrigen();
 			cargarTablap3();
 		});
 		
 		$('.bt-eliminarColumnaOrigen').click(function(){
 			$.ajax({
				type:"POST",
				async:false,
				url:"<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.quitarColumnaOrigen")#</cfoutput>",
				data:{									
					pkFormato: <cfoutput>#informacion.getpkTFormato()#</cfoutput>
				},
				success:function(data){
					if(data > 0){
						toastr.success('Eliminada','Dependencia');
					}
					else{
						toastr.error('En la actualización','Error');
					}
				}
			}); 			
 			catalogoOrigen();
 			cargarTablap3();
 		});
 	
	});
	
</script>