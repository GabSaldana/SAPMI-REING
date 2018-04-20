<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<div class="row" id="divTableEmpleos">
	<div id="toolbarEmpleos">
		<button type="button" class="btn btn-default btn-outline dim btn-addEmpleo guiaAddEmpleo"><span class="glyphicon glyphicon-plus"></span> AGREGAR EMPLEO</button>
	</div>
	<table id="tablaEmpleos" function ="getIndex" class="table table-striped table-responsive" data-pagination="true" data-search="true" data-search-accent-neutralise="true" data-toolbar="#toolbarEmpleos">
		<thead>
			<tr>
				<th class="text-center	col-md-2" data-sortable="true" data-field="nivel">LUGAR</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="institucion">PUESTO</th>
				<th class="text-center	col-md-4" data-sortable="true" data-fiels="campoConocimiento">Periodo</th>
				<th class="text-center	col-md-2" data-sortable="true" data-field="acciones">Acciones</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="prc.empleos">
				<tr>
					<td class="text-center">#LUGAR#</td>
					<td class="text-center">#PUESTO#</td>
					<td class="text-center">#INICIO# - #TERMINO#</td>
					<td class="text-center">
						<button data-toggle="tooltip" class="btn btn-danger fa fa-trash eliminarEmpleo guiaEliminarEmpleo"	pkEmpleo="#PKEMLEOS#" title="Eliminar"></button>
						<button data-toggle="tooltip" class="btn btn-warning fa fa-pencil editarEmpleo guiaEditarEmpleo"	pkEmpleo="#PKEMLEOS#" title="Editar"></button>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</div>

<div class="row" id="divAddEmpleo"style="display: none;">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<span class="fa fa-building"></span> Empleos
			<i class="btn btn-primary btn-xs cerrarAddEmpleo pull-right guiaCerrarEmpleo" data-toggle="tooltip" title="Cerrar agregar de Empleos"><i class="fa fa-times"></i></i>
		</div>
		<div class="panel-body">
		<form name="form-AddEmpleo" id="form-AddEmpleo">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Lugar:</label>
						<input type="text" class="form-control col-sm-12 guiaLugarEmpleo" name="inLugarEmpleo" id="inLugarEmpleo">
						</select>
					</div>
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Puesto:</label>
						<input type="text" class="form-control col-sm-12 guiaPuestoEmpleo" name="inPuestoEmpleo" id="inPuestoEmpleo">
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaInicioEmpleo" id="inInicioEmpleo" readonly="readonly" name="inInicioEmpleo">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaFinEmpleo" id="inFinEmpleo" readonly="readonly" name="inFinEmpleo">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			<div class="pull-right">
				<button type="button" class="btn btn-default cerrarAddEmpleo guiaCerrarEmpleo"><span class="fa fa-times"></span> Cancelar</button>
				<button type="button" class="btn btn-primary guiaGuardarEmpleo" id="guardarEmpleo"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
			</div>
		</form>
		</div>
	</div>
</div>

