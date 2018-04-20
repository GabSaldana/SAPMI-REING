<style>
<!--
.c_fecha{
	display:block;
	background: -moz-linear-gradient(center top , #FFFFFF, #ECEBEB) repeat scroll 0 0 transparent;
	border: 1px solid #BEBEBE;
	border-radius: 5px 5px 5px 5px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.15);
/*	float: left;*/
/*	margin: 0 12px 5px 0;*/
	margin-left:auto;
	margin-right:auto;
	margin-bottom:8px;
	text-align: center;
	width: 52px;
}
.c_fecha .c_anio {
	background: rgba(201,229,189,1);
	background: -moz-linear-gradient(top, rgba(201,229,189,1) 0%, rgba(209,233,199,1) 100%);
	background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba(201,229,189,1)), color-stop(100%, rgba(209,233,199,1)));
	background: -webkit-linear-gradient(top, rgba(201,229,189,1) 0%, rgba(209,233,199,1) 100%);
	background: -o-linear-gradient(top, rgba(201,229,189,1) 0%, rgba(209,233,199,1) 100%);
	background: -ms-linear-gradient(top, rgba(201,229,189,1) 0%, rgba(209,233,199,1) 100%);
	background: linear-gradient(to bottom, rgba(201,229,189,1) 0%, rgba(209,233,199,1) 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#c9e5bd', endColorstr='#d1e9c7', GradientType=0 );
	border: 1px solid #c9e5bd;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	box-shadow: 0 1px 0 rgba(0, 0, 0, 0.2);
	color: #000;
	display: block;
	font-weight:bold !important;
	font: 11px/100% Arial,Helvetica,sans-serif;
	letter-spacing: 1px;
	padding: 2px 0;
	position: relative;
	text-transform: uppercase;
	width: 100%;
}
.c_fecha .c_dia{
	color: #666666;
	display: block;
	font: bold 20px/100% Arial,Helvetica,sans-serif;
	padding: 2px 0 1px;
}
.c_fecha .c_mes {
	color: #999999;
	display: block;
	font: 10px/100% Arial,Helvetica,sans-serif;
	padding: 0 0 4px;
}
-->
</style>
<cfoutput>
	<div class="table-responsive">
		<table class="table table-hover" id="informacion-registrada-id"
			data-search="true"
			data-pagination="true"
			data-show-columns="true"
			data-height="450"
			data-card-view="false"
			data-toggle="table"
			data-show-footer="true"
			data-row-style="rowStyle">
			<thead>
				<tr role="row">
					<th data-field="noError" data-switchable="false" class="text-center">No de Error</th>
					<th data-field="clvError" data-switchable="false" class="text-center">Clave del Error</th>
					<th data-field="usuario" class="text-center">Usuario</th>
					<th data-field="fecha" class="text-center">Fecha / Hora de registro</th>
					<th data-field="acciones" class="text-center">Acci&oacute;n</th>
				</tr>
			</thead>
			<tbody>
				<cfloop index="e" from="1" to="#prc.erroresReg.recordCount#">
					<tr>
						<td align="center" data-pkRegistro="#prc.erroresReg.PK_ERROR[e]#">#prc.erroresReg.PK_ERROR[e]#</td>
						<td align="center">#prc.erroresReg.CLAVE_ERROR[e]#</td>
						<td align="center">#prc.erroresReg.NOMBRE_COMPLETO[e]#</td>
						<td align="center">
							<cfset fecha_comp = ListToArray(prc.erroresReg.FECHA_REGISTRO[e],' ')>
							<div class="c_fecha">
								<span class="c_anio">#DateFormat(fecha_comp[1],"yyyy")#</span>
								<span class="c_dia">#DateFormat(fecha_comp[1],"dd")#</span>
								<span class="c_mes">#DateFormat(fecha_comp[1],"mmm")#</span>
							</div>
							<div class="clearfix"></div>
							<button type="button" class="btn btn-default btn-sm disabled">
								<span class="glyphicon glyphicon-time" aria-hidden="true"></span> #fecha_comp[2]#
							</button>
						</td>
						<td align="center">
							<button type="button" class="btn btn-default" data-toggle="tooltip" title="Ver detalle del error" data-pkError="#prc.erroresReg.PK_ERROR[e]#" onclick="verDetalleError(this);">
								<span class="glyphicon glyphicon-edit"></span>
							</button>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</div>
</cfoutput>
<script>
<!--
	$(document).ready(function(e) {
		$('[data-toggle="tooltip"]').tooltip();
		var $table = $('#informacion-registrada-id');
		$table.bootstrapTable('destroy');
		
		$table.bootstrapTable({
			useTotales:false,
			colorTitleFooter :"#336699"
		});
	});
-->
</script>