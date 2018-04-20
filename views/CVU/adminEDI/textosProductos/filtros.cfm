<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU edicion productos (copia menu CVU)
* Sub modulo:  -
* Fecha:       04 de diciembre de 2017
* Descripcion: Vista donde se puede revisar la informacion de todos los filtros aplicados a productos
* Autor:       JLGC
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8">
<cfset total_records = prc.resultado.recordcount>

<div class="row">
	<!--Aqui comienza el modulo de clasificaiones-->
	<cfloop index="i" from="1" to="#total_records#">
		<div>	
			<div class="text-center primary tarjetaFiltro">
				<div class="text-center filtroProducto" id_filtro="<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>">

					<div class="text-center tarjetaFiltroNomSel tarjetaFiltroNomSel<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>" id_filtro="<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>">
						<a style="color: #000000; text-decoration: underline; font-weight: bold"><h3><cfoutput>#prc.resultado.FILTRO[i]#</cfoutput></h3></a>
					</div>

					<div class="input-group text-center tarjetaFiltroNomTxt<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput> hide" id_filtro="<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>">
                        <input type="text" id="productoNombre<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>" name="productoNombre<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>" class="form-control" maxlength="300" value="<cfoutput>#prc.resultado.FILTRO[i]#</cfoutput>" style="color: #000000; text-transform: none;">
						<span class="input-group-btn">
							<button type="button" class="btn btn-success" onclick="guardarProductoNombre(<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>);"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
						</span>
					</div>

				</div>	
				<div>
					<button type="button" class="btn btn-circle btn-success botonFiltrosProdNom hide" id_filtro="<cfoutput>#prc.resultado.PKFILTRO[i]#</cfoutput>" data-toggle="tooltip" title="Editar nombre del producto">
			            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			        </button>
				</div>	
			</div>
			<p>
		</div>	
	</cfloop>
</div>

<script>
	$(document).ready(function() {
		
		$('.tarjetaFiltroNomSel').click(function(){
			cargaSeleccion($(this).attr('id_filtro'));
			cargahistorial($(this).attr('id_filtro'));
			$("#inPkProductoOrigen").val($(this).attr('id_filtro'));
		});

		$('.botonFiltrosProdNom').click(function(){	
			$(".tarjetaFiltroNomSel"+$(this).attr('id_filtro')).toggleClass('hide');
			$(".tarjetaFiltroNomTxt"+$(this).attr('id_filtro')).toggleClass('hide');
		});
	});
</script>

				