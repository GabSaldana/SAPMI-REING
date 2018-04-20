<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU
* Sub modulo:  -
* Fecha:       17 de octubre de 2017
* Descripcion: Vista donde se puede revisar la informacion de todos los productos
* Autor:       
* ================================
----->
<cfprocessingdirective pageEncoding="utf-8">
<cfset total_records = prc.resultado.recordcount>

<div class="row">
	
	<div id="clasificaciones" class="col-md-4 col-xs-12">
	<!--Aqui comienza el modulo de clasificaiones-->
		<cfloop index="x" from="1" to="#total_records#">
				<div class="tarjetaClasificacion" id_clasificacion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" revista="<cfoutput>#prc.resultado.REVISTAISSN[x]#</cfoutput>">				
					<div class="row">
						<div class="col-md-3 pull-left ">
							<div id="icon">
								<div class="outter "><i class="fa <cfoutput>#prc.resultado.ICONO[x]#</cfoutput> image-circle"></i></div> 	
							</div>
						</div>
						<div class="col-md-9 ">
							<div id="textoClasificacion">
								<p><cfoutput>#prc.resultado.CLASIFICACION[x]#</cfoutput></p>
							</div>
						</div>
					</div>
				</div>	
		</cfloop>
	</div>

	<div id= "descripciones" class="col-md-8 col-xs-12">
		<cfloop index="x" from="1" to="#total_records#">
				<div class="descripcion" id_descripcion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" style="display:none;">				
						<div class="text-center textoClasificacion">
							<div class="center">
								<h2>Actividades relacionadas con:</h2>
								<ul class="list-group clear-list m-t">
		                            <h3><cfoutput>#prc.resultado.DESCRIPCION[x]#</cfoutput></h3>	
							    </ul>
							</div>
						</div>	
					</div>	
			</cfloop>
		</div>
	</div>
	
	
	<script>
	
		$(document).ready(function() {
			
			$('.tarjetaClasificacion').click(function(){
					$('#clasdesc').css('display', 'none');
					cargaSeleccion($(this).attr('id_clasificacion'));
					cargahistorial($(this).attr('id_clasificacion'));
					cargaTabla($(this).attr('id_clasificacion'), 0);				
			});
	
			$('.tarjetaClasificacion').mouseenter(function(){
	
				id= $(this).attr('id_clasificacion');
				//alert(id);
				selector = 'div[id_descripcion=' + id + ']';
				$(selector).css('display', '');
			});
	
			$('.tarjetaClasificacion').mouseleave(function(){
	
				id= $(this).attr('id_clasificacion');
				//alert(id);
				selector = 'div[id_descripcion=' + id + ']';
				$(selector).css('display', 'none');
			});
	
		});
	
	
	</script>