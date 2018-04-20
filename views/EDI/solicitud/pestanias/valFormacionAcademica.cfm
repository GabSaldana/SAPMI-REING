<cfprocessingdirective pageEncoding="utf-8">
<div class="row">
	<cfoutput><input type="hidden" id="pkPersona" value="#prc.pkPersona#"></cfoutput>
	<div class="col-md-12" id="CuentaFormacionAc" style="display: none">
		<div class="alert alert-success">
		    <span class="fa fa-check"></span> Usted cuenta con el grado de Maestría/Doctorado.
		</div>
	</div>
	<div class="col-md-12 noProcede" id="NoCuentaFormacionAc" style="display: none">
		<div class="alert alert-danger">
		    <span class="fa fa-times"></span> Usted <strong>No</strong> cuenta con el grado de Doctorado o Maestría.
		</div>
		<div class="col-md-12">
			<div class="row" id="divFormacionAcademica" style="display: inline;">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="fa fa-graduation-cap"></span> Formación Académica
						<i class="btn btn-primary btn-xs cerrarFormacionAcademica pull-right guiaCerrarEscolaridad" data-toggle="tooltip" title="Cerrar Formación Académica"><i class="fa fa-times"></i></i>
					</div>
					<div class="panel-body">
					<form name="form-formacionAcademica" id="form-formacionAcademica">
						<div class="form-group">
							<div class="row">
								<div class="col-sm-3">
									<label class="control-label"><span class="requerido">*</span>Nivel:</label>
									<select class="selectpicker col-sm-12 guiaNivelEscolaridad" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el nivel..." name="inNivel" id="inNivel" >
										<cfoutput query="prc.nivel">
											<option value="#PKNIVEL#">#NIVEL#</option>
										</cfoutput>
									</select>
								</div>
								<div class="col-sm-3">
									<label class="control-label"><span class="requerido">*</span>Institución:</label>
									<input type="text" class="form-control col-sm-12 guiaInstitucionEscolaridad" name="inInstitucion" id="inInstitucion">
								</div>
								<div class="col-sm-3">
									<label class="control-label"><span class="requerido">*</span>País</label>
									<select class="selectpicker col-sm-12 guiaPaisEscolaridad" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el pais..." name="inPais" id="inPais">
										<cfoutput query="prc.pais">
											<option value="#PK_PAIS#">#NOMBRE_PAIS#</option>
										</cfoutput>
									</select>
								</div>
								<div class="col-sm-3">
									<label class="control-label"></label>
									<div class="checkbox checkbox-primary">
										<input id="inCheckPNPC" class="styled guiaPNPCEscolaridad" type="checkbox"><label for="inCheckPNPC">¿Estuvo en PNPC?</label>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-sm-3">
									<label class="control-label"><span class="requerido">*</span>Campo de Conocimineto:</label>
									<input type="text" class="form-control col-sm-12 guiaCampoEscolaridad" name="inCampoConocimiento" id="inCampoConocimiento">
								</div>
								<div class="col-sm-3">
									<label class="control-label">Cédula Profesional:</label>
									<input type="text" class="form-control col-sm-12 guiaCedulaEscolaridad" name="inCedula" id="inCedula">
								</div>
								<div class="col-sm-2">
									<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
									<div class="input-group date">
										<input type="text" class="form-control time guiaInicioEscolaridad" id="inInicio" readonly="readonly" name="inInicio">
										<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
								<div class="col-sm-2">
									<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
									<div class="input-group date">
										<input type="text" class="form-control time guiaFinEscolaridad" id="inFin" readonly="readonly" name="inFin">
										<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
								<div class="col-sm-2">
									<label class="control-label"><span class="requerido">*</span>Fecha de Obtención:</label>
									<div class="input-group date">
										<input type="text" class="form-control time guiaObtencionEscolaridad" id="inObtencion" readonly="readonly" name="inObtencion">
										<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
									</div>
								</div>
							</div>				
							<br>
							<div class="col-sm-12">
								<input type="hidden" id="pkEscolaridad" value="">
								<div id="copiaDiplomaNuevo"></div>
							</div>
						</div>
						<div class="pull-right">
							<button type="button" class="btn btn-default cerrarFormacionAcademica guiaCerrarEscolaridad"><span class="fa fa-times"></span> Cancelar</button>
							<button type="button" class="btn btn-primary guiaGuardarEscolaridad" id="guardarEscolaridad"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
						</div>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
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
	$(document).ready(function(){
		iniciar();
	});

	function iniciar(){
		if(<cfoutput>#prc.formAc.consulta#</cfoutput> == 0)
			$('#NoCuentaFormacionAc').css('display', 'inline');
		else 
			$('#CuentaFormacionAc').css('display', 'inline');
	}
	$('body').undelegate('#guardarEscolaridad', 'click');
	$('body').on('click', '#guardarEscolaridad', function(){
		guardarEscolaridad();
	});

	function guardarEscolaridad(){
		var validacion = $("#form-formacionAcademica").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inNivel:			{required: true},
				inInstitucion:		{required: true},
				inPais:				{required: true},
				inCampoConocimiento:{required: true},
				inInicio:			{required: true},
				inFin:				{required: true},
				inObtencion:		{required: true},
				inCedula:			{number: true}
			}, messages: {
				inNivel:			"Ingresar el Nivel educativo.",
				inInstitucion:		"Ingresar la institución.",
				inPais:				"Ingresar el país.",
				inCampoConocimiento:"Ingresar el campo de conocimiento.",
				inInicio:			"Ingresar la fecha de inicio.",
				inFin:				"Ingresar la fecha de fin.",
				inObtencion:		"Ingresar la fecha de obtención.",
				inCedula:			"El valor debe ser numérico"
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			var cedula = $('#inCedula').val() != null && $('#inCedula').val() != NaN && $('#inCedula').val() != "" ? $('#inCedula').val() : 0;
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addEscolaridad")#</cfoutput>',{
				pkPersona:			$('#pkPersona').val(),
				inNivel:			$('#inNivel option:selected').val(),
				inInstitucion:		$('#inInstitucion').val(),
				inPais:				$('#inPais option:selected').val(),
				inCampoConocimiento:$('#inCampoConocimiento').val(),
				inCheckPNPC:		$('#inCheckPNPC:checked').length,
				inInicio:			$('#inInicio').val(),
				inFin:				$('#inFin').val(),
				inObtencion:		$('#inObtencion').val(),
				inCedula:			cedula
			}, function(data){
				if(data > 0 ){
					toastr.success('Escolaridad agregada correctamente.');
					addAspiranteRequisito();
				}
				else
					toastr.error('la escolaridad.','Problemas al agregar la');
			});
		}
	}

	function guardarEscolaridad(){
		var validacion = $("#form-formacionAcademica").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inNivel:			{required: true},
				inInstitucion:		{required: true},
				inPais:				{required: true},
				inCampoConocimiento:{required: true},
				inInicio:			{required: true},
				inFin:				{required: true},
				inObtencion:		{required: true},
				inCedula:			{number: true}
			}, messages: {
				inNivel:			"Ingresar el Nivel educativo.",
				inInstitucion:		"Ingresar la institución.",
				inPais:				"Ingresar el país.",
				inCampoConocimiento:"Ingresar el campo de conocimiento.",
				inInicio:			"Ingresar la fecha de inicio.",
				inFin:				"Ingresar la fecha de fin.",
				inObtencion:		"Ingresar la fecha de obtención.",
				inCedula:			"El valor debe ser numérico"
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			if($('#guardarEscolaridad').html() == '<span class="glyphicon glyphicon-floppy-disk"></span> Guardar'){
				var cedula = $('#inCedula').val() != null && $('#inCedula').val() != NaN && $('#inCedula').val() != "" ? $('#inCedula').val() : 0;
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addEscolaridad")#</cfoutput>',{
					pkPersona:			$('#pkPersona').val(),
					inNivel:			$('#inNivel option:selected').val(),
					inInstitucion:		$('#inInstitucion').val(),
					inPais:				$('#inPais option:selected').val(),
					inCampoConocimiento:$('#inCampoConocimiento').val(),
					inCheckPNPC:		$('#inCheckPNPC:checked').length,
					inInicio:			$('#inInicio').val(),
					inFin:				$('#inFin').val(),
					inObtencion:		$('#inObtencion').val(),
					inCedula:			cedula
				}, function(data){
					if(data > 0 ){
						toastr.success('Escolaridad agregada correctamente.');
						copiaDiplomaNuevo(data);
						$('#pkEscolaridad').val(data);
						$('#guardarEscolaridad').html('<span class="fa fa-lock"></span> Validar');
					}
					else
						toastr.error('la escolaridad.','Problemas al agregar la');
				});
			} else if($('#existe'+337).val() != 0){
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addValidarEscolaridad")#</cfoutput>',{
					pkEscolaridad:	$('#pkEscolaridad').val()		
				}, function(data){
					if(data > 0 ){
						toastr.success('Registro validado correctamente.');
						$('#guardarEscolaridad').html('<span class="fa fa-lock"></span> Validar Información');
						addAspiranteRequisito();
						limpiarCamposEscolaridad();
					}
					else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else{
				toastr.error('No se ha adjuntado la documentación');
			}
		}
	}

	function addAspiranteRequisito(){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.setValidacionFAcademica")#</cfoutput>',{
			pkAspirante : $('#pkAspirante').val()
		}, function(data){
			if(data.CONSULTA == 2){
				$('#CuentaFormacionAc').css('display', 'inline');
				$('#NoCuentaFormacionAc').css('display', 'none');
			} else{
				toastr.error('Usted aun <b>NO</b> cuenta con la escolaridad necesaria.');
			}
		});
	}

	function copiaDiplomaNuevo(convenio){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	337,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	convenio,
			recargar:	'copiaDiplomaNuevo('+convenio+');'
		}, function(data) {
			$("#copiaDiplomaNuevo").html(data);
			$('.modal-backdrop').remove();
		});
	}

	function limpiarCamposEscolaridad(){
		$('#inNivel').empty().selectpicker('refresh');
		$('#inPais').empty().selectpicker('refresh');
		$('#inInstitucion').val('');
		$('#inCampoConocimiento').val('');
		$('#inCedula').val('');
		$('#inInicio').val('');
		$('#inFin').val('');
		$('#inObtencion').val('');
		$('#pkEscolaridad').val('');
		$('#copiaDiplomaNuevo').html('');
	}
</script>
