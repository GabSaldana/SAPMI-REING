<script type="text/javascript">
	data = [];
 	<cfloop query="#prc.consulta#">
 		<cfoutput>
 			data.push(
 					{
 						nombre : "#NOMBRE#",
 						rfc : "#RFC#",
 						num_empleado : "#NUM_EMPLEADO#",
 						ur : "#UR#",
 						correo : "#CORREO#",
 						movimiento : "#MOVIMIENTO#",
 						edo_solicitud : "#ESTADO#",
 						color : "#COLOR#"
 					}
 				);
 		</cfoutput>
 	</cfloop>
 	console.log(data);
 	$(document).ready(function(){
 		$('#tablaConsulta').bootstrapTable();
 		$('#tablaConsulta').bootstrapTable('load', data);
 	});

 	function estado(value, row, index){
 		return ['<span style="font-size: 11px;" class="label '+row.color+'">'+row.edo_solicitud+'</span>'].join('');

 	}
 	function imprimirDictamen(){
 		var pkProceso = $("#inProceso").val();
		var ur = $("#inUr").val();
 		var mapForm = document.createElement("form");
    	mapForm.target = "Map";
    	mapForm.method = "POST"; // or "post" if appropriate
    	mapForm.action = "/index.cfm/EDI/impresion/getDictamenConsulta";
    	/*proceso*/
    	var mapInput = document.createElement("input");
    	mapInput.type = "hidden";
    	mapInput.name = "pkProceso";
    	mapInput.value = pkProceso;
    	mapForm.appendChild(mapInput);
    	/*ur*/
    	mapInput = document.createElement("input");
    	mapInput.type = "hidden";
    	mapInput.name = "ur";
    	mapInput.value = ur;
    	mapForm.appendChild(mapInput);
    	document.body.appendChild(mapForm);
    	map = window.open("", "Map");
		if (map) {
    		mapForm.submit();
		} else {
    		alert('You must allow popups for this map to work.');
		}
 	}
</script>