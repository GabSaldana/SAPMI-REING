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
<cfset filas = prc.reporte.getFilas()>
<cfset encabezado = prc.reporte.getEncabezado()>
<cfset columnas = encabezado.getColumnas()>

<script language="javascript" src="/includes/bootstrap/bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script language="javascript" src="../../../includes/bootstrap/bootstrap-table/extensions/export/tableExport.js"></script>
<style>
	.azulSumaCol{
		background-color:#25b1ff;
		color:#000;
		font-weight: bold;
	}
	.azulSumaFil{
		color:#000;
		background-color:#4af;
	}.azulSumaSeccion{
		color:#000;
		background-color:#39D;
	}
	.azulSumaFilUltima{
		color:#fff;
		background-color:#17c;
	}
	.notaModal{
		width: 300px;
		height: 300px;
		resize: none;
		padding: 10px 15px;
		box-sizing: border-box;
	}
</style>

<div class="container" >
	<div class="row">
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
	
	<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
		<cfif prc.reporte.getfilafija() eq 1>
			<button id="btn-eliminarFilas" class="btn btn-danger pull-right" onclick="elimiarFilas();" style="margin-left:10px;"><i class="fa fa-minus"></i> Eliminar fila</button>
			<button id="btn-crearFila" class="btn btn-success pull-right" onclick="crearFilaNueva();" style="margin-left:10px;"><i class="fa fa-plus"></i> Agregar fila</button>
		</cfif>
	</cfif>
	<button id="btn-notaTecnica" class="btn btn-info pull-right" onclick="notaTecnicaFormulario();"><i class="fa fa-bookmark"></i> Nota T&eacute;cnica</button>
	<div class="row">
		<div class="col-md-12">
			<div id="contenedorTabla" style="overflow:auto;">
				<table id="tablaConsulta" class="table table-bordered table-hover" width="100%"
				  data-search="true" data-pagination="false" data-page-size="15" data-row-style="rowStyle"
				  data-show-export="true" <!--- data-export-types="['excel']" --->>
					<thead>
						<cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
							<cfif i lt encabezado.getniveles()+1>
								<tr class="azulSumaCol" style="background-color:#17c">
									<cfif i eq 1>
										<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
											<th align="center" class="text-center" rowspan="<cfoutput>#encabezado.getniveles()#</cfoutput>" data-field="Editar" data-events="actionEvents">
												Editar
											</th>
										</cfif>	
									</cfif>	
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
			</div>
		</div>
	</div>
</div>

