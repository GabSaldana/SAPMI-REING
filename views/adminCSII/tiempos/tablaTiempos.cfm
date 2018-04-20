<cfprocessingdirective pageEncoding="utf-8">
<div class="row">
	<table id="tablaTiempos" function ="getIndex" class="table table-striped table-responsive" data-page-size="7" data-pagination="true" data-fixed-number="3" data-search="true" data-search-accent-neutralise="true" data-show-export="true" data-export-types="['excel']" data-show-columns="true">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="Nombre">Nombre</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="Descripcion">Descripci&#243;n</th>
				<th class="text-center	col-md-1" data-sortable="true" data-fiels="EdoActual">Estado Actual</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="TiempoTotal">Tiempo Total Transcurrido</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="TiempoDep">Tiempo Transcurrido en la dependencia</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="TiempoArea">Tiempo Transcurrido en area central</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="Acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput>
				<cfloop array="#prc.tiempo#" index="fila">
				<tr>
					<td class="text-center">#fila.getCONVENIO()#</td>
					<td class="text-center">#fila.getOBJCONVENIO()#</td>
					<td class="text-center"><cfif fila.getPKCONVENIO() neq 0><span class="fa-stack"><i class="fa fa-circle-o fa-stack-2x"></i><strong class="fa-stack-1x">#fila.getESTADOACTUAL()#</strong></span></cfif></td>
					<td class="text-center">#fila.getTiempoTotalString()#</td>
					<td class="text-center">#fila.getTiempoDepString()#</td>
					<td class="text-center">#fila.getTiempoAreaString()#</td>
					<td class="text-center">
						<cfif fila.getPKCONVENIO() neq 0>
							<button type="button" class="btn btn-info guiaControlEstados" data-toggle="tooltip" title="Control de Estados" data-toggle="modal" href="##modal-historial" id="controlEdos" data-registro="#fila.getPKCONVENIO()#">
								<i class="fa fa-list-ol"></i>
							</button>
						</cfif>
					</td>	
				</tr>
				</cfloop>
			</cfoutput>
		</tbody>
	</table>
	<input type="hidden" id="textoDescripcion" value="">
</div>

<script type="text/javascript">

	$(function () {
		$('#tablaTiempos').bootstrapTable({
			exportDataType: 'all',
			exportOptions: {
				excelstyles: ['background-color', 'color', 'border-bottom-color', 'border-bottom-style', 'border-bottom-width', 'border-top-color', 'border-top-style', 'border-top-width', 'border-left-color', 'border-left-style', 'border-left-width', 'border-right-color', 'border-right-style', 'border-right-width', 'font-family', 'font-size', 'font-weight', 'text-align', 'height', 'width'],
				fileName: 'Reporte_Tiempos',
				worksheetName: 'Reporte_Tiempos',
				ignoreColumn: ["Acciones"]
			},
			exportTypes: {
				default: 'excel'
			}
		});
	});

	var proced = $('#proced').val() == undefined || $('#proced').val() == null ||  isNaN($('#proced').val()) || $('#proced').val() == '' ? 0 : $('#proced option:selected').text() ;
	var area = $('#area').val() == undefined || $('#area').val() == null ||  isNaN($('#area').val()) || $('#area').val() == '' ? 'TODAS' : $('#area').find('option:selected').text();
	var estado = $('#estado').val() == undefined || $('#estado').val() == null ||  isNaN($('#estado').val()) || $('#estado').val() == '' ? 'TODOS' : $('#estado').find('option:selected').text();
	var rol = $('#rol').val() == undefined || $('#rol').val() == null ||  isNaN($('#rol').val()) || $('#rol').val() == '' ? 'TODOS' : $('#rol').find('option:selected').text();
	var fechaInicio = $('#fechaInicio').val() == undefined || $('#fechaInicio').val() == null || $('#fechaInicio').val() == '' ? '0/0/0' : $('#fechaInicio').val();
	var fechaFin = $('#fechaFin').val() == undefined || $('#fechaFin').val() == null || $('#fechaFin').val() == '' ? '0/0/0' : $('#fechaFin').val();
	var fecha = '';
		if(fechaInicio != '0/0/0')
			var fecha = fecha + ' desde ' + fechaInicio;
		if(fechaFin != '0/0/0')
			var fecha = fecha + ' hasta ' + fechaFin;

	$('#textoDescripcion').val(proced+' filtrados con base en : Estado( '+estado+' ) y Rol( '+rol+' ) ' +fecha+ '.');
	$('#tablaTiempos').bootstrapTable();
	$('[data-toggle="tooltip"]').tooltip();

</script>