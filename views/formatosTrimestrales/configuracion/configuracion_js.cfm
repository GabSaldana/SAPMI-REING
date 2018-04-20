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
		url:"configuracion/getVistaConfiguracion",
		data:{
			formato: $('#in-formatos').val()
		},
		success:function(data){
			$('#divConfiguracion').html( data );
			
			cargarTablap3();
			cargaInfoGral();
			cargaConfigGral();
		}
	});	

	//Se cambia el POST a  AJAX para retornar un deferred
	/*$.post('configuracion/getVistaConfiguracion', {
			formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#divConfiguracion').html( data );			
    	}
    );*/
}	

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista inicial que contiene todos los elementos visibles
* --->
function cargarInicio(){		
	cargarConfiguracion();
}

function cargarVista(){	
	$.when(cargarConfiguracion()).then(function(){
		$('#vistaPreviaBtn').remove();
	});

	$.when(cargaInfoGral()).then(function(){
		$('#divConfiguracion').find('#registroForm :input').prop('disabled',true);
		$('#divConfiguracion').find('#registroForm').find("*").off('change');
	});	

	cargarTablap3();
	
	cargaConfigGral();	
}


function cerrarConfiguracion(){
	$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');	
	$('#divConfiguracion').slideToggle( 1000,'easeInExpo');
	location.reload();	
}
<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de de la tabla (vista previa de la captura)
* --->
function cargarTablap3(){
	$.post('configuracion/getTabla', {
			formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#tabla').html( data );			
    	}
    );
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de informacion general del reporte
* --->
function cargaInfoGral(){

	return $.ajax({
		type:"POST",		
		url:"configuracion/cargaInfoGral",
		data:{
			formato: $('#in-formatos').val()
		},
		success:function(data){
			$('#divInfoGral').html( data );
		}
	});

	/*$.post('configuracion/cargaInfoGral', {
			formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#divInfoGral').html( data );			
    	}
    );*/
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de edicion del encabezado general del reporte
* --->
function cargaEncabezado(){
	$.post('configuracion/cargaEncabezado', {
			formato: $('#in-formatos').val(),
		}, 
		function(data){
			$('#cont-columna').hide();
			
			$('#cont-formato').addClass( 'col-md-12').removeClass( 'col-md-8');		
			
			$('#cont-vistaPrevia').slideToggle( 1000,'easeOutExpo');			
			$('#cont-config').slideToggle( 1000,'easeOutExpo');			
			$('#cont-infoGral').slideToggle( 1000,'easeOutExpo');
	
			$('#tablaConfig').html( data );	
    	}
    );
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: elementos visuales de la carga de la vista de de la tabla (vista previa de la captura)
* --->
function cargaVistaPrevia(){
	cargarTablap3();
	$('#cont-columna').hide();
	$('#cont-formato').addClass( 'col-md-12').removeClass( 'col-md-8');
	
	$('#cont-vistaPrevia').slideToggle( 1000,'easeOutExpo');
	$('#cont-config').slideToggle( 1000,'easeOutExpo');
	$('#cont-infoGral').slideToggle( 1000,'easeOutExpo');
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: elementos visuales de la carga de la vista de de la tabla (vista previa de la captura)
* --->
function cerrarColumna(){
	cargarTablap3();
	$('#cont-columna').hide();
	$('#cont-formato').addClass( 'col-md-12').removeClass( 'col-md-8');			
	
	$('#cont-vistaPrevia').show();			
	$('#cont-config').hide();
	$('#cont-infoGral').show();	
}


<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: Carga la vista de configuracion de la columna
* --->
function cargarVistaConfiguracionCol(fila,columna,nivelesEncabezado){
	$('#cont-columna').show();
	
	$('#cont-formato').addClass( 'col-md-8').removeClass( 'col-md-12');
	if(fila < nivelesEncabezado){
		
		$.when(
			$.ajax({
				type:"POST",		
				url:"configuracion/getColumna",
				data:{
					fila:fila,
					columna: columna,
				},
				success:function(data){
					$('#confColumna').html( data );
				}
			})
		).then(function(){
				if($('#in-readOnly').val() > 0){
					$('#columnaPanel').find('#registroForm :input').not('#descripcionColumna').prop('disabled',true);
					$('#columnaPanel').find('#registroForm').find("*").not('#descripcionColumna').off('change');					
				}
			}			
		);

		//Se cambia de POST a AJAX para regresar un deferred
		/*$.post('configuracion/getColumna', {
			fila:fila,
			columna: columna,
			}, 
			function(data){
				$('#confColumna').html( data );
			}
	    );*/
	}			
}

function cargaConfigGral(){
	$.post('configuracion/cargaConfigGral', {
		formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#divConfigGral').html( data );
		}
    );	
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

<!---
* Fecha creación: Enero de 2017
* @author: SGS
* Descripcion: Desmarca una celda de la tabla de Información de semestres previos para dejar de ser usada
--->
function eliminarColumna(pkColumna){
	$.post('configuracion/cambiaColumna', {
		pkColumna: pkColumna,
		pkColOrigen: 0,
		trimCopiable: 0
	}, function(data){
		if (data == 0){
			toastr.success('','Columna desmarcada');
			trimestresAnteriores();
		} else{
			toastr.error('al desmarcar la columna','Problema');
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