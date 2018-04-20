<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript" src="/includes/js/jquery/jquery-tableExport/tableExport.js"></script>
<script type="text/javascript" src="/includes/js/jquery/jquery-tableExport/bootstrap-table-export.js"></script>

<div class="ibox float-e-margins">
	<div class="ibox-title">
		<h5>Búsqueda de Investigadores</h5>
	</div>
	<div class="ibox-content">
		<div class="row">
			<div class="col-sm-4">
				<label class="control-label">Proceso:</label>
				<select class="selectpicker form-control busquedaInv" data-live-search="true" data-style="btn-success btn-outline" title="Seleccionar Proceso..." id="inProceso" onchange="getTablaInvestigadores();">
				<option value="<cfoutput>#prc.procesos.PKPROCESO[1]#</cfoutput>" selected><cfoutput>#prc.procesos.NOMBREPPROCESO[1]#</cfoutput></option>
                    <cfset total_records = prc.procesos.recordcount/>
                    <cfloop index="x" from="2" to="#total_records#">
                        <cfoutput><option value="#prc.procesos.PKPROCESO[x]#" >#prc.procesos.NOMBREPPROCESO[x]#</option></cfoutput>    
                    </cfloop>
				</select>
			</div>
		</div>
		<div class="row" id="divTablaInvestigadores"></div>
	</div>
</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		getTablaInvestigadores();
	});

	$('.selectpicker').selectpicker();

	function getTablaInvestigadores(){
		$.post('<cfoutput>#event.buildLink("EDI.evaluacion.getTablaInvestigadores")#</cfoutput>',{
			pkProceso: $('#inProceso').val()
		}, function(data){
			$('#divTablaInvestigadores').html(data);
		});
	}
	
</script>