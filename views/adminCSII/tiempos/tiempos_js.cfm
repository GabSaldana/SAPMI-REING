<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIIS
* Modulo:		Tiempos
* Fecha:		Agosto de 2017
* Descripcion:	JS de los tiempos de los convenios
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
	$('.modal').css('max-height', $(window).height());
	$('.date').datepicker({
		format: 'dd/mm/yyyy',
		language: 'es',
		calendarWeeks: true,
		autoclose: true,
		startDate: '01/01/2015',
		todayHighlight: true
	});
});

//muestra los filtros de rol y estado así como la tabla de tiempos
$('body').on('change', '#proced', function(){
	mostrarProcedimientos();
});

//la tabla de tiempos con base a los filtros seleccionados
$('body').on('change', '.buscador', function(){
	mostrarTablaTiempos();
});

function errorServidor(){
	swal({
		type: "error",
		title: "Error",
		text: "Ha ocurrido un error por el servidor.",
		timer: 3000,
		showConfirmButton: false
	});
}

//muestra la tabla de tiempos
function mostrarProcedimientos(){
	var proced = parseInt($('#proced').val() == undefined || $('#proced').val() == null ||  isNaN($('#proced').val()) || $('#proced').val() == '' ? 0 : $('#proced').val() );
	if(proced != 0){
		$.post('<cfoutput>#event.buildLink("adminCSII.tiempos.tiempos.getFiltros")#</cfoutput>',{
			proced:proced
		},function(data){
			$('#estado').empty().selectpicker('refresh');
			$('#estado').append($("<option></option>").attr("value",0).text('TODOS').addClass('selected'));
			for ( var i = 0; i < data.ESTADO.ROWCOUNT; i++ ) {
				$('#estado').append($("<option></option>").attr("value",""+data.ESTADO.DATA.PKESTADO[i]+"").text(data.ESTADO.DATA.NUMESTADO[i]+" "+ data.ESTADO.DATA.ESTADO[i])).selectpicker('refresh');
			}
			$('#rol').empty().selectpicker('refresh');
			$('#rol').append($("<option></option>").attr("value",0).text('TODOS').addClass('selected'));
			for ( var i = 0; i < parseInt(data.ROL.ROWCOUNT); i++ ) {
				$('#rol').append($("<option></option>").attr("value",""+data.ROL.DATA.PKROL[i]+"").text(data.ROL.DATA.ROL[i])).selectpicker('refresh');
			}
			mostrarTablaTiempos();
		});
	} else
		errorServidor();
}

//muestra la tabla de tiempos
function mostrarTablaTiempos(){
	var proced = parseInt($('#proced').val() == undefined || $('#proced').val() == null ||  isNaN($('#proced').val()) || $('#proced').val() == '' ? 0 : $('#proced').val() );
	var area = parseInt($('#area').val() == undefined || $('#area').val() == null ||  isNaN($('#area').val()) || $('#area').val() == '' ? 0 : $('#area').val() );
	var estado = parseInt($('#estado').val() == undefined || $('#estado').val() == null ||  isNaN($('#estado').val()) || $('#estado').val() == '' ? 0 : $('#estado').val() );
	var rol = parseInt($('#rol').val() == undefined || $('#rol').val() == null ||  isNaN($('#rol').val()) || $('#rol').val() == '' ? 0 : $('#rol').val() );
	var fechaInicio = $('#fechaInicio').val() == undefined || $('#fechaInicio').val() == null || $('#fechaInicio').val() == '' ? '0/0/0' : $('#fechaInicio').val();
	var fechaFin = $('#fechaFin').val() == undefined || $('#fechaFin').val() == null || $('#fechaFin').val() == '' ? '0/0/0' : $('#fechaFin').val();

	if(fechaInicio != '0/0/0' && fechaFin != '0/0/0')
		if ($.datepicker.parseDate('dd/mm/yy', fechaFin) < $.datepicker.parseDate('dd/mm/yy', fechaInicio))
			swal({
				type: "error",
				title: "Error",
				text: "La fecha de inicio es mayor a la fecha de fin.",
				timer: 3000,
				showConfirmButton: false
			});

	if(proced != 0){
		$.post('<cfoutput>#event.buildLink("adminCSII.tiempos.tiempos.getTiempo")#</cfoutput>',{
			proced:proced,
			area:area,
			estado:estado,
			rol:rol,
			fechaInicio:fechaInicio,
			fechaFin:fechaFin
		}, function(data){
			if(data)
				$('#divtablaTiempos').html(data);
			else
				errorServidor();
		});
	} else
		errorServidor();
}

//muestra el control de estados desplegando un modal
$('body').on('click', '#controlEdos', function(){
	var proced = parseInt($('#proced').val() == undefined || $('#proced').val() == null ||  isNaN($('#proced').val()) || $('#proced').val() == '' ? 0 : $('#proced').val() );
	$.post('<cfoutput>#event.buildLink("adminCSII.historial.historial.getHistorial")#</cfoutput>', {
		pkRegistro: $(this).data('registro'),
		pkProcedimiento:proced
	},
	function(data){
		$('#modal-historial .modal-body').html(data);
		$("#modal-historial").modal('toggle');
	});
});

</script>