<div class="row" id="divConsultarEmpleo"style="display: none;">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<span class="fa fa-building"></span> Empleos
			<i class="btn btn-primary btn-xs cerrarConsultarEmpleo pull-right guiaCerrarEmpleo" data-toggle="tooltip" title="Cerrar consulta de Empleos"><i class="fa fa-times"></i></i>
		</div>
		<div class="panel-body">
		<form name="form-ConsultarEmpleo" id="form-ConsultarEmpleo">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Lugar:</label>
						<input type="text" class="form-control col-sm-12 guiaLugarEmpleo" name="inConsultarLugarEmpleo" id="inConsultarLugarEmpleo">
						</select>
					</div>
					<div class="col-sm-4">
						<label class="control-label"><span class="requerido">*</span>Puesto:</label>
						<input type="text" class="form-control col-sm-12 guiaPuestoEmpleo" name="inConsultarPuestoEmpleo" id="inConsultarPuestoEmpleo">
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Inicio:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaInicioEmpleo" id="inConsultarInicioEmpleo" readonly="readonly" name="inConsultarInicioEmpleo">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
					<div class="col-sm-2">
						<label class="control-label"><span class="requerido">*</span>Fecha de Fin:</label>
						<div class="input-group date">
							<input type="text" class="form-control time guiaFinEmpleo" id="inConsultarFinEmpleo" readonly="readonly" name="inConsultarFinEmpleo">
							<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
						</div>
					</div>
				</div>
			</div>
			<div class="pull-right">
				<button type="button" class="btn btn-default cerrarConsultarEmpleo guiaCerrarEmpleo"><span class="fa fa-times"></span> Cancelar</button>
				<button type="button" class="btn btn-primary guiaGuardarEmpleo" id="guardarConsultarEmpleo"><span class="glyphicon glyphicon-floppy-disk"></span> Guardar</button>
			</div>
		</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	$('#tablaEmpleos').bootstrapTable();
	$('.date').datepicker({
		format:			'dd/mm/yyyy',
		language:		'es',
		calendarWeeks:	true,
		autoclose:		true,
		todayHighlight:	true
	});

	$('.selectpicker').selectpicker();

	$('body').undelegate('.btn-addEmpleo', 'click');
	$('body').on('click', '.btn-addEmpleo', function(){
		$('#divAddEmpleo').toggle("slow");
		$('#divTableEmpleos').toggle("slow");
	});


	$('body').undelegate('.cerrarAddEmpleo', 'click');
	$('body').on('click', '.cerrarAddEmpleo', function(){
		abrirCerrarEmpleo();
	});

	$('body').undelegate('.cerrarConsultarEmpleo', 'click');
	$('body').on('click', '.cerrarConsultarEmpleo', function(){
		abrirCerrarConsultaEmpleo();
	});

	function abrirCerrarEmpleo(){
		$('#divAddEmpleo').toggle("slow");
		$('#divTableEmpleos').toggle("slow");
	}

	function abrirCerrarConsultaEmpleo(){
		$('#divConsultarEmpleo').toggle("slow");
		$('#divTableEmpleos').toggle("slow");
	}

	$('body').undelegate('.eliminarEmpleo', 'click');
	$('body').on('click', '.eliminarEmpleo', function() {
		pkEmpleo = $(this).attr('pkEmpleo');
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
				$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.eliminarEmpleo")#</cfoutput>',{
					pkEmpleo:	pkEmpleo
				}, function(data){
					if(data){
						toastr.success('','Registro eliminado.');
						getEmpleos();
					}
					else
						toastr.error('Error al eliminar el registro.');
				});
			else
				toastr.warning('ningun cambio.','No se realizó');
		});
	});

	$('body').undelegate('#guardarEmpleo', 'click');
	$('body').on('click', '#guardarEmpleo', function(){
		var validacion = $("#form-AddEmpleo").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inPuestoEmpleo:		{required:	true},
				inLugarEmpleo:		{required:	true},
				inInicioEmpleo:		{required:	true},
				inFinEmpleo:		{required:	true}
			}, messages: {
				inPuestoEmpleo:		"Ingresar el puesto.",
				inLugarEmpleo:		"Ingresar el lugar.",
				inInicioEmpleo:	"Ingresar la fecha de inicio.",
				inFinEmpleo:		"Ingresar la fecha de fin."
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.addEmpleos")#</cfoutput>',{
				pkPersona:		$('#pkPersona').val(),
				inPuestoEmpleo:	$('#inPuestoEmpleo').val(),
				inLugarEmpleo:	$('#inLugarEmpleo').val(),
				inInicioEmpleo:	$('#inInicioEmpleo').val(),
				inFinEmpleo:	$('#inFinEmpleo').val(),
			}, function(data){
				if(data > 0 ){
					toastr.success('Registro agregado correctamente.');
					getEmpleos();
				}
				else
					toastr.error('el registro.','Problemas al agregar la');
			});
		}
	});

	$('body').undelegate('#guardarConsultarEmpleo', 'click');
	$('body').on('click', '#guardarConsultarEmpleo', function(){
		var pkEmpleo = $(this).attr('pkEmpleo');
		var validacion = $("#form-ConsultarEmpleo").validate({
			ignore: ':not(select:hidden, input:visible, textarea:visible)',
			rules: {
				inConsultarLugarEmpleo:	{required:	true},
				inConsultarPuestoEmpleo:{required:	true},
				inConsultarInicioEmpleo:{required:	true},
				inConsultarFinEmpleo:	{required:	true}
			}, messages: {
				inConsultarLugarEmpleo:	"Ingresar el puesto.",
				inConsultarPuestoEmpleo:"Ingresar el lugar.",
				inConsultarInicioEmpleo:"Ingresar la fecha de inicio.",
				inConsultarFinEmpleo:	"Ingresar la fecha de fin."
			},submitHandler: function(form) {
				return true;
			}
		});
		if(validacion.form()){
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.updateEmpleo")#</cfoutput>',{
				inLugar:	$('#inConsultarLugarEmpleo').val(),
				inPuesto:	$('#inConsultarPuestoEmpleo').val(),
				inInicio:	$('#inConsultarInicioEmpleo').val(),
				inFin:		$('#inConsultarFinEmpleo').val(),
				pkEmpleo:	pkEmpleo
			}, function(data){
				if(data > 0 ){
					toastr.success('Escolaridad editada correctamente.');
					getEmpleos();
					abrirCerrarConsultaEmpleo();
				}
				else
					toastr.error('la escolaridad.','Problemas al editar la');
			});
		}
	});

	$('body').undelegate('.editarEmpleo', 'click');
	$('body').on('click', '.editarEmpleo', function(){
		$('#guardarConsultarEmpleo').attr('pkEmpleo', $(this).attr('pkEmpleo'));
			$.post('<cfoutput>#event.buildLink("CVU.datosGenerales.consultarEmpleo")#</cfoutput>', {
				pkEmpleo: $('#guardarConsultarEmpleo').attr('pkEmpleo')
			}, function (data){
				if(data){
					$('#inConsultarInicioEmpleo').val(data.EMPLEO.DATA.INICIO[0]);
					$('#inConsultarFinEmpleo').val(data.EMPLEO.DATA.TERMINO[0]);
					$('#inConsultarPuestoEmpleo').val(data.EMPLEO.DATA.PUESTO[0]);
					$('#inConsultarLugarEmpleo').val(data.EMPLEO.DATA.LUGAR[0]);
					abrirCerrarConsultaEmpleo();
				} else
					toastr.error('Error al mostrar los datos.');
			});
	});

</script>
