<cfprocessingdirective pageEncoding="utf-8">

<cfif prc.envNomina.recordcount GT 0>
	<div class="ibox-content"><br>
		<div class="row">
			<div class="col-sm-6">
				<label class="control-label">Oficio:</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="glyphicon glyphicon-pushpin"></span>
					</span>
					<select id="inOficio" class="form-control" onchange="enviadosNominaSimple(this.value);">
						<option value="-1" selected="selected">Seleccionar oficio</option>
						<cfset total_records = prc.oficios.recordcount/>
						<cfloop index="x" from="1" to="#total_records#">
							<cfoutput><option value="#prc.oficios.PK_ASPCLAVE[x]#">#prc.oficios.PK_ASPCLAVE[x]#</option></cfoutput>
						</cfloop>
					</select>
				</div>
			</div>
		</div><br>
	</div>

	<div id="barraEnviados">
		<button type="button" class="btn btn-primary btn-outline dim" onclick="generarDocumento(1);"><span class="glyphicon glyphicon-download-alt"></span> Generar archivio .txt</button>
		<button type="button" class="btn btn-primary btn-outline dim" onclick="generarDocumento(2);"><span class="glyphicon glyphicon-download-alt"></span> Generar archivio .prn</button>
	</div>

	<div class="col-md-12">
		<table id="enviadosNomina" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-page-size="10" data-search-accent-neutralise="true" data-show-export="true" data-toolbar="#barraEnviados" data-maintain-selected="true">
<cfelse>
	<br><br>
	<table id="enviadosNomina" class="table table-striped table-responsive">

</cfif>
		<thead>
			<tr>
				<th class="text-center" data-formatter="getIndex">Número</th>
				<th class="text-center" data-sortable="true" data-valign="middle">Nombre</th>
				<th class="text-center" data-sortable="true" data-valign="middle">RFC</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="nivel">Nivel</th>
				<th class="text-center" data-sortable="true" data-valign="middle">Clave</th>
				<th class="text-center" data-sortable="true" data-valign="middle">Zona pago</th>
				<th class="text-center" data-sortable="true" data-valign="middle">Oficio</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfset i= 0>
			<cfoutput query="prc.envNomina">
				<tr>
					<td>#i#</td>
					<td>#NOMBRE#</td>
					<td>#RFC#</td>
					<td>#NIVEL#</td>
					<td>#CLAVE#</td>
					<td>#ZONA_PAGO#</td>
					<td>#OFICIO#</td>
					<td>
						<button class="btn btn-danger fa fa-trash" title="Eliminar" onclick="cambiaEstadoNomina(#PK_ASPROC#);"></button>
					</td>
				</tr>
			</cfoutput>	
		</tbody>
	</table>
</div>

<script type="text/javascript">

	$(document).ready(function(){
		$("#inOficio").val(<cfoutput>#prc.oficio#</cfoutput>);
	});

	$(function () {
		$('#enviadosNomina').bootstrapTable({
			exportDataType: 'all',
			exportOptions: {
				excelstyles: ['background-color', 'color', 'border-bottom-color', 'border-bottom-style', 'border-bottom-width', 'border-top-color', 'border-top-style', 'border-top-width', 'border-left-color', 'border-left-style', 'border-left-width', 'border-right-color', 'border-right-style', 'border-right-width', 'font-family', 'font-size', 'font-weight', 'text-align', 'height', 'width'],
				fileName: 'Listado_Investigadores',
				worksheetName: 'Listado_Investigadores',
				ignoreColumn: ['acciones']
			},
			exportTypes: {
				default: 'excel'
			}
		});
	});

	$('#enviadosNomina').bootstrapTable();

	function getIndex(value, row, index) {
		return index+1;
	}

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Cambia el estado de la nómina por pk del aspirante proceso.
    --->
	function cambiaEstadoNomina(pkAspirante){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.cambiaEstadoNomina")#</cfoutput>', {
			pkAspirante: pkAspirante
		}, function(data) {
			if (data > 0){
				toastr.success('', 'Acción ejecutada correctamente');
				enviadosNominaSimple(-1);
			}else {
				toastr.error('', 'Error al ejecutar acción');
			}
		});
	}
	
</script>
