<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Obtiene la tabla con la nomina de los investigadores.
    --->
	function getNomina(){
		var validar = $("#formNomina").validate({
			rules: {
				inClave:  		{required:true},
				inClaveGracia: 	{required:true},
				inClaveRes: 	{required:true},
				cveOficio:   	{required:true}
			},errorPlacement: function (error, element) {
				error.insertAfter($(element).parent());
            }
		});

		if(validar.form()){

			var solAt = $('#solAt').prop('checked') ? true : false;
			var solRI = $('#solRI').prop('checked') ? true : false;

			$.post('<cfoutput>#event.buildLink("EDI.solicitud.getTablaNomina")#</cfoutput>', {
				mayorCero: 		$("input[name=mayorCero]:checked").val(),
				clave: 			$("#inClave").val(),
				cveGracia: 		$("#inClaveGracia").val(),
				cveResidencia: 	$("#inClaveRes").val(),
				cveOficio: 		$("#cveOficio").val(),
				tipoDoc: 		0,
				solAt: 			solAt,
				solRI: 			solRI
			}, function(data){
				$("#tablaNomina").html(data);
			});
		}
	}

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Limpia filtros de busqueda.
    --->
	function limpiaBusqueda(){
		$("input[name=mayorCero]:checked").removeAttr('checked');
		$("#mayorCeroNo").prop("checked", true);
		$('input:checkbox').removeAttr('checked');
		$("#inClave").val('');
		$("#inClaveGracia").val('');
		$("#inClaveRes").val('');
		$("#cveOficio").val('');
	}

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el archivo generado (txt, prn)
    --->
	function generarDocumento(tipoDoc){
		$("#iframeDocumentos > #tipoDocTxt").val(tipoDoc);
		$("#iframeDocumentos > #oficioTxt").val($("#inOficio").val());
		$('#iframeDocumentos')[0].submit();
	}

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Obtiene la tabla de investigadores enviados a nómina despues de guardarlos.
    --->
	function enviadosNomina(){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.getEnviadosNomina")#</cfoutput>', {
			oficio: $("#cveOficio").val()
		}, function(data){
			$("#tablaEnviadosNomina").html(data);
			$(".botonesNomina").hide();
		});
	}

	<!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Tovar
    * Comentario: Obtiene la tabla de investigadores enviados a nómina sin seleccionar un oficio.
    --->
	function enviadosNominaSimple(oficio){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.getEnviadosNomina")#</cfoutput>', {
			oficio: oficio
		}, function(data){
			$("#tablaEnviadosNomina").html(data);
			$(".botonesNomina").hide();
		});
	}
	
</script>