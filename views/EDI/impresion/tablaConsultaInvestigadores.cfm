<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="tablaConsultaInvestigadores_js.cfm">
<div class="col-md-12">
	<table id="tablaConsulta" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-search-accent-neutralise="true" data-show-export="true">
	<thead>
		<tr>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="nombre">Nombre</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="rfc">RFC</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="num_empleado">Número de Empleado</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="ur">Dependencia</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="correo">Correo</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="movimiento">Movimiento</th>
			<th class="text-center" data-sortable="true" data-valign="middle" data-field="edo_solicitud" data-formatter="estado">Estado de la Solicitud</th>
		</tr>
	</thead>
	</table>
	<cfif prc.consulta.RECORDCOUNT GT 0>
		<div class="text-right">
			<!--- <form action="/index.cfm/EDI/impresion/getDictamenConsulta" method="post">
				<input type="hidden" name="dato" value="10">
				<button class="btn btn-primary " type="submit"><i class="fa fa-print"></i>&nbsp;Imprimir dictamen</button>
			</form> --->
			<button class="btn btn-primary " type="button" onclick="imprimirDictamen();"><i class="fa fa-print"></i>&nbsp;Imprimir dictamen</button>			
		</div>
	</cfif>
</div>

