<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla_proyectos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="false" data-unique-id="pk" data-search-accent-neutralise="true">
	<thead>
		<th data-valign="middle" class="text-ceter" data-formatter="getIndex">#</th>
		<th data-valign="middle" data-field="pk">PK</th>
		<th data-valign="middle" data-sortable="true">Tipo</th>
		<!--- <th data-valign="middle" data-sortable="true">Clave</th> --->
		<th data-valign="middle" data-sortable="true">Nombre</th>
		<th data-valign="middle" data-sortable="true">Participación</th>
		<th data-valign="middle" data-sortable="true">Fecha inicio</th>
		<th data-valign="middle" data-sortable="true">Fecha fin</th>
		<th data-valign="middle">Documento</th>
	</thead>
	<tbody>       
		<cfif arrayLen(prc.PROYECTOS) GT 0>
			<cfoutput>
				<cfloop array="#prc.PROYECTOS[1]["REPORTE"].getFILAS()#" index="x">
					<tr>
						<td>##</td>
						<td><strong>##PK##</strong></td>
						<td>#x.getCeldas()[1].getVALORCELDA()#</td>
						<!--- <td><strong>Clave</strong></td> --->
						<td>#x.getCeldas()[3].getVALORCELDA()#</td>
						<td>#x.getCeldas()[2].getVALORCELDA()#</td>
						<td>#x.getCeldas()[4].getVALORCELDA()#</td>
						<td>#x.getCeldas()[5].getVALORCELDA()#</td>
						<td class="text-center">
							<button class="btn btn-success ml5 btn-verDoctoProy" data-tooltip="tooltip" title="Comprobantes" data-cfrm="#prc.PROYECTOS[1]["REPORTE"].getpkCFormato()#" data-col="#x.getCeldas()[6].getPK_COLUMNA()#" data-fil="#x.getCeldas()[6].getPK_FILA()#">
								<i class="fa fa-file"></i>
							</button>
							<form id="form_#prc.PROYECTOS[1]["REPORTE"].getpkCFormato()#_#x.getCeldas()[6].getPK_COLUMNA()#_#x.getCeldas()[6].getPK_FILA()#" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="post" target="_blank">
								<input type="hidden" name="pkCatFmt" value="<cfoutput>#prc.PROYECTOS[1]["REPORTE"].getpkCFormato()#</cfoutput>">
								<input type="hidden" name="pkColDown" value="<cfoutput>#x.getCeldas()[6].getPK_COLUMNA()#</cfoutput>">
								<input type="hidden" name="pkFilaDown" value="<cfoutput>#x.getCeldas()[6].getPK_FILA()#</cfoutput>">
							</form>
						</td>
					</tr>
				</cfloop>
			</cfoutput>
		</cfif>         
	</tbody>
</table>

<script type="text/javascript">
	$(document).ready(function() {    
		$(".form-control").removeClass('error');
		
		$('#tabla_proyectos').bootstrapTable(); 
		$('#tabla_proyectos').bootstrapTable('hideColumn', 'pk');
		
		$(".btn-verDoctoProy").on("click", function() {   
			var pkCFormato = $(this).data('cfrm');
			var pkColumna = $(this).data('col');
			var pkFila = $(this).data('fil');       
			$("#form_"+pkCFormato+"_"+pkColumna+"_"+pkFila).submit();            
		});
	});
	
	<!---- Crea el valor indice de la tabla ---->
	function getIndex(value, row, index) {
		return index+1;
	}
</script>

