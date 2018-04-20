<cfprocessingdirective pageEncoding="utf-8">
<div class="row">
	<table id="tablaHistorial" function ="getIndex" class="table table-striped table-responsive" data-page-size="10" data-pagination="true" data-search="true" data-search-accent-neutralise="true" style=" padding-left: 10px; padding-right: 10px;">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="Plantilla">Plantilla</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="EmailDestino">e-mail Destino</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="Usuario">Usuario</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="Fecha">Fecha</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="Acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="prc.correos">
				<tr>
					<td class="text-center">#PLANTILLA#</td>
					<td class="text-center">#DESTINO#</td>
					<td class="text-center">#NOMBRE# #APPAT# #APMAT#</td>
					<td class="text-center">#FECHA#</td>
					<td class="text-center">
							<button type="button" class="btn btn-info guiaHistorialMostrarCorreo" data-toggle="tooltip" title="Mostrar Correo" onclick="getCorreo(#PKHISTORIAL#)">
								<i class="fa fa-list-ol"></i>
							</button>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</div>
<div id="modal-historial" class="modal inmodal fade modaltext" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">Contenido</h4>
			</div>
			<div class="modal-body" id="Contenido">
				:v
			</div>
			<div class="modal-footer">
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$('.modal').css('overflow-y', 'auto');
	$('.modal').css('max-height', $(window).height());

	$('#tablaHistorial').bootstrapTable();
	$('[data-toggle="tooltip"]').tooltip();
</script>