<cfprocessingdirective pageEncoding="utf-8">
<!--- <cfdump var="#session#">
 ---><div class="wrapper-content">
	<div class="ibox float-e-margins">
		<div class="ibox-title">
			<h5>Búsqueda de Investigadores</h5>
		</div>
		<div class="ibox-content">
			<div class="row">
				<div class="col-sm-4">
					<label class="control-label">Proceso:</label>
					<select class="selectpicker form-control busquedaProceso" data-live-search="true" data-style="btn-success btn-outline" title="Seleccionar Proceso..." id="inProceso">
						<cfset total_records = prc.procesos.recordcount/>
                   		<cfloop index="x" from="1" to="#total_records#">
                   			<cfif prc.procesos.PKPROCESO[x] EQ prc.proceso_actual.getPKPROCESO()>
                       			<cfoutput><option value="#prc.procesos.PKPROCESO[x]#" selected >#prc.procesos.NOMBREPPROCESO[x]#</option></cfoutput>
                       		<cfelse>
                       			<cfoutput><option value="#prc.procesos.PKPROCESO[x]#">#prc.procesos.NOMBREPPROCESO[x]#</option></cfoutput>
                       		</cfif>
                   		</cfloop>
					</select>
				</div>
				<div class="col-sm-4">
					<label class="control-label">Clasificación:</label>
					<select class="selectpicker form-control busquedaClasificacion" data-live-search="true" data-style="btn-success btn-outline" title="Seleccionar Clasificación..." id="inClasificacion" onchange="obtenURS();">
						<option value="<cfoutput>#prc.clasificaciones.CLAVE[1]#</cfoutput>" selected><cfoutput>#prc.clasificaciones.NOMBRE[1]#</cfoutput></option>
                   		<cfset total_records = prc.clasificaciones.recordcount/>
                   		<cfloop index="x" from="2" to="#total_records#">
                       		<cfoutput><option value="#prc.clasificaciones.CLAVE[x]#" >#prc.clasificaciones.NOMBRE[x]#</option></cfoutput>	    
                   		</cfloop>
					</select>
				</div>
				<div class="col-sm-4">
					<label class="control-label">Unidad responsable:</label>
					<select class="selectpicker form-control busquedaUR" data-live-search="true" data-style="btn-success btn-outline" title="Seleccionar Unidad responsable" id="inUr" onchange="getTablaConsultaInv();">
						 <cfset total_records = prc.ur.recordcount/>
                   		<cfloop index="x" from="1" to="#total_records#">
                       		<cfoutput><option value="#prc.ur.pk[x]#" >#prc.ur.NOMBRE[x]#</option></cfoutput>	    
                   		</cfloop>
					</select>
				</div>
			</div>
			<div class="row" id="divTablaInvestigadoresDictamen">
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		obtenURS();
	});

	function obtenURS() {
		$.post('/index.cfm/EDI/impresion/getURClasificacion',{
			clasificacion : $('.busquedaClasificacion').val()
		},function(data){
			$('#inUr').html('');
			for(i = 0; i < data.ROWCOUNT;i++){
				$("#inUr").append('<option value="'+data.DATA.PK[i]+'" data-content="'+data.DATA.NOMBRE[i]+'"></option>');
			}
			$("#inUr").selectpicker("refresh");
		});
	}

	function getTablaConsultaInv(){
		console.log($("#inUr").val());
		console.log($("#inProceso").val());
		$.post('/index.cfm/EDI/impresion/getTablaAspiranteProcesoUR',{
			pkProceso : $("#inProceso").val(),
			ur : $("#inUr").val()
		}, function(data){
			$('#divTablaInvestigadoresDictamen').html(data);
		});
	}
</script>