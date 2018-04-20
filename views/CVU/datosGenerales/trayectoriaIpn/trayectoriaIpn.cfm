<cfprocessingdirective pageEncoding="utf-8">

<table id="tablaPlazas" function="getIndex" class="table table-striped table-responsive" data-pagination="true">
	<thead>
		<tr>
			<th class="text-center" data-sortable="true" data-valign="middle">Nombre de la plaza</th>
			<th class="text-center" data-sortable="true" data-valign="middle">Estado</th>
			<th class="text-center" data-sortable="true" data-valign="middle">Horas</th>
			<th class="text-center" data-sortable="true" data-valign="middle">Fecha inicio</th>
			<th class="text-center" data-sortable="true" data-valign="middle">Fecha termino</th>
		</tr>
	</thead>
	<tbody>		
		<cfoutput>		
			<cfloop query="#prc.trayectoria#">
				<tr>
					<td>#NOMBRE_PLAZA#</td>
					<td>#ESTADO_PLAZA#</td>
					<td>#HORAS#</td>
					<td>#FECHA_INICIO#</td>
					<td>#FECHA_TERMINO#</td>
				</tr>
			</cfloop>			
		</cfoutput>	
	</tbody>
</table>

<script type="text/javascript">
	$('#tablaPlazas').bootstrapTable();
</script>




