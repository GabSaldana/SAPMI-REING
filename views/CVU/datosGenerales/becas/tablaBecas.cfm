<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<div class="row" id="divTableBecas">
	<div id="toolbarBecas">
		<button type="button" class="btn btn-default btn-outline dim btn-addBecas guiaAddBecas"><span class="glyphicon glyphicon-plus"></span> Agregar historial de Becas</button>
	</div>
	<table id="tablaBecas" function ="getIndex" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-search-accent-neutralise="true" data-toolbar="#toolbarBecas">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="nivel">Beca</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="periodo">Periodo</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput>
				<cfloop index="i" from="1" to="#prc.becas.recordcount#">
					<tr>
						<td class="text-center">#prc.becas.BECA[i]#</td>
						<td class="text-center">#prc.becas.INICIO[i]# - #prc.becas.TERMINO[i]# </td>
						<td class="text-center">
							<cfif prc.becas.ESTADO[i] EQ 1>
								<button data-toggle="tooltip" class="btn btn-danger fa fa-trash elimiarBecas guiaEliminarBecas"	pkBeca="#prc.becas.pkrEGISTRO[i]#" title="Eliminar"></button>
								<button data-toggle="tooltip" class="btn btn-warning fa fa-pencil editarBecas guiaEditarBecas"	pkBeca="#prc.becas.pkrEGISTRO[i]#" title="Editar"></button>
							<cfelse>
								<button data-toggle="tooltip" class="btn btn-success fa fa-file verDocBecas guiaVerDocBecas"	pkBeca="#prc.becas.pkrEGISTRO[i]#" title="Comprobante"></button>
								<button data-toggle="tooltip" class="btn btn-primary fa fa-lock guiaValidado"					pkBeca="#prc.becas.pkrEGISTRO[i]#" title="Validado"></button>
							</cfif>
						</td>
					</tr>
				</cfloop>
			</cfoutput>
		</tbody>
	</table>
</div>

<div class="row" id="divAddBeca" style="display: none;">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<span class="fa fa-graduation-cap"></span> Becas
			<i class="btn btn-primary btn-xs cerrarBeca pull-right guiaCerrarBecas" data-toggle="tooltip" title="Cerrar Beca"><i class="fa fa-times"></i></i>
		</div>
		<div class="panel-body">
		<form name="form-Beca" id="form-Beca">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Beca:</label>
						<select class="selectpicker col-sm-12 guiaTipoBeca" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar beca..." name="inTipoBeca" id="inTipoBeca" >
							<cfoutput query="prc.tipoBeca">
								<option value="#PKBECA#">#BECA#</option>
							</cfoutput>
						</select>
					</div>
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Nivel:</label>
						<select class="selectpicker col-sm-12 guiaNivelBeca" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar nivel..." name="inNivelBeca" id="inNivelBeca" >
						</select>
					</div>
					<div class="col-sm-4">
						<label class="control-label"></label>
						<div class="checkbox checkbox-primary">
							<input id="inCheckReceso guiaRecesoBeca" class="styled" type="checkbox"><label for="inCheckReceso">¿Se encuentra en receso?</label>
						</div>
					</div>
				</div>			
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaInicioBeca" id="inInicioBeca" readonly="readonly" name="inInicioBeca">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaFinBeca" id="inFinBeca" readonly="readonly" name="inFinBeca">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>				
				<br>
				<div class="col-sm-12">
					<input type="hidden" id="pkBeca" value="">
					<div id="docBecaNuevo"></div>
				</div>
			</div>
			<div class="pull-right">
				<button type="button" class="btn btn-default cerrarBeca guiaCerrarBecas"><span class="fa fa-times"></span> Cancelar</button>
				<button type="button" class="btn btn-primary guiaGuardarBeca" id="guardarBeca"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
			</div>
		</form>
		</div>
	</div>
</div>

