<cfoutput>
	<div id="toolbar" class="btn-group">
		<button type="button" class="btn btn-default" onclick="analizarInformacion()">
			<i class="glyphicon glyphicon-cog">Analizar</i>
		</button>
	</div>
	<div class="table-responsive">
		<table class="table table-hover" id="errores-registrados-id"
			data-search="true"
			data-pagination="false"
			data-show-columns="true"
			data-height="450"
			data-toggle="table"
			data-show-export="true"
			data-show-footer="false"
			data-toolbar="##toolbar"
			data-row-style="rowStyle">
			<thead>
				<tr role="row">
					<th data-field="clvUR" class="text-center">UR</th>
					<th data-field="usuario" class="text-center">USUARIO</th>
					<th data-field="noError" data-switchable="false" class="text-center">No. DE ERROR</th>
					<th data-field="clvError" data-switchable="false" class="text-center">CLAVE DE ERROR</th>
					<th data-field="fecha" class="text-center">FECHA Y HORA DE REGISTRO</th>
					<th data-field="acciones" class="text-center">ACCI&Oacute;N</th>
				</tr>
			</thead>
			<tbody>
				<cfloop index="e" from="1" to="#prc.erroresReg.recordCount#">
					<tr>
						<td align="center" data-toggle="tooltip" title="#prc.erroresReg.NOMBRE_DEPENDENCIA[e]#">#prc.erroresReg.UR[e]#</td>
						<td align="center">#prc.erroresReg.NOMBRE_COMPLETO[e]#</td>
						<td align="center" data-pkRegistro="#prc.erroresReg.PK_ERROR[e]#">#prc.erroresReg.PK_ERROR[e]#</td>
						<td align="center">#prc.erroresReg.CLAVE_ERROR[e]#</td>
						<td align="center">#prc.erroresReg.FECHA_REGISTRO[e]#</td>
						<td align="center">
							<button type="button" class="btn btn-default" data-toggle="tooltip" title="Ver detalle del error" data-pkError="#prc.erroresReg.PK_ERROR[e]#" onclick="verErrorDetalle(this);">
								<span class="glyphicon glyphicon-edit"></span>
							</button>
							<!---
							&nbsp;&nbsp;
							<button type="button" class="btn btn-default" data-toggle="tooltip" title="Eliminar error" data-remove="#prc.erroresReg.PK_ERROR[e]#" onclick="eliminarError(this);">
								<span class="glyphicon glyphicon-trash"></span>
							</button>
							--->
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>
<script>
<!--
	var pkAnalisis =  [];
	$(document).ready(function(e) {
		$('[data-toggle="tooltip"]').tooltip();
		erroresTbl = $('#errores-registrados-id').bootstrapTable({
			useTotales:false,
			exportTypes:['excel','doc'],
			fileName:"Listado de Errores",
			colorTitleFooter :"#336699"
		});
		
		<cfloop index="e" from="1" to="#prc.erroresReg.recordCount#">
			<cfoutput>
				pkAnalisis.push(#prc.erroresReg.PK_ERROR[e]#);
			</cfoutput>
		</cfloop>
	});
-->
</script>