<div id="mdl-notaFormulario" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-sm">
		<div class="modal-content" style="width:362px">
			<div class="modal-header">
				<button id="closeNota" type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Nota T&eacute;cnica</h4>
			</div>
			<div class="modal-body">
				<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
					<label>Escribe una nota:</label>
				</cfif>
				<textarea id="notaFormulario" class="notaModal alert-info" readonly></textarea>
			</div>
			<div class="modal-footer">
				<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
					<button id="btn-guardarNota" class="btn btn-info pull-right" onclick="guardarNotaTecnicaFormulario();"><i class="fa fa-floppy-o"></i> Guardar nota</button>
				</cfif>
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
                fileName: $('#displayNombre').text().trim(),
                worksheetName:$('#displayTrimestre').text().trim()
            },
            exportTypes: {
                default: 'excel'
            }
        });
        
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
			$('.azulSumaSeccion').hide();
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
	    
	window.actionEvents = {
        'click .editarFila': function (e, value, row, index) {
            $('#displayNombreLlenado').text($('#displayNombreVistaLlenado').text());
			$('#displayTrimestreLlenado').text($('#displayTrimestreVistaLlenado').text());
			$('#divVistaLlenado').hide();
			$('#divLlenado').slideToggle(1000,'easeOutExpo');	
			$('#formularioLlenado').html('');
			$.post('capturaFT/getReporteLlenado', {
				formato: $('#pkformato').val(),
				periodo: $('#pkperiodo').val(),
				reporte: $('#pkReporte').val(),
			}, function(data){
				$('#formularioLlenado').html(data);	
				$("#pkFila").val(row.PK_FILA);
				obtenerDatosFila($("#pkFila").val());
		    });
        },
        'click .eliminarFila': function (e, value, row, index) {
			return $.ajax({
				type:'POST',
				url:'capturaFT/eliminarFilaFormulario',
				data:{
					pkFila: row.PK_FILA
				},
				success:function(data){
					if (data > 0){
						toastr.success('exitosamente','Fila eliminada');
						cargarLlenado();
					} else {
						toastr.error('al eliminar la fila','Problema');
					}
				}
			});
        }
    };
	$(document).ready(function () {
	 	var data = [<cfoutput>#prc.reporte.getInformacionFinal()#</cfoutput>];
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
		$("#tablaConsulta").bootstrapTable({}); 
        $('#tablaConsulta').bootstrapTable('hideColumn', 'PK_FILA');
        $("#tablaConsulta").bootstrapTable('load', data); 
        $('#tablaConsulta').bootstrapTable('refreshOptions',{pagination:true}); 
		
		
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
    		row.Editar = '<button class="btn btn-xs btn-success editarFila" title="Editar Fila"><i class="fa fa-pencil-square"></i></button>'+
    			'<button class="btn btn-xs btn-danger eliminarFila" title="Eliminar Fila" style="display:none;"><i class="fa fa-minus"></i></button>';
    		return {classes: 'filaNormal'};
    	}
    	return {};
	}


    function crearFilaNueva(){
    	var columnasEncabezado = [];
    	var pkColumnas = [
			<cfoutput>
				<cfloop array="#prc.reporte.getEncabezado().getColumnasUltimoNivel()#" index="columna">
					{"data": "#columna.getData()#"},
				</cfloop>
			</cfoutput>
		];
		for (var i = 0; i < pkColumnas.length; i++) {
			columnasEncabezado[i] = pkColumnas[i].data;
		}
		return $.ajax({
			type:'POST',
			url:'capturaFT/crearFilaNueva',
			data:{
				formato: $('#pkformato').val(),
				reporte: $('#pkReporte').val(),
				pkColumnas: JSON.stringify(columnasEncabezado)
			},
			success:function(data){
				if (data > 0){
					toastr.success('exitosamente','Fila agregada');
					cargarLlenado();
				} else {
					toastr.error('al crear la fila','Problema');
				}
			}
		});
	}

	function elimiarFilas(){
		$(".editarFila").toggle();
		$(".eliminarFila").toggle();
	}

	function notaTecnicaFormulario(){
			$.post('capturaFT/cargarNota', {
				formato: <cfoutput>#prc.acciones.PK#</cfoutput>,
				periodo: <cfoutput>#prc.acciones.PKPERIODO#</cfoutput>,
				reporte: <cfoutput>#prc.acciones.PKREPORTE#</cfoutput>
			}, function(data){
				$("#mdl-notaFormulario").modal('show');
				$('#notaFormulario').val(data.DATA.NOTA[0]);
				<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
					$('#notaFormulario').prop('readonly', false);
				</cfif>
			});
		}

		function guardarNotaTecnicaFormulario(){
			$.post('capturaFT/guardarNota', {
				formato: <cfoutput>#prc.acciones.PK#</cfoutput>,
				periodo: <cfoutput>#prc.acciones.PKPERIODO#</cfoutput>,
				reporte: <cfoutput>#prc.acciones.PKREPORTE#</cfoutput>,
				nota: $('#notaFormulario').val()
			}, function(data){
				if (data > 0){
					toastr.success('','Nota Guardada');
					$("#mdl-notaFormulario").modal('hide');
				} else{
					toastr.error('','Error al Guardar');
				}
		    });
		}


	
</script>