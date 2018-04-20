<cfprocessingdirective pageEncoding="utf-8">

<cfoutput>
	<table id="tabla-registros" class="table table-striped table-responsive">
		<thead>
	    	<tr>
				<cfloop from="1" to="#arrayLen(prc.registros.columnas)#" index="i">
					<th data-field="#prc.registros.columnas[i]#">#prc.registros.columnas[i]#</th>
				</cfloop>
			</tr>
	    </thead>

		<cfloop from="1" to="#prc.registros.resultado.recordcount#" index="k">
			<tr>
				<cfloop from="1" to="#arrayLen(prc.registros.columnas)#" index="j">
					<cfset col = prc.registros.columnas[j]>
					<td>#prc.registros.resultado[col][k]#</td>
				</cfloop>
			</tr>
		</cfloop>
	</table>
</cfoutput>


<script>

	$(document).ready(function() {    
	    $('#tabla-registros').bootstrapTable(); 
	    $('#tabla-registros').bootstrapTable("hideColumn", "PERIODO");
	    $('#tabla-registros').bootstrapTable("hideColumn", "FORMATO");
	});

</script>