<cfprocessingdirective pageEncoding="utf-8">

<div class="row">
	<div class="col-md-12">
	</div>
	<div class="col-md-12">
	</div>
	<cfif prc.plazaNom.sni eq 0>
	<div class="col-md-12 noProcede" id="divPlazaNomSelect">
		<div class="alert alert-danger">
		    <span class="fa fa-times"></span> Usted <strong>No</strong> cuenta nombramiento de SNI vigente al 1 de abril del año en que se le otorgue el estímulo.<br>
		    <b>Agregue en el siguiente panel el nombramiento SNI</b>
		</div>
		<div class="row" id="divAddSNI" style="display: inline;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<span class="fa fa-graduation-cap"></span> SNI
					<i class="btn btn-primary btn-xs cerrarSNI pull-right guiaCerrarSNI" data-toggle="tooltip" title="Cerrar SNI"><i class="fa fa-times"></i></i>
				</div>
				<div class="panel-body">
				<form name="form-SNI" id="form-SNI">
					<div class="form-group">
						<div class="row">
							<div class="col-sm-3">
								<label class="control-label"><span class="requerido">*</span>Nivel:</label>
								<select class="selectpicker col-sm-12 guiaNivelSNI" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el nivel..." name="inNivelSNI" id="inNivelSNI" >
									<cfoutput query="prc.nivelSNI">
										<option value="#PKNIVEL#">#NIVEL#</option>
									</cfoutput>
								</select>
							</div>
							<div class="col-sm-3">
								<label class="control-label"><span class="requerido">*</span>Area:</label>
								<select class="selectpicker col-sm-12 guiaAreaSNI" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el área..." name="inAreaSNI" id="inAreaSNI" >
									<cfoutput query="prc.areaSNI">
										<option value="#PKAREASNI#">#NOMBREAREA#</option>
									</cfoutput>
								</select>
							</div>
							<div class="col-sm-3">
								<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
								<div class="input-group date">
									<input type="text" class="form-control time guiaInicioSNI" id="inInicioSNI" readonly="readonly" name="inInicioSNI">
									<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								</div>
							</div>
							<div class="col-sm-3">
								<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
								<div class="input-group date">
									<input type="text" class="form-control time guiaFinSNI" id="inFinSNI" readonly="readonly" name="inFinSNI">
									<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								</div>
							</div>					
						</div>
						<br>
						<div class="col-sm-12">
							<input type="hidden" id="pkSNI" value="">
							<div id="documentosSNINuevo"></div>
						</div>
					</div>
					<div class="pull-right">
						<button type="button" class="btn btn-default cerrarSNI guiaCerrarSNI"><span class="fa fa-times"></span> Cancelar</button>
						<button type="button" class="btn btn-primary guiaGuardarSNI" id="guardarSNI"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
	<cfelse>
	<div class="col-sm-12">
		<div class="alert alert-success">
		    <span class="fa fa-check"></span> Usted cuenta nombramiento de SNI vigente al 1 de abril del año en que se le otorgue el estímulo.
		</div>
	</div>
	</cfif>
</div>
<script type="text/javascript">
	
	$('.date').datepicker({
		format:			'mm/dd/yyyy',
		language:		'es',
		calendarWeeks:	true,
		autoclose:		true,
		todayHighlight:	true
	});
	$('.selectpicker').selectpicker();

	$('body').undelegate('#guardarSNI', 'click');
	$('body').on('click', '#guardarSNI', function(){
		var validacion = $("#form-SNI").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inNivelSNI:			{required:	true},
				inInicioSNI:		{required:	true},
				inFinSNI:			{required:	true},
				inAreaSNI:			{required:	true}
			}, messages: {
				inNivelSNI:			"Ingresar el Nivel educativo.",
				inInicioSNI:		"Ingresar la fecha de inicio.",
				inFinSNI:			"Ingresar la fecha de fin.",
				inAreaSNI:			"Ingresar el área de SNI."
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			if($('#guardarSNI').html() == '<span class="glyphicon glyphicon-floppy-disk"></span> Guardar'){
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addSNI")#</cfoutput>',{
					pkPersona:			$('#pkPersona').val(),
					inNivelSNI:			$('#inNivelSNI option:selected').val(),
					inInicioSNI:		$('#inInicioSNI').val(),
					inFinSNI:			$('#inFinSNI').val(),
					inAreaSNI:			$('#inAreaSNI option:selected').val()
				}, function(data){
					if(data > 0 ){
						toastr.success('Registro agregado correctamente.');
						documentosSNINuevo(data);
						$('#pkSNI').val(data);
						$('#guardarSNI').html('<span class="fa fa-lock"></span> Validar');
					}
					else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else if($('#existe'+356).val() != 0){
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addValidarSNI")#</cfoutput>',{
					pkPersona:	$('#pkSNI').val()		
				}, function(data){
					if(data > 0 ){
						toastr.success('Registro validado correctamente.');
						documentosSNINuevo(data);
						$('#guardarSNI').html('<span class="fa fa-lock"></span> Validar Información');
						$.post('<cfoutput>#event.buildLink("EDI.solicitud.getPlazaNom")#</cfoutput>',{
							pkAspirante : $('#pkAspirante').val()
						}, function(data){
							if (data.SNI > 1)
								$('#divPlazaNomSelect').html('<div class="col-sm-12"><div class="alert alert-success"><span class="fa fa-check"></span> Usted cuenta nombramiento de SNI vigente al 1 de abril del año en que se le otorgue el estímulo.</div></div>');
							else{
								toastr.error('Usted aun <b>NO</b> cuenta con nombramiento SNI <b>VIGENTE</b>.');
								$('#inFinSNI').val('');$('#inInicioSNI').val('');$('.selectpicker').selectpicker('deselectAll');
								$('#documentosSNINuevo').html('');
								$('#pkSNI').val('');
								$('#guardarSNI').html('<span class="glyphicon glyphicon-floppy-disk"></span> Guardar');
							}
						});
					}
					else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else{
				toastr.error('No se ha adjuntado la documentación');
			}
		}
	});


	function documentosSNINuevo(convenio){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	356,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	convenio,
			recargar:	'documentosSNINuevo('+convenio+');'
		}, function(data) {
			$("#documentosSNINuevo").html(data);
			$('.modal-backdrop').remove();
		});
	}
</script>