<div class="row" id="divConsultarBeca" style="display: none;">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<span class="fa fa-graduation-cap"></span> Becas
			<i class="btn btn-primary btn-xs cerrarConsultarBeca pull-right guiaCerrarBecas" data-toggle="tooltip" title="Cerrar Beca"><i class="fa fa-times"></i></i>
		</div>
		<div class="panel-body">
		<form name="form-ConsultarBeca" id="form-ConsultarBeca">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Beca:</label>
						<select class="selectpicker col-sm-12 guiaTipoBeca" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar beca..." name="inConsultarTipoBeca" id="inConsultarTipoBeca">
						</select>
					</div>
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Nivel:</label>
						<select class="selectpicker col-sm-12 guiaNivelBeca" data-live-search="true" data-style="btn-success btn-outline" title="Ingresar nivel..." name="inConsultarNivelBeca" id="inConsultarNivelBeca" >
						</select>
					</div>
					<div class="col-sm-4">
						<label class="control-label"></label>
						<div class="checkbox checkbox-primary">
							<input id="inCheckConsultaReceso guiaRecesoBeca" class="styled" type="checkbox"><label for="inCheckConsultaReceso">¿Se encuentra en receso?</label>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaInicioBeca" id="inConsultarInicioBeca" readonly="readonly" name="inConsultarInicioBeca">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaFinBeca" id="inConsultarFinBeca" readonly="readonly" name="inConsultarFinBeca">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-sm-12">
						<div id="docBeca"></div>
					</div>
				</div>
			</div>
			<div class="pull-right">
				<button type="button" class="btn btn-default cerrarConsultarBeca guiaCerrarBecas"><span class="fa fa-times"></span> Cancelar</button>
				<button type="button" class="btn btn-primary guiaGuardarBeca" id="guardarConsultarBeca"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
				<button type="button" class="btn btn-primary guiaValidarBeca" id="validarBeca"><span class="fa fa-lock"></span> Validar</button>
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

	$('#tablaBecas').bootstrapTable();

	$('body').undelegate('.btn-addBecas', 'click');
	$('body').on('click', '.btn-addBecas', function(){
		$('#divAddBeca').toggle("slow");
		$('#divTableBecas').toggle("slow");
	});

	$('body').undelegate('.editarBecas', 'click');
	$('body').on('click', '.editarBecas', function(){
		abrirCerrarConsultarBeca();
	});

	$('body').undelegate('.cerrarBeca', 'click');
	$('body').on('click', '.cerrarBeca', function(){
		abrirCerrarBeca();
		getBecas();		
		limpiarCamposBecas();
	});

	$('body').undelegate('.cerrarConsultarBeca', 'click');
	$('body').on('click', '.cerrarConsultarBeca', function(){
		abrirCerrarConsultarBeca();
	});

	function abrirCerrarBeca(){
		$('#divAddBeca').toggle("slow");
		$('#divTableBecas').toggle("slow");
	}

	function abrirCerrarConsultarBeca(){
		$('#divConsultarBeca').toggle("slow");
		$('#divTableBecas').toggle("slow");
	}

	$('body').undelegate('#inTipoBeca', 'change');
	$('body').on('change', '#inTipoBeca', function(){
		pkBeca = $('#inTipoBeca option:selected').val();
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getNivelesBecas")#</cfoutput>', {
			pkBeca: pkBeca
		}, function(data){
			if(data){
				$('#inNivelBeca').empty();
				for ( var i = 0; i < data.NIVELES.ROWCOUNT; i++) 
					$('#inNivelBeca').append('<option value="'+data.NIVELES.DATA.PKNIVEL[i]+'">'+data.NIVELES.DATA.NIVEL[i]+'</option>').selectpicker('refresh');
			} else
				toastr.error('la información.','Problemas al mostrar la');
		});
	});

	$('body').undelegate('#inConsultarTipoBeca', 'change');
	$('body').on('change', '#inConsultarTipoBeca', function(){
		pkBeca = $('#inConsultarTipoBeca option:selected').val();
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.getNivelesBecas")#</cfoutput>', {
			pkBeca: pkBeca
		}, function(data){
			if(data){
				$('#inConsultarNivelBeca').empty();
				for ( var i = 0; i < data.NIVELES.ROWCOUNT; i++) 
					$('#inConsultarNivelBeca').append('<option value="'+data.NIVELES.DATA.PKNIVEL[i]+'">'+data.NIVELES.DATA.NIVEL[i]+'</option>').selectpicker('refresh');
			} else
				toastr.error('la información.','Problemas al mostrar la');
		});
	});

	$('body').undelegate('#guardarBeca', 'click');
	$('body').on('click', '#guardarBeca', function(){
		var validacion = $("#form-Beca").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inTipoBeca:		{required: true},
				inNivelBeca:	{required: true},
				inInicioBeca:	{required: true},
				inFinBeca:		{required: true}
			}, messages: {
				inTipoBeca:		"Ingresar el tipo de beca.",
				inNivelBeca:	"Ingresar el nivel de la beca.",
				inInicioBeca:	"Ingresar la fecha de inicio.",
				inFinBeca:		"Ingresar la fecha de fin."
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			if($('#guardarBeca').html() == '<span class="glyphicon glyphicon-floppy-disk"></span> Guardar'){
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addBecas")#</cfoutput>',{
					pkPersona:			$('#pkPersona').val(),
					inTipoBeca:			$('#inTipoBeca option:selected').val(),
					inNivelBeca:		$('#inNivelBeca option:selected').val(),
					inCheckReceso:		$('#inCheckReceso:checked').length,
					inInicio:			$('#inInicioBeca').val(),
					inFin:				$('#inFinBeca').val()
				}, function(data){
					if(data > 0 ){
						toastr.success('Registro agregado correctamente.');
						docBecaNuevo(data);
						$('#pkBeca').val(data);
						$('#guardarBeca').html('<span class="fa fa-lock"></span> Validar');
					} else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else if($('#existe'+399).val() != 0){
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addValidarBecas")#</cfoutput>',{
					pkPersona:	$('#pkBeca').val()		
				}, function(data){
					if(data > 0 ){
						toastr.success('Registro validado correctamente.');
						docBecaNuevo(data);
						$('#guardarBeca').html('<span class="fa fa-lock"></span> Validar Información');
						getBecas();
					}
					else
						toastr.error('el registro.','Problemas al agregar la');
				});
			} else{
				toastr.error('No se ha adjuntado la documentación');
			}

		}
	});

	$('body').undelegate('.elimiarBecas', 'click');
	$('body').on('click', '.elimiarBecas', function() {
		pkBeca = $(this).attr('pkBeca');
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
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.eliminarBeca")#</cfoutput>',{
					pkBeca:	pkBeca
				}, function(data){
					if(data){
						toastr.success('','Registro eliminado.');
						getBecas();
					}
					else
						toastr.error('Error al elimiar el registro.');
				});
			else
				toastr.warning('ningun cambio.','No se realizó');
		});
	});

	$('body').undelegate('.editarBecas', 'click');
	$('body').on('click', '.editarBecas', function(){
		$('#guardarConsultarBeca').attr('pkBeca', $(this).attr('pkBeca'));
		$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.consultarBeca")#</cfoutput>', {
			pkBeca: $('#guardarConsultarBeca').attr('pkBeca')
		}, function (data){
			if(data){
				$('#inConsultarTipoBeca').empty();
				$('#inConsultarTipoBeca').append('<option selected value="'+data.BECA.DATA.PKTIPOBECA[0]+'">'+data.BECA.DATA.TIPOBECA[0]+'</option>').selectpicker('refresh');
				for ( var i = 0; i < data.CATBECAS.ROWCOUNT; i++ ) 
					if(data.BECA.DATA.PKTIPOBECA[0] != data.CATBECAS.DATA.PKBECA[i])
						$('#inConsultarTipoBeca').append('<option value="'+data.CATBECAS.DATA.PKBECA[i]+'">'+data.CATBECAS.DATA.BECA[i]+'</option>').selectpicker('refresh');
				$('#inConsultarNivelBeca').empty();
				$('#inConsultarNivelBeca').append('<option selected value="'+data.BECA.DATA.PKNIVEL[0]+'">'+data.BECA.DATA.NIVEL[0]+'</option>').selectpicker('refresh');
				for ( var i = 0; i < data.NIVEL.ROWCOUNT; i++ ) 
					if(data.BECA.DATA.PKNIVEL[0] != data.NIVEL.DATA.PKNIVEL[i])
						$('#inConsultarNivelBeca').append('<option value="'+data.NIVEL.DATA.PKNIVEL[i]+'">'+data.NIVEL.DATA.NIVEL[i]+'</option>').selectpicker('refresh');
				$('#inConsultarInicioBeca').val(data.BECA.DATA.INICIO[0]);
				$('#inConsultarFinBeca').val(data.BECA.DATA.TERMINO[0]);
				$('#inCheckConsultaReceso').prop('checked', data.BECA.DATA.RECESO[0] == 0 ? false : true);
				abrirCerrarConsultarBeca();
				docBeca();
			} else
				toastr.error('Error al mostrar los datos.');
		});
	});

	$('body').undelegate('#guardarConsultarBeca', 'click');
	$('body').on('click', '#guardarConsultarBeca', function(){
		var pkBeca = $(this).attr('pkBeca');
		var validacion = $("#form-ConsultarBeca").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inConsultarTipoBeca:	{required: true},
				inConsultarNivelBeca:	{required: true},
				inConsultarInicioBeca:	{required: true},
				inConsultarFinBeca:		{required: true}
			}, messages: {
				inConsultarTipoBeca:	"Ingresar el tipo de beca.",
				inConsultarNivelBeca:	"Ingresar el nivel de la beca.",
				inConsultarInicioBeca:	"Ingresar la fecha de inicio.",
				inConsultarFinBeca:		"Ingresar la fecha de fin."
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.updateBeca")#</cfoutput>',{
				inTipoBeca:			$('#inConsultarTipoBeca option:selected').val(),
				inNivelBeca:		$('#inConsultarNivelBeca option:selected').val(),
				inCheckReceso:		$('#inCheckConsultaReceso:checked').length,
				inInicio:			$('#inConsultarInicioBeca').val(),
				inFin:				$('#inConsultarFinBeca').val(),
				pkBeca:				pkBeca
			}, function(data){
				if(data > 0 ){
					toastr.success('Beca agregada correctamente.');
					getBecas();
					abrirCerrarConsultarBeca();
				}
				else
					toastr.error('la beca.','Problemas al agregar la');
			});
		}
	});

	function docBeca(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	399,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	$('#guardarConsultarBeca').attr('pkBeca'),
			recargar:	'docBeca();'
		}, function(data) {
			$("#docBeca").html(data);
			$('.modal-backdrop').remove();
		});
	}

	$('body').undelegate('.verDocBecas', 'click');
	$('body').on('click', '.verDocBecas', function(){
		var pkObjeto = $(this).attr('pkBeca');
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultarNombreArchivo")#</cfoutput>', {
			pkCatalogo:	399,
			pkObjeto:	pkObjeto
		}, function(data) {
			cargarDocumento(data);
		});
	});

	$('body').undelegate('#validarBeca', 'click');
	$('body').on('click', '#validarBeca', function(){
		if($('#existe'+399).val() != 0){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addValidarBecas")#</cfoutput>',{
				pkPersona:	$('#guardarConsultarBeca').attr('pkBeca'),
			}, function(data){
				if(data > 0 ){
					toastr.success('Registro validado correctamente.');
					docBeca(data);
					getBecas();
				}
				else{
					getBecas();
					toastr.error('el registro.','Problemas al agregar la');
					$('#divConsultarBecaa').toggle("slow");
					$('#divTableBecas').toggle("slow");
				}
			});
		} else{
			toastr.error('No se ha adjuntado la documentación');
		}
	});

	function limpiarCampos(){
		$('#inTipoBeca').empty().selectpicker('refresh');
		$('#inNivelBeca').empty().selectpicker('refresh');
		$('#inCheckReceso').attr('checked', 'false');
		$('#inInicioBeca').val('');
		$('#inFinBeca').val('');
		$('#pkBeca').val('');
		$('#docBecaNuevo').html('');
	}

	function docBecaNuevo(convenio){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos:	399,
			requerido:	1,
			extension:	JSON.stringify(['txt', 'pdf']),
			convenio:	convenio,
			recargar:	'docBecaNuevo('+convenio+');'
		}, function(data) {
			$("#docBecaNuevo").html(data);
			$('.modal-backdrop').remove();
		});
	}

</script>