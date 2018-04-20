
<cfprocessingdirective pageEncoding="utf-8">
<cfset total_records = prc.opcionesProductos.recordcount>

	<cfset i=0>
	<!--Size = 3 para desktops, Size = 2 para moviles-->
	<cfset size=3>
	<cfset number_of_rows = ceiling(total_records / size)  >
<div>	
	<cfloop index="current" from="1" to="#number_of_rows#" >
		<div class="row" id="opcionProductos" style="padding:0px;">
			<cfloop index="x" from= "#i+1#" to="#i+size#" step="1">
				<cfif prc.opcionesProductos.PRODUCTO[x] neq "">

						<div class="col-md-4 col-xs-6" style="padding:3px;padding_bottom:0px;">

							<div class="tarjetaProducto tarjetaProductoSel" id_prod="<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" revista="<cfoutput>#prc.opcionesProductos.REVISTAISSN[x]#</cfoutput>" style="padding_bottom:0px;">			
								<div class="text-center textoseleccion">
										<div  class="text-center">
												<strong> <cfoutput>#prc.opcionesProductos.PRODUCTO[x]#</cfoutput> </strong>											
										</div>
										<!--div >
											<div class="col-md-2 col-xs-2 pull-right" > 
												<div class="outter "><i class="fa <cfoutput>#prc.opcionesProductos.ICONO[x]#</cfoutput> image-circle"></i></div>   
											</div> 	
										</div-->
								</div>	
								
								<div class= "descProducto" align="center"> 
									<p>
										<cfoutput>#prc.opcionesProductos.DESCRIPCION[x]#</cfoutput>
									</p>
								</div>	
							</div>
						</div>
				</cfif>
				<cfset i=x>
			</cfloop>
		</div>		
	</cfloop>
	
</div>	
<script>

	$(document).ready(function() {		
		$("#revistaIssn").hide();

		$('.tarjetaProductoSel').click(function(){						
					cargaSeleccion($(this).attr('id_prod'));
					cargahistorial($(this).attr('id_prod'));
					cargaTabla($(this).attr('id_prod'),$(this).attr('revista'));				
		});


		$("#btn-issn").click(function(){		
			$.post('<cfoutput>#event.buildLink("CVU.productos.traeTipoRevista")#</cfoutput>', {
				issn: document.getElementById("issn").value
				}, 
				function(data){
					if(data==0){		
						alert('El valor ISSN no se encuentra');
					}
					else{
						cargaSeleccion(data);			
					}	
				}
	    	);	
			
		});
	
	});

</script>