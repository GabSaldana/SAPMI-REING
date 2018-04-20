<!---
* =========================================================================
* IPN - CSII
* Sistema:  	SIIE 
* Modulo:   	Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:  JS de la asignación de responsables.
* Autor: 		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$('#tblFomato').bootstrapTable();

$(document).ready(function(value){

	$('body').undelegate('.checkAll', 'click');
	$('body').on('click', '.checkAll', function() {
		if($(this).prop('checked'))
			insertarTodosResponsables($(this).attr('idanalista'), $(this).attr('idDependencia'), $(this).attr('usuario'));
		else
			eliminarTodosResponsables($(this).attr('idanalista'), $(this).attr('idDependencia'), $(this).attr('usuario'));
	});

	$('body').undelegate('.relacion', 'click');
	$('body').on('click', '.relacion', function() {
		if($(this).prop('checked'))
			insertarAsociacion($(this).attr('idanalista'), $(this).attr('idFormato'));
		else
			eliminarAsociacion($(this).attr('idanalista'), $(this).attr('idFormato'));
	});

});

function obtenerFormatos(){
    $.post('/index.cfm/formatosTrimestrales/asignacionResponsables/getTablaResponsables',
    {
        dependencia: $("#dependencia").val()
    }, function(data){
        $('#Formatos').html(data);
    });
}

function insertarTodosResponsables(idAnalista, idDependencia, usuario){
	var analis = usuario;
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/insertarTodosResponsables',
	{
		idAnalista:idAnalista,
		idDependencia:idDependencia
	},
	function(data){
		$('#Formatos').html(data);
		toastr.success('Se ha agregado el responsable '+analis+' para todos los formatos formato.');
	});
}

function eliminarTodosResponsables(idAnalista, idDependencia, usuario){
	var analis = usuario;
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/eliminarTodosResponsables',
	{
		idAnalista:idAnalista,
		idDependencia:idDependencia
	},
	function(data){
		$('#Formatos').html(data);
		toastr.success('Se ha eliminado el responsable '+analis+' para todos los formatos formato.');
	});
}

function insertarAsociacion(idAnalista, idFormato){
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/insertarAsociacionAnalistas',
	{
		idFormato:idFormato,
		idAnalista:idAnalista
	},
	function(data){
		toastr.success('Se ha creado responsable para este formato.');
	});
}

function eliminarAsociacion(idAnalista, idFormato){
	$.post('/index.cfm/formatosTrimestrales/asignacionResponsables/eliminarAsociacionAnalistas',
	{
		idFormato:idFormato,
		idAnalista:idAnalista
	},
	function(data){
		toastr.success('Se ha eliminado el responsable de ese formato.');
	});
}

</script>