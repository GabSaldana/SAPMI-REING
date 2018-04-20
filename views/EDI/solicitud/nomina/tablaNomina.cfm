<cfprocessingdirective pageEncoding="utf-8">

<div class="col-md-12">
	<table id="tabladenomina" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-page-size="10" data-search-accent-neutralise="true" data-maintain-selected="true">
		<thead>
			<tr>
				<th class="text-center" data-formatter="getIndex">Número</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="id">pk</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="nombre">Nombre</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="rfc">RFC</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="nivel">Nivel</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="clave">Clave</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="zonaPago">Zona pago</th>
				<th class="text-center" data-sortable="true" data-valign="middle" data-field="oficio">Oficio</th>
				<th class="text-center" data-valign="middle" data-checkbox="true"></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput>
				<cfset i= 0>
				<cfloop index="i" from="1" to="#arrayLen(prc.nomina)#">
					<tr>
						<td>#i#</td>
						<td>#prc.nomina[i].getPK_ASPROC()#</td>
						<td>#prc.nomina[i].getNOMBRE()#</td>
						<td>#prc.nomina[i].getRFC()#</td>
						<td>#prc.nomina[i].getNIVEL()#</td>
						<td>#prc.nomina[i].getCLAVE()#</td>
						<td>#prc.nomina[i].getZONA_PAGO()#</td>
						<td>#prc.nomina[i].getCVEOFICIO()#</td>
					</tr>
				</cfloop>
			</cfoutput>	
		</tbody>
	</table>
</div>

<script type="text/javascript">

	$('#tabladenomina').bootstrapTable();
	$('#tabladenomina').bootstrapTable('hideColumn', 'id');
	$('#tabladenomina').bootstrapTable('checkAll');

	function getIndex(value, row, index) {
		return index+1;
	}

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Obtiene claves correspondientes al investigador.
    --->
	function getIdSelections() {
        return $.map($('#tabladenomina').bootstrapTable('getSelections'), function (row) {
        	var z = {pkAsp:row.id, nivel:row.nivel, clave:row.clave, pago:row.zonaPago, oficio:row.oficio, rfc:row.rfc};
            return z
        });
    }

    <!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Guarda los investigadores que aplican a nómina.
    --->
	function guardarNomina(){

		var ids = getIdSelections();

		if (ids.length > 0){
			$.post('<cfoutput>#event.buildLink("EDI.solicitud.guardaNomina")#</cfoutput>', {
				clave:			$("#inClave").val(),
				cveGracia:		$("#inClaveGracia").val(),
				cveResidencia:  $("#inClaveRes").val(),
				cveOficio:		$("#cveOficio").val(),
				aspirantes:		JSON.stringify(ids)
			}, function(data) {
				if (data > 0){
					toastr.success('', 'Investigadores guardados en nómina');
					getNomina();
					enviadosNomina();
					$('.nav-tabs a[href="#menu2"]').tab('show');
				}else {
					toastr.error('', 'Error al guardar nómina');
				}
			});
		}else {
			toastr.warning('', 'No se han seleccionado investigadores.');
		}
	}
	
</script>
