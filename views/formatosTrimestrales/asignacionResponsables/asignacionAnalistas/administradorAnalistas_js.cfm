<!---
* =========================================================================
* IPN - CSII
* Sistema:  	SIIE 
* Modulo:   	Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:  JS de la asignación de analistas.
* Autor: 		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$('#tblFomato').bootstrapTable();
$('#tblFormatoNull').bootstrapTable();

$(document).ready(function(value){

	$('body').undelegate('.relacion', 'click');
	$('body').on('click', '.relacion', function() {
		if($(this).prop('checked'))
			insertarAsociacion($(this).attr('idanalista'), $(this).attr('idformato'));
		else
			eliminarAsociacion($(this).attr('idanalista'), $(this).attr('idformato'));
	});

	$('body').undelegate('.checkAll', 'click');
	$('body').on('click', '.checkAll', function() {
		if($(this).prop('checked'))
			insertarTodosResponsables($(this).attr('idanalista'), $(this).attr('idDependencia'), $(this).attr('usuario'), 0);
		else
			eliminarTodosResponsables($(this).attr('idanalista'), $(this).attr('idDependencia'), $(this).attr('usuario'), 0);
	});

	$('body').undelegate('.checkAllNull', 'click');
	$('body').on('click', '.checkAllNull', function() {
		if($(this).prop('checked'))
			insertarTodosResponsablesNull($(this).attr('idanalista'), $(this).attr('idDependencia'), $(this).attr('usuario'),1);
	});
});

$('#sinAsignar').change(function(){	
	if($("#sinAsignar").prop('checked') == false){
		$('#Formato').show();
		$('#FormatoNull').hide();
		obtenerFormatos(0);
	}
	else{
		$('#Formato').hide();
		$('#FormatoNull').show();
		obtenerFormatos(1);
	}
});

function getTablaFormato(idDependencia){
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/getTablaAnalistas',
	{
		dependencia: $("#dependencia").val()
	},
	function(data){
	});
}

function obtenerFormatos(val){
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/getTablaAnalistas',
	{
		dependencia: $("#dependencia").val(),
		val:val
	},
	function(data){
		$('#Formatos').html(data);
	});
}

function eliminarAsociacion(idAnalista, idFormato){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.asignacionResponsables.eliminarAsociacionAnalistas")#</cfoutput>',
	{
		idFormato:idFormato,
		idAnalista:idAnalista
	},
	function(data){
		if(data)
			toastr.success('Se han eliminado el responsable de ese formato.');
		else
			toastr.error('','Error');
	});
}

function insertarAsociacion(idAnalista, idFormato){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.asignacionResponsables.insertarAsociacionAnalistas")#</cfoutput>',
	{
		idFormato:idFormato,
		idAnalista:idAnalista
	},
	function(data){
		if(data)
			toastr.success('Se han creado responsable para este formato.');
		else
			toastr.error('','Error');
	});
}

function insertarTodosResponsables(idAnalista, idDependencia, usuario,val){
	var analis = usuario;
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/insertarTodosAnalistas',
	{
		idAnalista:idAnalista,
		idDependencia:idDependencia,
		val:val
	},
	function(data){
		$('#Formatos').html(data);
		if(data)
			toastr.success('Se ha agregado el responsable '+analis+' para todos los formatos formato.');
		else
			toastr.error('','Error');
	});
}

function insertarTodosResponsablesNull(idAnalista, idDependencia, usuario, val){
	var analis = usuario;
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/insertarTodosAnalistasNull',
	{
		idAnalista:idAnalista,
		idDependencia:idDependencia,
		val:val
	},
	function(data){
		obtenerFormatos(1);
		if(data)
			toastr.success('Se ha agregado el responsable '+analis+' para todos los formatos formato.');
		else
			toastr.error('','Error');
	});
}


function eliminarTodosResponsables(idAnalista, idDependencia, usuario, val){
	var analis = usuario;
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/eliminarTodosAnalistas',
	{
		idAnalista:idAnalista,
		idDependencia:idDependencia,
		val:val
	},
	function(data){
		$('#Formatos').html(data);
		if(data)
			toastr.success('Se ha eliminado el responsable '+analis+' para todos los formatos formato.');
		else
			toastr.error('','Error');
	});
}

</script>