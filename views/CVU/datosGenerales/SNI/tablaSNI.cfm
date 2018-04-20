<cfprocessingdirective pageEncoding="utf-8">

<div class="row" id="divTableSNI">
	<div id="toolbarSNI">
		<button type="button" class="btn btn-default btn-outline dim btn-addSNI guiaAddSNI"><span class="glyphicon glyphicon-plus"></span> Agregar nombramiento de SNI</button>
	</div>
	<table id="tablaSNI" function ="getIndex" class="table table-striped table-responsive" data-search="true" data-search-accent-neutralise="true" data-toolbar="#toolbarSNI">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="nivel">Nivel SNI</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="area">Area</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="periodo">Periodo</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput>
				<cfloop index="i" from="1" to="#prc.historial.recordcount#">				
					<tr>
						<td class="text-center">#prc.historial.NIVEL[i]#</td>
						<td class="text-center">#prc.historial.NOMBREAREA[i]#</td>
						<td class="text-center">#prc.historial.INICIO[i]# - #prc.historial.TERMINO[i]# </td>
						<td class="text-center">
							<cfif prc.historial.ESTADO[i] EQ 1>
								<button data-toggle="tooltip" class="btn btn-danger fa fa-trash elimiarSNI guiaEliminarSNI"	pkSNI="#prc.historial.pkSNI[i]#" title="Eliminar"></button>
								<button data-toggle="tooltip" class="btn btn-warning fa fa-pencil editarSNI guiaEditarSNI"	pkSNI="#prc.historial.pkSNI[i]#" title="Editar"></button>
							<cfelse>
								<button data-toggle="tooltip" class="btn btn-warning fa fa-pencil editarSNI guiaEditarSNI"	pkSNI="#prc.historial.pkSNI[i]#" title="Editar"></button>
								<button data-toggle="tooltip" class="btn btn-success fa fa-file verDocSNI guiaVerDocSNI"	pkSNI="#prc.historial.pkSNI[i]#" title="Comprobantes"></button>
								<button data-toggle="tooltip" class="btn btn-primary fa fa-lock guiaValidado"				pkSNI="#prc.historial.pkSNI[i]#" title="Validado"></button>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</cfoutput>
		</tbody>
	</table>
</div>

<div class="row" id="divAddSNI" style="display: none;">
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

