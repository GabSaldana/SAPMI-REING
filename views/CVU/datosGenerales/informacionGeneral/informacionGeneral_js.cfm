<!---
* =========================================================================
* IPN - CSII
* Sistema:			SIIP
* Modulo:				Datos generales del investigador
* Fecha:				Octubre de 2017
* Descripcion:	JS de la vista de la informacion del investigador
* Autor:				Daniel Memije
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

	function actaNacimiento(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	376,
			requerido:	0,
			extension:	JSON.stringify(['pdf']),
			convenio:	'<cfoutput>#persona.getPK_PERSONA()#</cfoutput>',
			recargar:	'actaNacimiento();'
		}, function(data) {
			$("#doc_actaNacimiento").html(data);
			$('.modal-backdrop').remove();
		});
	}

	function curp(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	378,
			requerido:	0,
			extension:	JSON.stringify(['pdf']),
			convenio:	'<cfoutput>#persona.getPK_PERSONA()#</cfoutput>',
			recargar:	'curp();'
		}, function(data) {
			$("#doc_curp").html(data);
			$('.modal-backdrop').remove();
		});
	}

	function idOficial(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	379,
			requerido:	0,
			extension:	JSON.stringify(['pdf']),
			convenio:	'<cfoutput>#persona.getPK_PERSONA()#</cfoutput>',
			recargar:	'idOficial();'
		}, function(data) {
			$("#doc_idOficial").html(data);
			$('.modal-backdrop').remove();
		});
	}	

	$(function() {		
		actaNacimiento();
		curp();
		idOficial();		
	});
</script>
