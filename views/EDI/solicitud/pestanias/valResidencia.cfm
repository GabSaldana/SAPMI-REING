<cfprocessingdirective pageEncoding="utf-8">
<div class="row">
	<div class="col-md-12" id="solicitudResidencia" style="display: none;">
		<div class="alert alert-success">
		    <span class="fa fa-check"></span> Usted ha cargado la solicitud de residencia.
		</div>
	</div>
	<div class="col-md-12 noProcede" id="solicitudNoResidencia" style="display: none;">
		<div class="alert alert-danger">
		    <span class="fa fa-times"></span> Usted aún <strong>No</strong> ha cargado la solicitud de residencia.<br>
		    No puede participar en el programa.
		</div>
	</div>

	<div class="col-md-12">
		<label class="control-label">
			Solicitud de residencia.
		</label>
	</div>
	<div class="col-md-12">
		<div class="row">
			<div class="col-sm-12">
				<div id="docSolicitudResidencia"></div>
			</div>
		</div>
	</div>

	<div class="col-md-12">
		<label class="control-label">
			Mensaje.
		</label>
	</div>
	<div class="col-md-12">
		<textarea id="mensajeSolicitud" rows="4" cols="50"><cfoutput>#prc.MENSAJE.MENSAJE[1]#</cfoutput></textarea>
		<br>
		<button type="button" class="btn btn-primary" id="addMensaje"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar Mensaje</button>
	</div>

</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		docSolicitudResidencia();
		existeSolResidencia();
	});

	function existeSolResidencia(){
		if($("#mensajeSolicitud").val() != "" && $('#existe'+860).val() != 0){
			$('#solicitudResidencia').css('display', 'inline');
			$('#solicitudNoResidencia').css('display', 'none');
		} else {
			$('#solicitudNoResidencia').css('display', 'inline');
			$('#solicitudResidencia').css('display', 'none');
		}
	}

	function docSolicitudResidencia(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	860,
			requerido:	0,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#pkAspirante').val(),
			recargar:	'docSolicitudResidencia();'
		}, function(data) {
			$("#docSolicitudResidencia").html(data);
			$('.modal-backdrop').remove();
			addAspiranteSolicitudResidencia($('#existe'+860).val() != 0 ? 2 : 0, $('#mensajeSolicitud').val() !=  "" ? 2 : 0);
		});
	}

	function addAspiranteSolicitudResidencia(solicitud, mensaje){
		var estado = (solicitud == 2 && mensaje == 2) ? 2 : 0;
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionsolResidencia")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val(),
			estado:	estado
		}, function(data){
			existeSolResidencia();
		});
	}

	$('body').undelegate('#addMensaje', 'click');
	$('body').on('click', '#addMensaje', function(){
		if($('#mensajeSolicitud').val() !=  "")
			$.post('<cfoutput>#event.buildLink("EDI.solicitud.addMensajeAspiranteProceso")#</cfoutput>', {
				pkAspirante: 	$('#pkAspirante').val(),
				mensaje: 		$('#mensajeSolicitud').val()
			}, function(data){
				if(data > 0)
					toastr.success('Se ha actualizado la información');
				else
					toastr.error('Error en el servidor, intente más tarde');
				existeSolResidencia();
			});
		else
			toastr.error('No se adjuntó ningún mensaje.', 'Error');
		addAspiranteSolicitudResidencia($('#existe'+860).val() != 0 ? 2 : 0, $('#mensajeSolicitud').val() !=  "" ? 2 : 0);
	});

</script>
