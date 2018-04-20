<cfprocessingdirective pageEncoding="utf-8">
<table id="tabla_escolaridadConsulta" class="table table-responsive" data-classes="table" data-search="false" data-search-accent-neutralise="true">
	<thead>
		<th data-align="center" data-halign="center" data-valign="middle">Grado</th>
		<th data-align="center" data-halign="center" data-valign="middle">Escuela</th>
		<th data-align="center" data-halign="center" data-valign="middle">Campo de Conocimiento</th>
		<th data-align="center" data-halign="center" data-valign="middle">Cédula Profesional</th>
		<th data-align="center" data-halign="center" data-valign="middle">Fecha de Inicio</th>
		<th data-align="center" data-halign="center" data-valign="middle">Fecha de Término</th>
		<th data-align="center" data-halign="center" data-valign="middle">Fecha de Obtención</th>
		<th data-align="center" data-halign="center" data-valign="middle">¿Estuvo en PNPC?</th>
		<th data-align="center" data-halign="center" data-valign="middle">Copia del Diploma</th>
	</thead>
	<tbody>
		<cfoutput>
			<cfloop query="#prc.escolaridad#">
				<tr>
					<td>#GRADO#</td>
					<td>#ESCUELA#</td>
					<td>#CAMPO_CONOCIMIENTO#</td>
					<td>#CEDULA_PROFESIONAL#</td>
					<td>#LSDateFormat(FECHA_INICIO,"dd/mm/yyyy")#</td>
					<td>#LSDateFormat(FECHA_TERMINO,"dd/mm/yyyy")#</td>
					<td>#LSDateFormat(FECHA_OBTENCION,"dd/mm/yyyy")#</td>
					<td>#iIf(PNPC EQ 1,de("Si"),de("No"))#</td>
					<td><span title="Copia del Diploma" class="btn btn-success" onclick="downloadCopiaDiploma(377,#PK_ESCOLARIDAD#);"><i class="fa fa-file"></i></span> </td>
				</tr>
			</cfloop>
		</cfoutput>
	</tbody>
</table>

<form id="downloadCopiaDiploma" action="<cfoutput>#event.buildLink('adminCSII.ftp.archivo.descargarArchivo')#</cfoutput>" method="POST" target="_blank">
	<input type="hidden" id="pkCatalogoDiploma" name="pkCatalogo">
	<input type="hidden" id="pkRegistroDiploma" name="pkObjeto">
</form>

<script type="text/javascript">
	
	$('#tabla_escolaridadConsulta').bootstrapTable();

	function downloadCopiaDiploma(pkCatalogo,pkEscolaridad){
		$("#pkCatalogoDiploma").val(pkCatalogo);
		$("#pkRegistroDiploma").val(pkEscolaridad);
		$('#downloadCopiaDiploma').submit();
	}
</script>
