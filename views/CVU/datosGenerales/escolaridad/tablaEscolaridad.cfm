<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<div class="row" id="divTableFormacionAcademica">
	<div id="toolbar">
		<button type="button" class="btn btn-default btn-outline dim btn-addEscolaridad guiaAddEscolaridad"><span class="glyphicon glyphicon-plus"></span> AGREGAR FORMACIÓN ACADÉMICA</button>
	</div>
	<table id="tablaEscolaridad" function ="getIndex" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-search-accent-neutralise="true" data-toolbar="#toolbar">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="nivel">Nivel</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="institucion">Institución</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="campoConocimiento">Campo de conocimiento</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="prc.escolaridad">
				<tr>
					<td class="text-center">#NIVEL#</td>
					<td class="text-center">#INSTITUCION#</td>
					<td class="text-center">#CAMPO_CONOCIMIENTO#</td>
					<td class="text-center">						
						<cfif ESTADO EQ 1>
							<button data-toggle="tooltip" class="btn btn-danger fa fa-trash eliminarEscolaridad guiaEliminarEscolaridad"	pkEscolaridad="#pkEscolaridad#" title="Eliminar"></button>
							<button data-toggle="tooltip" class="btn btn-warning fa fa-pencil editarEscolaridad guiaEditarEscolaridad"		pkEscolaridad="#pkEscolaridad#" title="Editar"></button>
						<cfelse>
							<button data-toggle="tooltip" class="btn btn-warning fa fa-pencil editarEscolaridad guiaEditarEscolaridad"		pkEscolaridad="#pkEscolaridad#" title="Editar"></button>
							<button data-toggle="tooltip" class="btn btn-success fa fa-file verDocEscolaridad guiaVerDocEscolaridad"		pkEscolaridad="#pkEscolaridad#" title="Comprobante"></button>
							<button data-toggle="tooltip" class="btn btn-primary fa fa-lock guiaValidado"									pkEscolaridad="#pkEscolaridad#" title="Validado"></button>
						</cfif>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</div>
<div class="row" id="divFormacionAcademica"style="display: none;">
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

<div class="row" id="divConsultaFormacionAcademica"style="display: none;">
	<div class="panel panel-primary">
		<div class="panel-heading">
				<span class="fa fa-graduation-cap"></span>Consulta de Formación Académica
				<i class="btn btn-primary  btn-xs cerrarConsultaFormacionAcademica pull-right guiaCerrarEscolaridad" data-toggle="tooltip" title="Cerrar Formación Académica"><i class="fa fa-times"></i> </i>
		</div>
		<div class="panel-body">
		<form name="form-consultaFormacionAcademica" id="form-consultaFormacionAcademica">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Nivel:</label>
						<select class="selectpicker col-sm-12 guiaNivelEscolaridad" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el nivel..." name="inoCnsultaNivel" id="inConsultaNivel" >
						</select>
					</div>
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Institución:</label>
						<input type="text" class="form-control col-sm-12 guiaInstitucionEscolaridad" name="inConsultaInstitucion" id="inConsultaInstitucion">
					</div>
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>País</label>
						<select class="selectpicker col-sm-12 guiaPaisEscolaridad" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el pais..." name="inConsultaPais" id="inConsultaPais">
						</select>
					</div>
					<div class="col-sm-3">
						<label class="control-label"></label>
						<div class="checkbox checkbox-primary">
							<input id="inConsultaCheckPNPC" class="styled guiaPNPCEscolaridad" type="checkbox"><label for="inConsultaCheckPNPC">¿Estuvo en PNPC?</label>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Campo de Conocimineto:</label>
						<input type="text" class="form-control col-sm-12 guiaCampoEscolaridad" name="inConsultaCampoConocimiento" id="inConsultaCampoConocimiento">
					</div>
					<div class="col-sm-3">
						<label class="control-label">Cédula Profesional:</label>
						<input type="text" class="form-control col-sm-12 guiaCedulaEscolaridad" name="inConsultaCedula" id="inConsultaCedula">
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaInicioEscolaridad" id="inConsultaInicio" readonly="readonly" name="inConsultaInicio">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaFinEscolaridad" id="inConsultaFin" readonly="readonly" name="inConsultaFin">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Obtención:</label>
						<div class="input-group date">
							<input type="text" class="form-control time  guiaObtencionEscolaridad" id="inConsultaObtencion" readonly="readonly" name="inConsultaObtencion">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-sm-12">
						<div id="copiaDiploma"></div>
					</div>
				</div>
			</div>
			<div class="pull-right">
				<button type="button" class="btn btn-default cerrarConsultaFormacionAcademica guiaCerrarEscolaridad"><span class="fa fa-times"></span> Cancelar</button>
				<button type="button" class="btn btn-primary guiaGuardarEscolaridad" id="guardarConsultaEscolaridad"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
				<button type="button" class="btn btn-primary guiaValidarEscolaridad" id="validarEscolaridad"><span class="fa fa-lock"></span> Validar</button>
			</div>
		</form>
		</div>
	</div>
