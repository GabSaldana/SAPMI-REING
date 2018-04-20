<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<div class="row">
	<div class="col-md-12" id="solicitudSiLaboral" style="display: none">
		<div class="alert alert-success">
		    Usted ha cargado la carta.
		</div>
	</div>
	<div class="col-md-12 noProcede" id="solicitudNoLaboral" style="display: none">
		<div class="alert alert-danger">
		    Usted aún <strong>No</strong> ha cargado la carta.<br>
		    No puede participar en el programa.
		</div>
	</div>
	<div class="col-md-12">
		<label class="control-label">
			Carta en la que declare no tener relaciones laborales fuera del Instituto o con el Centro de Investigación y de Estudios Avanzados del Instituto, ni ejercer libremente la profesión fuera de la institución, debiendo señalar el compromiso de mantenerse así durante el tiempo que disfrute el otorgamiento del estímulo.
		</label>
	</div>
	<div class="form-group">
		<div class="row">
			<div class="col-sm-12">
				<div id="documentosCartaRelacionesIPN"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		documentosCartaRelacionesIPN();
	});

	function addAspiranteRequisitoActDocentes(estado){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionRelacionLab")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado:	estado
		}, function(data){
			if(data == 2){
				$('#solicitudSiLaboral').toggle("slow");
				$('#solicitudNoLaboral').hide();
			} else{
				$('#solicitudNoLaboral').toggle("slow");
				$('#solicitudSiLaboral').hide();
					
			}
		});
	}

	function documentosCartaRelacionesIPN(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	717,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#pkAspirante').val(),
			recargar:	'documentosCartaRelacionesIPN();'
		}, function(data) {
			$("#documentosCartaRelacionesIPN").html(data);
			$('.modal-backdrop').remove();
			addAspiranteRequisitoActDocentes($('#existe'+717).val() == 0 ? 0 : 2);
		});
	}

</script>