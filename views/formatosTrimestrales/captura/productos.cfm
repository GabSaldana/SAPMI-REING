
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<a class="botonAgregarProducto" href="productos/agregarProducto?pkproducto=<cfoutput>#prc.pkproducto#</cfoutput>">
				<button type="button" class="btn btn-default btn-outline dim btn-addNuevoProducto"><span class="glyphicon glyphicon-plus"></span> NUEVO PRODUCTO</button>		
			</a>
			<br>
			<div id="contenedorTabla" style="overflow:auto;">
				<input id="pkProductoPadre" type="hidden" value="<cfoutput>#prc.pkProducto#</cfoutput>">

				<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte">
					<cfset filas = prc.productos[numReporte].getFilas()>
					<cfset encabezado = prc.productos[numReporte].getEncabezado()>
					<cfset columnas = encabezado.getColumnas()>
					<cfset pkReporte = prc.productos[numReporte].getPkReporte()>
					<cfset pkformato = prc.productos[numReporte].getPkTFormato()>
					<cfset pkPeriodo = prc.productos[numReporte].getPkPeriodo()>

					<table id="tablaConsulta_<cfoutput>#prc.productos[numReporte].getPkTFormato()#</cfoutput>" class="table table-bordered table-hover" width="100%" data-search="true" data-pagination="false" data-page-size="15" data-row-style="rowStyle">
						<thead>
							<cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
								<cfif i lt encabezado.getniveles()+1>
									<tr class="azulSumaCol" style="background-color:#17c">
										<th align="center" class="text-center" rowspan="<cfoutput>#encabezado.getniveles()#</cfoutput>" data-field="Editar" data-events="actionEvents">
											Editar
										</th>
										<cfloop  array="#columnas#" index="columna">
											<cfif columna.getNivel() eq i>
											<th align="center" 
													val-pkcolumna="<cfoutput>#columna.getpk_columna()#</cfoutput>" 
													data-field="<cfoutput>#columna.getpk_columna()#</cfoutput>"
													class="<cfif columna.getTIPO_DATO() eq 5>azulSumaCol</cfif>"
													colspan="<cfoutput>#columna.gettotalHijosUltimoNivel()#</cfoutput>"
													>
												<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>
											</th>
											</cfif>
										</cfloop>
										<cfif i eq 1>
											<th align="center" val-pkcolumna="" rowspan="<cfoutput>#encabezado.getniveles()#</cfoutput>" data-field="PK_FILA">
												PK_FILA
											</th>
										</cfif>	
									</tr>
								</cfif>
							</cfloop>
						</thead>
					</table>
				</cfloop>
			</div>
		</div>
	</div>
</div>

