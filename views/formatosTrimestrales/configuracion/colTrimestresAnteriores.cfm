<div class="container" >
	<div class="row">
		<div class="col-md-12" id="guardar">
			<label hidden for="inTipoColumna">Trimestre Copiable: </label>  
			<select hidden id="trimCopiable">
				<option selected value="1" >Trimestre Anterior</option>
				<option value="2" >Dos Trimestres Atras</option>
				<option value="4" >A&ntilde;o Anterior</option>
			</select>
			<br>
			<!--- <br> --->
			<cfset encabezado = prc.reporte.getEncabezado()>
			<cfset columnaCopiable  = prc.columna.columna>
			<cfset columnas = encabezado.getColumnas()>
			<cfset pkColCopiable = 0>
			<div style="overflow-x:auto">
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
								<cfoutput>
									<cfloop array="#columnas#" index="columna">
										<cfif columna.getNivel()+1 eq i>
											<td align="center" colspan="#columna.gettotalHijosUltimoNivel()#">
												<cfif columna.getpk_columna() eq columnaCopiable.getpk_columna()>
													<button class="btn btn-success btn-xs" val-pkColumna="#columnaCopiable.getpk_columna()#" val-pkOrigen="#columna.getpk_columna()#"><span class="fa fa-circle"></span></button>
												<cfelse>
													<cfif columnaCopiable.getCOL_ORIGEN() eq columna.getpk_columna()>
														<cfset pkColCopiable = columnaCopiable.getCOL_ORIGEN()>
														<button class="bt-eliminarColumna btn btn-info btn-xs" val-pkColumna="#columnaCopiable.getpk_columna()#" val-pkOrigen="#columna.getpk_columna()#"><span class="fa fa-dot-circle-o"></span></button>
													<cfelse>
														<button class="bt-agregarColumna btn btn-default btn-xs" val-pkColumna="#columnaCopiable.getpk_columna()#" val-pkOrigen="#columna.getpk_columna()#"><span class="fa fa-circle-o"></span></button>
													</cfif>
												</cfif>
											</td>
										</cfif>
									</cfloop>
									<input type="hidden" id="pkColCopiable" value="#pkColCopiable#">
								</cfoutput>
							</tr>
						</cfif>
					</cfloop>
				</table>
			</div>
			<br>
			<div class="alert alert-info row">
  				<strong>Info!</strong><br>
  				<div class="col-md-4"><button class="btn btn-success btn-xs" disabled><span class="fa fa-circle"></span></button> Indicador de celda actual</div>
  				<div class="col-md-4"><button class="btn btn-info btn-xs" disabled><span class="fa fa-dot-circle-o"></span></button> Indicador de celda origen que se ocupa para obtener informaci&oacute;n</div>
  				<div class="col-md-4"><button class="btn btn-default btn-xs" disabled><span class="fa fa-circle-o"></span></button> Indicador de celda sin usar</div>
			</div>
		</div>
	</div>
</div>

<script>	
	$(document).ready(function () {
		$('.bt-agregarColumna').click(function(){
			if ($("#pkColCopiable").val() == 0){
				var pkColumna = $(this).attr("val-pkColumna");
				var pkColOrigen = $(this).attr("val-pkOrigen");
				agregraColumna(pkColOrigen, pkColumna);
			} else if ($("#pkColCopiable").val() > 0){
				toastr.warning('columna marcada','Ya existe una');
			}
 		});
 		$('.bt-eliminarColumna').click(function(){
 			var pkColumna = $(this).attr("val-pkColumna");
 			eliminarColumna(pkColumna);
 		});
	});	
</script>