</div>

<script type="text/javascript">

	$('#tablaEscolaridad').bootstrapTable();
	$('.date').datepicker({
		format:			'dd/mm/yyyy',
		language:		'es',
		calendarWeeks:	true,
		autoclose:		true,
		todayHighlight:	true
	});
	$('.selectpicker').selectpicker();

	$('body').undelegate('.btn-addEscolaridad', 'click');
	$('body').on('click', '.btn-addEscolaridad', function(){
		$('#divFormacionAcademica').toggle("slow");
		$('#divTableFormacionAcademica').toggle("slow");
	});

	$('body').undelegate('.cerrarFormacionAcademica', 'click');
	$('body').on('click', '.cerrarFormacionAcademica', function(){
		abrirCerrarEscolaridad();
	});

	function abrirCerrarEscolaridad(){
		$('#divFormacionAcademica').toggle("slow");
		$('#divTableFormacionAcademica').toggle("slow");
		getEscolaridad();
	}

	function abrirCerrarConsultaEscolaridad(){
		$('#divConsultaFormacionAcademica').toggle("slow");
		$('#divTableFormacionAcademica').toggle("slow");
	}

	$('body').undelegate('.editarEscolaridad', 'click');
	$('body').on('click', '.editarEscolaridad', function(){
		$('#guardarConsultaEscolaridad').attr('pkEscolaridad', $(this).attr('pkEscolaridad'));
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.consultarEscolaridad")#</cfoutput>', {
			pkEscolaridad: $('#guardarConsultaEscolaridad').attr('pkEscolaridad')
		}, function (data){
			if(data){
				$('#inConsultaNivel').empty();
				$('#inConsultaNivel').append('<option selected value="'+data.ESCOLARIDAD.DATA.PKNIVEL[0]+'">'+data.ESCOLARIDAD.DATA.NIVEL[0]+'</option>');
				for ( var i = 0; i < data.NIVEL.ROWCOUNT; i++ ) 
					if(data.ESCOLARIDAD.DATA.PKNIVEL[0] != data.NIVEL.DATA.PKNIVEL[i])
						$('#inConsultaNivel').append('<option value="'+data.NIVEL.DATA.PKNIVEL[i]+'">'+data.NIVEL.DATA.NIVEL[i]+'</option>').selectpicker('refresh');
				$('#inConsultaPais').empty();
				$('#inConsultaPais').append('<option selected value="'+data.PAISSELECT.DATA.PK_PAIS[0]+'">'+data.PAISSELECT.DATA.NOMBRE_PAIS[0]+'</option>');
				for ( var i = 0; i < data.PAIS.ROWCOUNT; i++ )
					if(data.PAISSELECT.DATA.PK_PAIS[0] !=data.PAIS.DATA.PK_PAIS[i])
						$('#inConsultaPais').append('<option value="'+data.PAIS.DATA.PK_PAIS[i]+'">'+data.PAIS.DATA.NOMBRE_PAIS[i]+'</option>');
				$('#inConsultaPais').selectpicker('refresh');
				$('#inConsultaCampoConocimiento').val(data.ESCOLARIDAD.DATA.CAMPO_CONOCIMIENTO[0]);
				$('#inConsultaObtencion').val(data.ESCOLARIDAD.DATA.OBTENCION[0]);
				$('#inConsultaInicio').val(data.ESCOLARIDAD.DATA.INICIO[0]);
				$('#inConsultaFin').val(data.ESCOLARIDAD.DATA.TERMINO[0]);
				$('#inConsultaInstitucion').val(data.ESCOLARIDAD.DATA.INSTITUCION[0]);
				$('#inConsultaCedula').val((data.ESCOLARIDAD.DATA.CEDULA[0] != null) ? data.ESCOLARIDAD.DATA.CEDULA[0] : '');
				$("#inConsultaCheckPNPC").prop('checked', (data.ESCOLARIDAD.DATA.PNCP[0] == 0 )? false: true);
				copiaDiploma();
			}
			else
				toastr.error('Escolaridad.','Problemas al mostrar la');
			abrirCerrarConsultaEscolaridad();
		});
	});

	$('body').undelegate('.cerrarConsultaFormacionAcademica', 'click');
	$('body').on('click', '.cerrarConsultaFormacionAcademica', function(){
		abrirCerrarConsultaEscolaridad();
	});

	$('body').undelegate('.eliminarEscolaridad', 'click');
	$('body').on('click', '.eliminarEscolaridad', function(){
		var pkEscolaridad = $(this).attr('pkEscolaridad');
		swal({
			title:				'Eliminar Escolaridad.',
			text:				"Esta acción es irreversible.\n¿Desea eliminar la escolaridad?",
			type:				"warning",
			showCancelButton:	true,
			confirmButtonText:	"Sí, Eliminar",
			cancelButtonText:	"No, Cancelar",
			closeOnConfirm:		true,
			closeOnCancel:		true
		}, function(isConfirm){
			if (isConfirm) {
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.eliminarEscolaridad")#</cfoutput>', {
					pkEscolaridad: pkEscolaridad
				},function(data){
					if(data > 0 ){
						toastr.success('','Escolaridad Eliminada.');
						getEscolaridad();
					} else
						toastr.error('Escolaridad.','Problemas al eliminar la');
				});
			} else 
				toastr.warning('ningun cambio.','No se realizó');
		});	
	});

	$('body').undelegate('#guardarConsultaEscolaridad', 'click');
	$('body').on('click', '#guardarConsultaEscolaridad', function(){
		guardarConsultaEscolaridad();
	});

	function guardarConsultaEscolaridad(){
		var validacion = $("#form-consultaFormacionAcademica").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inConsultaNivel:			{required:	true},
				inConsultaInstitucion:		{required:	true},
				inConsultaPais:				{required:	true},
				inConsultaCampoConocimiento:{required:	true},
				inConsultaInicio:			{required:	true},
				inConsultaFin:				{required:	true},
				inConsultaObtencion:		{required:	true},
				inConsultaCedula:			{number:	true}
			}, messages: {
				inConsultaNivel:			"Ingresar el Nivel educativo.",
				inConsultaInstitucion:		"Ingresar la institución.",
				inConsultaPais:				"Ingresar el país.",
				inConsultaCampoConocimiento:"Ingresar el campo de conocimiento.",
				inConsultaInicio:			"Ingresar la fecha de inicio.",
				inConsultaFin:				"Ingresar la fecha de fin.",
				inConsultaObtencion:		"Ingresar la fecha de obtención.",
				inConsultaCedula:			"El valor debe ser numérico"
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			var cedula = $('#inConsultaCedula').val() != null && $('#inConsultaCedula').val() != NaN && $('#inConsultaCedula').val() != "" ? $('#inConsultaCedula').val() : 0;
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.updateEscolaridad")#</cfoutput>',{
				pkPersona:			$('#pkPersona').val(),
				inNivel:			$('#inConsultaNivel option:selected').val(),
				inInstitucion:		$('#inConsultaInstitucion').val(),
				inPais:				$('#inConsultaPais option:selected').val(),
				inCampoConocimiento:$('#inConsultaCampoConocimiento').val(),
				inCheckPNPC:		$('#inConsultaCheckPNPC:checked').length,
				inInicio:			$('#inConsultaInicio').val(),
				inFin:				$('#inConsultaFin').val(),
				inObtencion:		$('#inConsultaObtencion').val(),
				inCedula:			cedula,
				pkEscolaridad:		$('#guardarConsultaEscolaridad').attr('pkEscolaridad')
			}, function(data){
				if(data > 0 ){
					toastr.success('Escolaridad editada correctamente.');
					getEscolaridad();
				}
				else
					toastr.error('la escolaridad.','Problemas al editar la');
			});
		}
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
						copiaDiplomaNuevo(data);
						$('#guardarEscolaridad').html('<span class="fa fa-lock"></span> Validar Información');
						getEscolaridad();
						abrirCerrarEscolaridad();
					}
					else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else{
				toastr.error('No se ha adjuntado la documentación');
			}
		}
	}

	$('body').undelegate('#validarEscolaridad', 'click');
	$('body').on('click', '#validarEscolaridad', function(){
		if($('#existe'+337).val() != 0){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addValidarEscolaridad")#</cfoutput>',{
				pkEscolaridad:	$('#guardarConsultaEscolaridad').attr('pkescolaridad'),
			}, function(data){
				if(data > 0 ){
					toastr.success('Registro validado correctamente.');
					copiaDiplomaNuevo(data);
					getEscolaridad();
				}
				else{
					getEscolaridad();
					abrirCerrarEscolaridad();
					toastr.error('el registro.','Problemas al agregar la');
					$('#divConsultarEscolaridad').toggle("slow");
					$('#divTableEscolaridad').toggle("slow");
				}
			});
		} else{
			toastr.error('No se ha adjuntado la documentación');
		}
	});

	$('body').undelegate('.verDocEscolaridad', 'click');
	$('body').on('click', '.verDocEscolaridad', function(){
		var pkObjeto = $(this).attr('pkEscolaridad');
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
			pkCatalogo:	337,
			pkObjeto:	pkObjeto
		}, function(data) {
			cargarDocumento(data);
		});
	});

	function copiaDiploma(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	337,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#guardarConsultaEscolaridad').attr('pkEscolaridad'),
			recargar:	'copiaDiploma();'
		}, function(data) {
			$("#copiaDiploma").html(data);
			$('.modal-backdrop').remove();
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