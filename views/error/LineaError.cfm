<script type="text/javascript">
<!--
	$(document).ready(function(e) {
		$('[data-toggle="tooltip"]').tooltip();
	});
-->
</script>
<style>
<!--
.fecha {
	margin-left:auto;
	margin-right:auto;
 text-align: center;
 width: 50px;
 font-family: "Times New Roman", Times, serif;
 font-weight:bold;
 border:1px solid #000000;
 margin-bottom:6px;
 }
.mes, .anio {
 font-size: 14px;
 }
.dia {
 font-size: 30px;
 line-height: 22px;
 }
#reloj:before{
	clear:both;
}

#reloj{
	top: 0px;
	right: 0px;
	color: #000000;
	padding:2px;
	font-size: 15px;
	text-shadow: #FFE145 1px 1px 1px;
}
-->
</style>
<cfoutput>
	<div class="alert alert-warning alert-dismissible" role="alert">
		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<strong>Informaci&oacute;n del archivo</strong>
		<br /><br />
		<div class="panel panel-warning">
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-hover">
						<tbody>
							<tr>
								<th class="text-left">Fecha del error:</th>
								<td nowrap="nowrap" class="text-center">
									<cfset fecha_comp = ListToArray(prc.fechaError,' ')>
									<div class="fecha">
										<div class="mes">
											#DateFormat(fecha_comp[1],"mmm")#
										</div>
										<div class="dia">
											#DateFormat(fecha_comp[1],"dd")#
										</div>
										<div class="anio">
											#DateFormat(fecha_comp[1],"yyyy")#
										</div>
									</div>
									<div id="reloj"><strong>#htmlEditFormat(fecha_comp[2])#</strong></div>
								</td>
							</tr>
							<tr>
								<th class="text-left">Carpeta:</th>
								<td nowrap="nowrap">#htmlEditFormat( prc.INFO.parent )#</td>
							</tr>
							<tr>
								<th class="text-left">Archivo:</th>
								<td nowrap="nowrap">#htmlEditFormat(prc.INFO.name)#</td>
							</tr>
							<tr>
								<th class="text-left">Tama&ntilde;o del archivo:</th>
								<td nowrap="nowrap">#NumberFormat((prc.INFO.size/1024),'9,999.99')# KB</td>
							</tr>
							<tr>
								<th class="text-left">L&iacute;nea de error:</th>
								<td nowrap="nowrap">
									<a class="btn btn-danger" href="##lineError" data-toggle="tooltip" title="(&dArr;) Ver l&iacute;nea de error" id="NoErrorID">
										<span class="badge">#htmlEditFormat(prc.LINEA)#</span>
									</a>
								</td>
							</tr>
							<tr>
								<th class="text-left">&Uacute;ltima modificaci&oacute;n:</th>
								<td nowrap="nowrap" class="text-center">
									<div class="fecha">
										<div class="mes">
											#DateFormat(prc.INFO.lastmodified,"mmm")#
										</div>
										<div class="dia">
											#DateFormat(prc.INFO.lastmodified,"dd")#
										</div>
										<div class="anio">
											#DateFormat(prc.INFO.lastmodified,"yyyy")#
										</div>
									</div>
									<div id="reloj"><strong>#DateTimeFormat(prc.INFO.lastmodified,'HH:nn:ss')#</strong></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<cfset numLn = 1>
	<cfloop file="#prc.archivo#" index="line">
		<cfif numLn EQ prc.linea>
			<div class="row bg-danger">
				<div class="col-xs-1 col-md-1">
					<a class="btn btn-warning btn-xs" href="##NoErrorID" data-toggle="tooltip" title="(&uArr;) L&iacute;nea de error #numLn#" id="lineError">
						<span class="glyphicon glyphicon-remove"></span>
					</a>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-11">
					<strong>#HTMLEditFormat(line)#</strong>
				</div>
			</div>
		<cfelse>
			<div class="row">
				<div class="col-xs-1 col-md-1">
					<label>#numLn#</label>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-11">
					#HTMLEditFormat(line)#
				</div>
			</div>
		</cfif>
		<cfset numLn = numLn + 1>
	</cfloop>
</cfoutput>