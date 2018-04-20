<cfoutput>
	<div class="table-responsive">
		<table class="table table-hover" id="monitoreo-registrados-id"
				data-search="true"
				data-pagination="false"
				data-show-columns="true"
				data-side-pagination="client"
				data-height="640"
				data-toggle="table"
				data-show-export="true"
				data-show-footer="false"
				data-row-style="rowStyle">
			<thead>
				<tr role="row">
					<th class="text-center">No.</th>
					<th class="text-center">UR</th>
					<th class="text-center">Usuario</th>
					<th class="text-center">IP / HOST</th>
					<th class="text-center">Navegador</th>
					<th class="text-center">Sistema Operativo</th>
					<th class="text-center">Fecha de acceso</th>
					<th class="text-center">Acciones</th>
				</tr>
			</thead>
			<tbody>
				<cfloop index="e" from="1" to="#prc.regAccesos.recordCount#">
					<cfif prc.regAccesos.PK_ACCESO[e] NEQ "">
						<tr data-pkRegistro="#prc.regAccesos.PK_ACCESO[e]#">
							<td class="text-center">#e#</td>
							<td class="text-center">#prc.regAccesos.UR[e]#</td>
							<td class="text-center">#prc.regAccesos.NOMBRE_COMPLETO[e]#</td>
							<td class="text-center">#Replace(prc.regAccesos.IP_HOST[e],"/","<br />")#</td>
							<td class="text-center">#prc.regAccesos.NAVEGADOR[e]#</td>
							<td class="text-center">#prc.regAccesos.SISTEMA_OPERATIVO[e]#</td>
							<td class="text-center">#prc.regAccesos.FECHA_REGISTRO[e]#</td>
							<td class="text-center">
								<button type="button" class="btn btn-default btn-consulta" data-toggle="tooltip" title="Ver detalle del seguimiento" data-pkAcceso="#prc.regAccesos.PK_ACCESO[e]#" onClick="verAccesoDetalle(this);"><span class="glyphicon glyphicon-zoom-in"></span></button>
							</td>
						</tr>
					</cfif>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>
<script>
<!--
	$(document).ready(function(e) {
		$('[data-toggle="tooltip"]').tooltip();
		erroresTbl = $('#monitoreo-registrados-id').bootstrapTable({
			useTotales:false,
			exportTypes:['excel','doc'],
			fileName:"Listado de accesos",
			colorTitleFooter :"#336699"
		});
	});
-->
</script>