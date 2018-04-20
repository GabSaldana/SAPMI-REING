<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIP
* Modulo:		datos generales
* Fecha:		Octubre de 2017
* Descripcion:	JS de los datos generales del investigador
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$(document).ready(function(){
	// datosPersonales();
	// informacionLocalizadion();
	
	$("#wizard").steps({
	    // Disables the finish button (required if pagination is enabled)
	    enableFinishButton: false, 
	    // Disables the next and previous buttons (optional)
	    enablePagination: false, 
	    // Enables all steps from the begining
	    enableAllSteps: true, 
	    // Removes the number from the title
	    titleTemplate: "#title#"
	    ,cssClass: "tabcontrol"
	});

	datosPersonales();
	datosLocalizacion();
	trayectoriaIpn();
	escolaridad();
	sni();
	empleos();
	becas();
});




function datosPersonales(){
	$.ajax({
		url: '<cfoutput>#event.buildLink("CVU.datosGenerales.vistaInformacionGeneral")#</cfoutput>',
		type: 'POST'		
	})
	.done(function(data) {
		$('#informacionGeneralContent').html(data);		
	});
}

function datosLocalizacion(){
	$.ajax({
		url: '<cfoutput>#event.buildLink("CVU.datosGenerales.vistaDatosLocalizacion")#</cfoutput>',
		type: 'POST'		
	})
	.done(function(data) {
		$('#datosLocalizacionContent').html(data);		
	});
}

function trayectoriaIpn(){
	$.ajax({
		url: '<cfoutput>#event.buildLink("CVU.datosGenerales.vistaTrayectoriaIpn")#</cfoutput>',
		type: 'POST'		
	})
	.done(function(data) {
		$('#trayectoriaIpnContent').html(data);		
	});
}

function informacionLocalizadion(){
	alert('Vista de  informacion de Localizadion');
}

function escolaridad(){
	$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.vistaEscolaridad")#</cfoutput>',{
		pkInvestigador:$("#pkInvestigador").val()
	},function(data){
		$('#escolaridadContent').html(data);
	});
}

function sni(){
	$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.vistaSNI")#</cfoutput>',{
		pkInvestigador:$("#pkInvestigador").val()
	},function(data){
		$('#sniContent').html(data);
	});
}

function empleos(){
	$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.vistaEmpleos")#</cfoutput>',{
		pkInvestigador:$("#pkInvestigador").val()
	},function(data){
		$('#empleosContent').html(data);
	});
}

function becas(){
	$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.vistaBecas")#</cfoutput>',{
		pkInvestigador:$("#pkInvestigador").val()
	},function(data){
		$('#becasContent').html(data);
	});
}
</script>