<div class="row" id="divConsultarSNI" style="display: none;">
	<div class="panel panel-primary">
		<div class="panel-heading">
				<span class="fa fa-graduation-cap"></span> SNI
				<i class="btn btn-primary btn-xs cerrarConsultarSNI pull-right guiaCerrarSNI" data-toggle="tooltip" title="Cerrar SNI"><i class="fa fa-times"></i> </i>
		</div>
		<div class="panel-body">
		<form name="form-ConsultarSNI" id="form-ConsultarSNI">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Nivel:</label>
						<select class="selectpicker col-sm-12 guiaNivelSNI" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el nivel..." name="inConsultarNivelSNI" id="inConsultarNivelSNI" >
						</select>
					</div>
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Area:</label>
						<select class="selectpicker col-sm-12 guiaAreaSNI" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar el área..." name="inConsultarNivelSNI" id="inConsultarAreaSNI" >
						</select>
					</div>
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaInicioSNI" id="inConsultarInicioSNI" readonly="readonly" name="inConsultarInicioSNI">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-3">
						<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaFinSNI" id="inConsultarFinSNI" readonly="readonly" name="inConsultarFinSNI">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div id="documentosSNI"></div>
				</div>
			</div>
			<div class="pull-right">
				<button type="button" class="btn btn-default cerrarConsultarSNI guiaCerrarSNI"><span class="fa fa-times"></span> Cancelar</button>
				<button type="button" class="btn btn-primary guiaGuardarSNI" id="guardarConsultarSNI"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
				<button type="button" class="btn btn-primary guiaValidarSNI" id="validarSNI"><span class="fa fa-lock"></span> Validar</button>
			</div>
		</form>
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
	$('#tablaSNI').bootstrapTable();


	$('body').undelegate('.btn-addSNI', 'click');
	$('body').on('click', '.btn-addSNI', function(){
		$('#divAddSNI').toggle("slow");
		$('#divTableSNI').toggle("slow");
		$('#guardarSNI').html('<span class="glyphicon glyphicon-floppy-disk"></span> Guardar');
	});

	$('body').undelegate('.cerrarSNI', 'click');
	$('body').on('click', '.cerrarSNI', function(){
		$('#divAddSNI').toggle("slow");
		$('#divTableSNI').toggle("slow");
		getSNI();		
		limpiarCamposSNI();
	});

	$('body').undelegate('.editarSNI', 'click');
	$('body').on('click', '.editarSNI', function(){
		$('#guardarConsultarSNI').attr('pkSNI', $(this).attr('pkSNI'));
		$('#validarSNI').attr('pkSNI', $(this).attr('pkSNI'));
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.consultarSNI")#</cfoutput>', {
				pkSNI: $('#guardarConsultarSNI').attr('pkSNI')
			}, function (data){
				$('#inConsultarNivelSNI').empty();
				$('#inConsultarNivelSNI').append('<option selected value="'+data.SNI.DATA.PKNIVEL[0]+'">'+data.SNI.DATA.NIVEL[0]+'</option>').selectpicker('refresh');
				for ( var i = 0; i < data.NIVELSNI.ROWCOUNT; i++ ) 
					if(data.SNI.DATA.PKNIVEL[0] != data.NIVELSNI.DATA.PKNIVEL[i])
						$('#inConsultarNivelSNI').append('<option value="'+data.NIVELSNI.DATA.PKNIVEL[i]+'">'+data.NIVELSNI.DATA.NIVEL[i]+'</option>').selectpicker('refresh');
				$('#inConsultarAreaSNI').empty();
				$('#inConsultarAreaSNI').append('<option selected value="'+data.SNI.DATA.PKAREASNI[0]+'">'+data.SNI.DATA.NOMBREAREA[0]+'</option>').selectpicker('refresh');
				for ( var i = 0; i < data.AREASNI.ROWCOUNT; i++ ) 
					if(data.SNI.DATA.PKAREASNI[0] != data.AREASNI.DATA.PKAREASNI[i])
						$('#inConsultarAreaSNI').append('<option value="'+data.AREASNI.DATA.PKAREASNI[i]+'">'+data.AREASNI.DATA.NOMBREAREA[i]+'</option>').selectpicker('refresh');
				$('#inConsultarInicioSNI').val(data.SNI.DATA.INICIO[0]);
				$('#inConsultarFinSNI').val(data.SNI.DATA.TERMINO[0]);
				documentosSNI();
			});
		$('#divConsultarSNI').toggle("slow");
		$('#divTableSNI').toggle("slow");
	});

	$('body').undelegate('.cerrarConsultarSNI', 'click');
	$('body').on('click', '.cerrarConsultarSNI', function(){
		$('#divConsultarSNI').toggle("slow");
		$('#divTableSNI').toggle("slow");
		getSNI();
	});

	$('body').undelegate('.elimiarSNI', 'click');
	$('body').on('click', '.elimiarSNI', function() {
		pkSNI = $(this).attr('pkSNI');
		swal({
			title:				'Eliminar registro.',
			text:				"Esta acción es irreversible.",
			type:				"warning",
			showCancelButton:	true,
			confirmButtonText:	"Sí, Eliminar",
			cancelButtonText:	"No, Cancelar",
			closeOnConfirm:		true,
			closeOnCancel:		true
		}, function(isConfirm){
			if (isConfirm)
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.eliminarSNI")#</cfoutput>',{
					pkSNI:	pkSNI
				}, function(data){
					if(data){
						toastr.success('','Registro eliminado.');
						getSNI();
					}
					else
						toastr.error('Error al elimiar el registro.');
				});
			else
				toastr.warning('ningun cambio.','No se realizó');
		});
	});

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
						toastr.success('Registro validado correctamente.');
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
						getSNI();
					}
					else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else{
				toastr.error('No se ha adjuntado la documentación');
			}
		}
	});


	$('body').undelegate('#validarSNI', 'click');
	$('body').on('click', '#validarSNI', function(){
		if($('#existe'+356).val() != 0){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addValidarSNI")#</cfoutput>',{
				pkPersona:	$('#guardarConsultarSNI').attr('pkSNI'),
			}, function(data){
				if(data > 0 ){
					toastr.success('Registro validado correctamente.');
					documentosSNINuevo(data);
					getSNI();
				}
				else{
					getSNI();
					toastr.error('el registro.','Problemas al agregar la');
					$('#divConsultarSNI').toggle("slow");
					$('#divTableSNI').toggle("slow");
				}
			});
		} else{
			toastr.error('No se ha adjuntado la documentación');
		}
	});

	$('body').undelegate('#guardarConsultarSNI', 'click');
	$('body').on('click', '#guardarConsultarSNI', function(){
		var validacion = $("#form-ConsultarSNI").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inConsultarNivelSNI:	{required:	true},
				inConsultarInicioSNI:	{required:	true},
				inConsultarFinSNI:		{required:	true},
				inConsultarAreaSNI:		{required:	true}
			}, messages: {
				inConsultarNivelSNI:	"Ingresar el Nivel educativo.",
				inConsultarInicioSNI:	"Ingresar la fecha de inicio.",
				inConsultarFinSNI:		"Ingresar la fecha de fin.",
				inConsultarAreaSNI:		"Ingresar el área de SNI."
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.updateSNI")#</cfoutput>',{
				inNivel:	$('#inConsultarNivelSNI option:selected').val(),
				inInicio:	$('#inConsultarInicioSNI').val(),
				inFin:		$('#inConsultarFinSNI').val(),
				pkSNI:		$('#guardarConsultarSNI').attr('pkSNI'),
				inAreaSNI:	$('#inConsultarAreaSNI option:selected').val()
			}, function(data){
				if(data > 0 ){
					toastr.success('Registro actualizado correctamente.');
				}
				else
					toastr.error('el registro.','Problemas al actualizar la');
			});
		}
	});

	$('body').undelegate('.verDocSNI', 'click');
	$('body').on('click', '.verDocSNI', function(){
		var pkObjeto = $(this).attr('pkSNI');
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
			pkCatalogo:	896,
			pkObjeto:	pkObjeto
		}, function(data) {
			cargarDocumento(data);
		});
	});

	function documentosSNI(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	896,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#guardarConsultarSNI').attr('pkSNI'),
			recargar:	'documentosSNI();'
		}, function(data) {
			$("#documentosSNI").html(data);
			$('.modal-backdrop').remove();
		});
	}

	function documentosSNINuevo(convenio){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	896,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	convenio,
			recargar:	'documentosSNINuevo('+convenio+');'
		}, function(data) {
			$("#documentosSNINuevo").html(data);
			$('.modal-backdrop').remove();
		});
	}

	function limpiarCamposSNI(){
		$('#inConsultarNivelSNI').empty().selectpicker('refresh');
		$('#inConsultarAreaSNI').empty().selectpicker('refresh');
		$('#inConsultarInicioSNI').val('');
		$('#inConsultarFinSNI').val('');
		$('#pkSNI').val('');
		$('#documentosSNI').html('');
	}

</script>