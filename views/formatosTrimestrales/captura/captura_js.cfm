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
* Descripcion: carga la vista inicial que contiene todos los elementos visibles
* --->
function cargarInicio(){
	cargarTabla();
//	cargaInfoGral();
}


<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de de la tabla (vista previa de la captura)
* --->
function cargarTabla(){
	$('#tabla').html('');
	$.post('capturaFT/getInfoReporte', {
			formato: $('#pkformato').val(),
			periodo: $('#pkperiodo').val(),
			reporte: $('#pkReporte').val()
		}, 
		function(data){
			$('#tabla').html( data );
			$('.modal-backdrop').remove();	
    	}
    );
}


<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de de la tabla (vista previa de la captura)
* --->
function cargarCaptura(){
	$('#tabla').html('');
	$.post('capturaFT/getCapturaReporte', {
			formato: $('#pkformato').val(),
			periodo: $('#pkperiodo').val()
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
	$.post('configuracion/cargaInfoGral', {
			formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#divInfoGral').html( data );			
    	}
    );
}

<!---
* Fecha      : Marzo 2017
* Autor      : SGS
* Descripcion: Carga la vista del llenado
* --->
function cargarLlenado(){
	$('#tablaVista').html('');
	$.post('capturaFT/getCapturaReporte', {
		formato: $('#pkformato').val(),
		periodo: $('#pkperiodo').val(),
		reporte: $('#pkReporte').val()
	}, function(data){
		$('#tablaVista').html(data);			
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

	<!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Juarez
		* Descripcion: Deshabilita los elementos del panel Información de columna
		* --->
  function disablePanCol(){
           // document.getElementById("confColumna").disabled = true;
            var nodes = document.getElementById("confColumna").getElementsByTagName('*');
            for(var i = 0; i < nodes.length; i++){
                nodes[i].disabled = true;
            }

		<cfif arrayFind(session.cbstorage.grant,'configFT.Bloquear')>
			document.getElementById("guiaBloquearCaptura").disabled = false;
			document.getElementById("bloqueada").disabled = false;
		</cfif>
     }

      <!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Juarez
		* Descripcion: Oculta los elementos del panel Información de columna que no deben ser vistos por un capturista
		* --->
  function ocultaPanCol(){
			<cfif not arrayFind(session.cbstorage.grant,'configFT.Bloquear')>
		    	document.getElementById("guiaBloquearCaptura").style.display = 'none';				// A.B.J.M. Oculta check box Bloquear para Captura
			</cfif>
         }

	<!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Juarez
		* Descripcion: Carga la vista de configuracion de la columna
		* --->
	function cargarVistaConfiguracionCol(fila,columna,nivelesEncabezado){					// A.B.J.M. Carga la vista de configuracion de la columna seleccionada
		$('#cont-columna').show();

		//document.getElementById("bodyCol").disabled = true;
		//$('#confColumna').prop('disabled',true);
		$('#divConfiguracion').addClass( 'col-md-8').removeClass( 'col-md-12');				// A.B.J.M. Para encoger el panel de la handsontable
		if(fila < nivelesEncabezado){
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.getColumna")#</cfoutput>', {
				fila:fila,
				columna: columna,
				}	,
				function(data){
					$('#confColumna').html( data );
					<cfif (not arrayFind(session.cbstorage.grant,'configFT.captura')) || (arrayFind(session.cbstorage.grant,'configFT.Bloquear'))>
						ocultaPanCol();
					  	disablePanCol();
					</cfif>
				}
	    	);
		}
	}

</script>