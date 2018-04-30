<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:    
* Descripcion:	
* Autor: 
* =========================================================================
--->
	
<cfprocessingdirective pageEncoding="utf-8">

<script  type="text/javascript">	

	
<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista general que contiene todos los elementos visibles
* --->
function cargarConfiguracion(){
	return $.ajax({
		type:"POST",		
		url:"misionvision/getVistaConfiguracion",
		data:{
			formato: $('#in-formatos').val()
		},
		success:function(data){
			$('#divConfiguracion').html( data );
		}
	});	

}	

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista inicial que contiene todos los elementos visibles
* --->
function cargarInicio(){		
	//cargarConfiguracion();
}

function cargarVista(){	
	$.when(cargarConfiguracion()).then(function(){
	});

	$.when(cargaInfoGral()).then(function(){
		$('#divConfiguracion').find('#registroForm :input').prop('disabled',true);
		$('#divConfiguracion').find('#registroForm').find("*").off('change');
	});		
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de informacion general del reporte
* --->
function cargaInfoGral(){

	return $.ajax({
		type:"POST",		
		url:"misionvision/cargaInfoGral",
		data:{
			formato: $('#in-formatos').val()
		},
		success:function(data){
			$('#divInfoGral').html( data );
		}
	});

}

function cerrarConfiguracion(){
	$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');	
	$('#divConfiguracion').slideToggle( 1000,'easeInExpo');
	location.reload();	
}

<!---
* Fecha creación: Enero de 2017
* @author: SGS
* Descripcion: Marca una celda de la tabla de Información de semestres previos para ser usada 
--->
function agregraColumna(pkColOrigen, pkColumna){
	$.post('configuracion/cambiaColumna', {
		pkColumna: pkColumna,
		pkColOrigen: pkColOrigen,
		trimCopiable: $("#trimCopiable").val()
	}, function(data){
		if (data > 0){
			toastr.success('','Columna marcada');
			trimestresAnteriores();
		} else{
			toastr.error('al marcar la columna','Problema');
		}
	});	
}

$(document).ready(function() {
	
<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: refresca las vistas
* --->
	$('#in-formatos').change(function(){
		cargarInicio();
	});
});
	
</script>