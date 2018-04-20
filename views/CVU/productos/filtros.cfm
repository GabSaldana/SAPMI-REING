
<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU
* Sub modulo:  -
* Fecha:       17 de octubre de 2017
* Descripcion: Vista donde se puede revisar la informacion de todos los filtros aplicados a productos
* Autor:       
* ================================
----->
<cfprocessingdirective pageEncoding="utf-8">
<cfset total_records = prc.resultado.recordcount>

<style type="text/css">
.tarjetaFiltros{	
	box-shadow: 0px 3px 3px #888888;
	background-color: #00bfa5;
	border-color: #00bfa5;
	width: 100%;
	color: #FFF;
	height: auto;
	padding: 5px;

}

.tarjetaFiltros:hover {
	width: 100%;
	box-shadow: 0px 10px 8px #888888;
	color: #CFF;
}
</style>
<div class="row">
	<!--Aqui comienza el modulo de clasificaiones-->
	<cfloop index="i" from="1" to="#total_records#">
		<div class="contact-box primary tarjetaFiltro" id_filtro="<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>" revista="<cfoutput>#prc.resultado.REVISTAISSN[i]#</cfoutput>">	
			<a onclick="cargaSeleccion(<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>)"> 
				<div class="text-center">
					<h3>
						<strong> <cfoutput>#prc.resultado.FILTRO[i]#</cfoutput> </strong>
					</h3>	
				</div>
			</a>	
		</div>	
	</cfloop>
	<div class="contact-box primary tarjetaFiltros btn-addNuevoProducto guiaAgregarProducto" id="eleNuevo" onclick="capNuevoProducto(<cfoutput>#prc.resultado.PKFILTRO[total_records]#</cfoutput>, <cfoutput>#prc.resultado.REVISTAISSN[total_records]#</cfoutput>)">
		<div class="text-center">
			<h3>
				<span class="glyphicon glyphicon-plus"></span> NUEVO PRODUCTO
			</h3>
		</div>
	</div>
</div>

<script>

	$(document).ready(function() {
		
		$('.tarjetaFiltro').click(function(){
				cargaSeleccion($(this).attr('id_filtro'));
				cargahistorial($(this).attr('id_filtro'));				
				cargaTablaControl($(this).attr('id_filtro'), $(this).attr('revista'));				
				// cargaTabla($(this).attr('id_filtro'), $(this).attr('revista'));				
			}
		)
		
		$('#eleNuevo2').attr('onclick', $('#eleNuevo').attr('onclick'));
	});

</script>

				