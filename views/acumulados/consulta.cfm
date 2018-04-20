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
<cfset filas = prc.reporte.getreportes()[1].getFilas()>
<cfset encabezado = prc.reporte.getreportes()[1].getEncabezado()>
<cfset columnas = encabezado.getColumnas()>
<!--- <cfdump var="#encabezado#">
<cfabort>  --->
<script language="javascript" src="/includes/bootstrap/bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script language="javascript" src="../../../includes/bootstrap/bootstrap-table/extensions/export/tableExport.js"></script>
<style>
.azulSumaCol{
}
.azulSumaFil{
}.azulSumaSeccion{
}
.azulSumaFilUltima{
}
</style>

<div class="container" >
	<!--- <div class="row">
		<div class="col-md-12" id="guardar" style="overflow-x:auto;">
			<div class="form-group">
				<table class="pull-left">
					<tr>
				    	<td><label id="labelVerDatos" style="margin-left:20px;display:none;">Ver Datos:</label></td>
				    	<td><div id="guiaVerDatos" class="onoffswitch" style="margin-left:20px;display:none;">
	                        <input type="checkbox" class="onoffswitch-checkbox" id="verDatos" checked>
	                        <label class="onoffswitch-label" for="verDatos">
	                            <span class="onoffswitch-inner"></span>
	                            <span class="onoffswitch-switch"></span>
	                        </label>
		                </div></td>
		                <td><label id="labelVerSubSecciones" style="margin-left:20px;display:none;">Ver SubSecciones:</label></td>
				    	<td><div id="guiaVerSubSecciones" class="onoffswitch" style="margin-left:20px;display:none;">
	                        <input type="checkbox" class="onoffswitch-checkbox" id="verSubSecciones" checked>
	                        <label class="onoffswitch-label" for="verSubSecciones">
	                            <span class="onoffswitch-inner"></span>
	                            <span class="onoffswitch-switch"></span>
	                        </label>
		                </div></td>
				    	<td><label id="labelVerSubTotales" style="margin-left:20px;display:none;">Ver SubTotales:</label></td>
				    	<td><div id="guiaVerSubTotales" class="onoffswitch" style="margin-left:20px;display:none;">
	                        <input type="checkbox" class="onoffswitch-checkbox" id="verSubTotales" checked>
	                        <label class="onoffswitch-label" for="verSubTotales">
	                            <span class="onoffswitch-inner"></span>
	                            <span class="onoffswitch-switch"></span>
	                        </label>
		                </div></td>
				    	<td><label id="labelVerTotal" style="margin-left:20px;display:none;">Ver Total Final:</label></td>
				    	<td><div id="guiaVerTotal" class="onoffswitch" style="margin-left:20px;display:none;">
	                        <input type="checkbox" class="onoffswitch-checkbox" id="verTotal" checked>
	                        <label class="onoffswitch-label" for="verTotal">
	                            <span class="onoffswitch-inner"></span>
	                            <span class="onoffswitch-switch"></span>
	                        </label>
		                </div></td>
				  	</tr>
				</table>
			</div>
		</div>
	</div>
 --->
	<div class="row">
		<div class="col-md-12">
			<div id="contenedorTabla" style="overflow:auto;">
				<table id="tablaConsulta" class="table table-bordered table-hover" width="100%"
				  data-search="true" data-pagination="false" data-page-size="15" data-row-style="rowStyle"
				  data-show-export="true" <!--- data-export-types="['excel']" --->>
					<thead>
						<cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
							<cfif i lt encabezado.getniveles()+1>
								<tr  class="azulSumaCol" style="background-color:#17c">
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
									<!--- <cfif i eq 1>
										<th align="center" val-pkcolumna="" rowspan="<cfoutput>#encabezado.getniveles()#</cfoutput>"data-field="PK_FILA">
											PK_FILA
										</th>
									</cfif>	 --->
								</tr>
							</cfif>
						</cfloop>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
	var $table = $('#tablaConsulta');
	 $(function () {
    	$('#tablaConsulta').bootstrapTable({
            exportDataType: 'all',
            exportOptions: {
                // excelstyles: ['background-color', 'text-align', 'color', 'font-size', 'height', 'width'],
                excelstyles: ['background-color', 'color', 'border-bottom-color', 'border-bottom-style', 'border-bottom-width', 'border-top-color', 'border-top-style', 'border-top-width', 'border-left-color', 'border-left-style', 'border-left-width', 'border-right-color', 'border-right-style', 'border-right-width', 'font-family', 'font-size', 'font-weight', 'text-align', 'height', 'width'],
                fileName: <cfoutput>'#prc.Reporte.getreportes()[1].getnombre()#'</cfoutput>,
                worksheetName:'Acumulado'
            },
            exportTypes: {
                default: 'excel'
            }
        });///
        
        // Para saber el numero de columnas existentes
        // Obtiene el arreglo de columnas, cuenta los arreglos y obtiene el tamaño del ultimo ya que es la mas grande
        // var columnas = $('#tablaConsulta').bootstrapTable('getOptions').columns;
        // var numeroColumnas = columnas[(Object.keys($('#tablaConsulta').bootstrapTable('getOptions').columns).length)-1].length;
        // console.log(columnas);
        // console.log(numeroColumnas);
    });	

	<!---
	* Fecha      : Febrero 2017
	* Autor      : SGS
	* Descripcion: Muestra u oculta las filas de datos
	* --->
	function ocultaVerDatos(){
		if($("#verDatos").prop('checked') == true){
			$('.filaNormal').show();
		} else{
			$('.filaNormal').hide();
		}
	}

	<!---
	* Fecha      : Febrero 2017
	* Autor      : SGS
	* Descripcion: Muestra u oculta las filas de subsecciones
	* --->
	function ocultaVerSubSecciones(){
		if($("#verSubSecciones").prop('checked') == true){
			$('.azulSumaSeccion').show();
		} else{
			$('.azulSumaFil').hide();
		}
	}

	<!---
	* Fecha      : Febrero 2017
	* Autor      : SGS
	* Descripcion: Muestra u oculta las filas de subtotales
	* --->
	function ocultaVerSubTotales(){
		if($("#verSubTotales").prop('checked') == true){
			$('.azulSumaFil').show();
		} else{
			$('.azulSumaFil').hide();
		}
	}

	<!---
	* Fecha      : Febrero 2017
	* Autor      : SGS
	* Descripcion: Muestra u oculta las filas de totales
	* --->
	function ocultaVerTotales(){
		if($("#verTotal").prop('checked') == true){
			$('.azulSumaFilUltima').show();
		} else{
			$('.azulSumaFilUltima').hide();
		}
	}

	<!---
	* Fecha      : Febrero 2017
	* Autor      : SGS
	* Descripcion: Muestra la paginacion si todos los botones estan checados
	* --->
	function mostrarPaginacion(){
		if($('#verDatos').is(':checked') && $('#verSubSecciones').is(':checked') && $('#verSubTotales').is(':checked') && $('#verTotal').is(':checked')){
			$('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:true});
		}
	}
	    
	$(document).ready(function () {


		var your_object = (<cfoutput>#prc.reporte.getreportes()[1].getInformacionFinalAcumulado(1)#</cfoutput>);

		var data = [<cfoutput>#prc.reporte.getInfoAcumulado()#</cfoutput>];

		$("#tablaConsulta").bootstrapTable({}); 
        $('#tablaConsulta').bootstrapTable('hideColumn', 'PK_FILA');
        $("#tablaConsulta").bootstrapTable('load', data); 
        $('.filaNormal').hide();
        $('.azulSumaFil').hide();
		$('.azulSumaFil').hide();
        $('.azulSumaSeccion').hide();
        // $('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:true});

		$("#displayNombre").text('<cfoutput>#prc.reporte.getreportes()[1].getnombre()#</cfoutput>');///
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Muestra u oculta las filas de datos sin cambiar las demas opciones
		* --->
		$('#verDatos').change(function(){
			$('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:false});
			ocultaVerDatos();
			ocultaVerSubSecciones();
			ocultaVerSubTotales();
			ocultaVerTotales();
			mostrarPaginacion();
		});

		<!---
		* Fecha      : Febrero 2017
		* Autor      : SGS
		* Descripcion: Muestra u oculta las filas de subsecciones sin cambiar las demas opciones
		* --->
		$('#verSubSecciones').change(function(){
			$('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:false});
			ocultaVerDatos();
			ocultaVerSubSecciones();
			ocultaVerSubTotales();
			ocultaVerTotales();
			mostrarPaginacion();
		});
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Muestra u oculta las filas de subtotales sin cambiar las demas opciones
		* --->
		$('#verSubTotales').change(function(){
			$('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:false});
			ocultaVerDatos();
			ocultaVerSubSecciones();
			ocultaVerSubTotales();
			ocultaVerTotales();
			mostrarPaginacion();
		});
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Muestra u oculta las filas de totales sin cambiar las demas opciones
		* --->
		$('#verTotal').change(function(){
			$('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:false});
			ocultaVerDatos();
			ocultaVerSubSecciones();
			ocultaVerSubTotales();
			ocultaVerTotales();
			mostrarPaginacion();
		});
		
		$("#ExportarExcel").click(function (e) {
			$("#tablaConsulta").bootstrapTable('togglePagination');	
		    window.open('data:application/vnd.ms-excel,' + $('#tablaConsulta').html());
		    e.preventDefault();
		    $("#tablaConsulta").bootstrapTable('togglePagination');
		});
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
    		return {classes: 'filaNormal'};
    	}
    	return {};
	}
	






</script>