<div class="row">
	<div id="toolbar">
		<button type="button" class="btn btn-primary btn-outline btn-addSolicitudComite"><span class="glyphicon glyphicon-plus"></span> AGREGAR SOLICITUD AL COMITÉ ACADÉMICO</button>
	</div>
	<table id="tablaSolicitudesComite" function ="getIndex" class="table table-striped table-responsive" data-pagination="true" data-search-accent-neutralise="true" data-toolbar="#toolbar">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="numero">Número</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="solicitud">Solicitud</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="fechaEnvio">Fecha de Envío</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<!--- <cfoutput> --->
				<!--- <cfloop index="i" from="1" to="#prc.becas.recordcount#"> --->
					<tr>
						<td class="text-center">#prc.becas.numero[i]#</td>
						<td class="text-center">#prc.becas.INICIO[i]# - #prc.becas.TERMINO[i]# </td>
						<td class="text-center">#prc.becas.BECA[i]#</td>
						<td class="text-center">
							<button data-toggle="tooltip" class="btn btn-success fa fa-file" pkSNI="#prc.historial.pkSNI[i]#" title="Comprobantes"></button>
						</td>
					</tr>
				<!--- </cfloop> --->
			<!--- </cfoutput> --->
		</tbody>
	</table>
</div>
<script type="text/javascript">	
	$('#tablaSolicitudesComite').bootstrapTable();
</script>