<script>

	
	$(document).ready(function () {
		<cfloop from="1" to="#arrayLen(prc.productos)#" index="i">
			<cfset filas = prc.productos[i].getFilas()>
			<cfset encabezado = prc.productos[i].getEncabezado()>
			<cfset columnas = encabezado.getColumnas()>
			<cfset pkReporte = prc.productos[i].getPkReporte()>
			<cfset pkformato = prc.productos[i].getPkTFormato()>
			<cfset pkPeriodo = prc.productos[i].getPkPeriodo()>


			window.actionEvents = {
		        'click .editarFila': function (e, value, row, index) {
					$('#formularioLlenado').html('');
					$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.productosEdicion")#</cfoutput>', {
						formato: <cfoutput>#pkformato#</cfoutput>,
						periodo: <cfoutput>#pkPeriodo#</cfoutput>,
						reporte: <cfoutput>#pkReporte#</cfoutput>,
					}, function(data){
						$("#boxesContraparte").show();
						$("#divTabla").slideToggle( 1000,'easeOutExpo');
						$('#formularioLlenado').html(data);	
						$("#pkFila").val(row.PK_FILA);
						obtenerDatosFila(row.PK_FILA);
				    });
		        }
		    };

		 	var data = [<cfoutput>#prc.productos[i].getInformacionFinal()#</cfoutput>];
		 	<cfloop array="#columnas#" index="columna">
			 	for (var col = 0; col < data.length; col++){
					<cfif columna.getValidator() eq 'seleccionMultiple'>
						checkboxes = JSON.parse(data[col][<cfoutput>#columna.getData()#</cfoutput>]);
						data[col][<cfoutput>#columna.getData()#</cfoutput>] = '';
						for(var valores in checkboxes){
							if (checkboxes[valores]){
								data[col][<cfoutput>#columna.getData()#</cfoutput>] = data[col][<cfoutput>#columna.getData()#</cfoutput>] + valores + ', ';
							}					
						}
						data[col][<cfoutput>#columna.getData()#</cfoutput>] = data[col][<cfoutput>#columna.getData()#</cfoutput>].slice(0, -2).replace(/_/g," ");
					<cfelseif columna.getValidator() eq 'seleccionUnica'>
						radios = JSON.parse(data[col][<cfoutput>#columna.getData()#</cfoutput>]);
						for(var valores in radios){
							if (radios[valores]){
								data[col][<cfoutput>#columna.getData()#</cfoutput>] = valores;
							}					
						}
						data[col][<cfoutput>#columna.getData()#</cfoutput>] = data[col][<cfoutput>#columna.getData()#</cfoutput>].replace(/_/g," ");
					<cfelseif columna.getValidator() eq 'listaReordenable'>
						list = JSON.parse(data[col][<cfoutput>#columna.getData()#</cfoutput>]);
						data[col][<cfoutput>#columna.getData()#</cfoutput>] = '';
						for(var i = 0; i < list.length; i++){
							data[col][<cfoutput>#columna.getData()#</cfoutput>] = data[col][<cfoutput>#columna.getData()#</cfoutput>] + list[i].id + ', ';
						}
						data[col][<cfoutput>#columna.getData()#</cfoutput>] = data[col][<cfoutput>#columna.getData()#</cfoutput>].slice(0, -2).replace(/_/g," ");
					</cfif>
				}
			</cfloop>
		
			$("#tablaConsulta_<cfoutput>#prc.productos[i].getPkTFormato()#</cfoutput>").bootstrapTable({}); 
	        $('#tablaConsulta_<cfoutput>#prc.productos[i].getPkTFormato()#</cfoutput>').bootstrapTable('hideColumn', 'PK_FILA');
	        $("#tablaConsulta_<cfoutput>#prc.productos[i].getPkTFormato()#</cfoutput>").bootstrapTable('load', data); 
	        $("#tablaConsulta_<cfoutput>#prc.productos[i].getPkTFormato()#</cfoutput>").bootstrapTable('refreshOptions',{pagination:true}); 
		</cfloop>
	});

	<!---
	* Fecha      : Diciembre 2016
	* Autor      : Marco Torres
	* Descripcion: Aplica los estilos de las filas
	* --->
	function rowStyle(row, index) {
		if (row.PK_FILA == 'SUBTOTAL') {
			$("#labelVerSubTotales").show();
			$("#guiaVerSubTotales").show();
        	return {classes: 'azulSumaFil'};
    	} else if (row.PK_FILA == 'SUBTOTALSECCION') {
    		$("#labelVerSubSecciones").show();
    		$("#guiaVerSubSecciones").show();
        	return {classes: 'azulSumaSeccion'};
    	} else if (row.PK_FILA == 'TOTAL') {
    		$("#labelVerTotal").show();
    		$("#guiaVerTotal").show();
        	return {classes: 'azulSumaFilUltima'};
    	} else {
    		$("#labelVerDatos").show();
    		$("#guiaVerDatos").show();
    		row.Editar = '<button class="btn btn-xs btn-success editarFila" title="Editar Fila"><i class="fa fa-pencil-square"></i></button>'+
    			'<button class="btn btn-xs btn-danger eliminarFila" title="Eliminar Fila" style="display:none;"><i class="fa fa-minus"></i></button>';
    		return {classes: 'filaNormal'};
    	}
    	return {};
	}

</script>