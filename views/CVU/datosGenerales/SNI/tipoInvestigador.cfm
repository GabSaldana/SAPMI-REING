<cfprocessingdirective pageEncoding="utf-8">

<div class="form-group" id="tipoInves">
	<div class="ibox-title">
	Redes de Investigadores o de expertos
	</div>
	<div class="row">
			<cfoutput>
				<cfloop index="i" from="1" to="#prc.redes.recordcount#">
					<div class="col-sm-2">
						<label class="control-label"></label>
						<div class="checkbox checkbox-primary">
							<input id="check#prc.redes.pkRed[i]#" class="styled red" pkRed="#prc.redes.pkRed[i]#"" type="checkbox"
								<cfloop index="j" from="1" to="#prc.redesCheck.recordcount#">
									<cfif #prc.redesCheck.pkRed[j]#  eq #prc.redes.pkRed[i]#> checked </cfif>
								</cfloop>
							><label for="check#prc.redes.pkRed[i]#">#prc.redes.red[i]#</label>
						</div>
					</div>
				</cfloop>
			</cfoutput>
		</div>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-12">
					<div id="documentosRed"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="hr-line-dashed"></div>

<script type="text/javascript">

	$(document).ready(function(){
		documentosRed();
	});
	
	$('body').undelegate('.red', 'click');
	$('body').on('click', '.red', function() {
		contenido = parseInt($(this).is(':checked') == true ? 2 : 0);
		pkRed = $(this).attr('pkRed');		
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.updateRed")#</cfoutput>',{
			pkPersona:	$('#pkPersona').val(),
			pkRed:		pkRed,
			contenido:	contenido
		},function(data){
			if(data > 1)
				toastr.success('','Información Actualizada.');
			else{
				toastr.error('','Error al actualizar los datos.');
				$('#check'+pkRed).prop('checked', contenido == 0 ? true : false);
			}
		});
	});


	function documentosRed(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	897,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#pkPersona').val(),
			recargar:	'documentosRed();'
		}, function(data) {
			$("#documentosRed").html(data);
			$('.modal-backdrop').remove();
		});
	}

</script>