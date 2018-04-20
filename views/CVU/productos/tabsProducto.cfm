<cfprocessingdirective pageEncoding="utf-8">


<cfset total_records = prc.resultado.recordcount>

<style type="text/css">
.content{
height: 75vh !important;
overflow: auto !important;
}
</style>
<span style="color:red;" class="text-right"><h5>*Es requerido que todos los documentos comprobatorios estén en formato PDF y un tamaño menor a 10MB*</h5></span>
<span style="color:#BEAF19;" class="text-right"><h5>Los campos con (*) son requeridos para EDI</h5></span>
<div id="cont-producto" style="height: 80vh;">
	<input id="pkProducto" type="hidden" value=<cfoutput>#prc.pkproducto#</cfoutput>>
	<input id="revista"   type="hidden" value=<cfoutput>#prc.revistaissn#</cfoutput>>
    <input id="pkFormato"   type="hidden" value=<cfoutput>#prc.formato.pkformato#</cfoutput>>
    <input id="pkPeriodo"   type="hidden" value=<cfoutput>#prc.formato.periodo#</cfoutput>>
    <input id="pkReporte"   type="hidden" value=<cfoutput>#prc.formato.pkreporte#</cfoutput>>
    <input id="esHoja"	    type="hidden" value=0>
    <input id="pkFila"      type="hidden">
<div id="steps-producto">
	<cfloop index="x" from="1" to="#total_records#">
		<h3> <cfoutput>#prc.resultado.FILTRO[x]#</cfoutput> </h3>	
		<cfif x eq #total_records#>
		   <section data-producto=<cfoutput>#prc.resultado.PKFILTRO[x]#</cfoutput> data-revista=<cfoutput>#prc.resultado.REVISTAISSN[x]#</cfoutput> > 
		   	<div id="divSeleccionCaptura"> </div>   

		   	<div class="row" id="divLlenado" style="">
				<div class="col-md-12 col-lg-12"><br>
					<div class="panel panel-success">
			    		<div class="panel-heading">
							PRODUCTO: &nbsp;&nbsp;&nbsp;<cfoutput>#prc.resultado.FILTRO[x]#</cfoutput>
							<strong><span id="displayNombreLlenado"></span></strong><br>				
						</div>
						<div class="panel-body">
							<div id="formularioCaptura"></div>
						</div>
					</div>
				</div>
			</div>
			<div id="issnNoEncontrado"> 
					<h5>El ISSN no fue encontrado en el sistema. Elija una de las categorías que se muestran si su producto esta clasificado en alguna de las revistas de nivel F o G. Si considera que su producto debe ser clasificado en otro nivel de revista, elija la categoria de Artículo con ISSN no encontrado en el sistema. </h5>	
			</div>
			

		   </section>	
		<cfelse>
		   <section data-producto=<cfoutput>#prc.resultado.PKFILTRO[x]#</cfoutput> data-revista=<cfoutput>#prc.resultado.REVISTAISSN[x]#</cfoutput> > </section>
		</cfif>			
	</cfloop>

</div>
</div>


<script>


	$(document).ready(function() {
        
		var cont;  
		cont = <cfoutput>#total_records#</cfoutput> -1;    
			
		cargaSeleccionTabs(<cfoutput>#prc.pkproducto#</cfoutput>);
		$("#divLlenado").hide();
		$("#issnNoEncontrado").hide();
         $("#steps-producto").steps({
		    headerTag: "h3",
		    bodyTag: "section",
		    transitionEffect: "slideLeft",
		    stepsOrientation: "vertical",
		    startIndex: cont,		 
		    labels: {
				finish: "Cancelar",
				previous: "Anterior"			
			},
		    
		    onStepChanging: function (event, currentIndex, newIndex)
		    {
		    	var stepProd;
		    	if($("#esHoja").val() == 1){
        			swal({
						title:				'Anterior.',
						text:				"¿Deseas cambiar de ventana?, se eliminarán los datos capturados.",
						type:				"warning",
						showCancelButton:	true,
						confirmButtonText:	"Sí",
						cancelButtonText:	"No",
						closeOnConfirm:		true,
						closeOnCancel:		true
					}, function(isConfirm){
						if (isConfirm){
							cancelarNuevoProducto();
							stepProd =  document.getElementById("steps-producto-p-"+newIndex);
							if ((stepProd.dataset.revista == 1) || (stepProd.dataset.revista == 2))
		    						cargaTabs(stepProd.dataset.producto, stepProd.dataset.revista);
		    					else
		    						cargaTabs(stepProd.dataset.producto, 0);		     		
		      				return true;
						}	
						else
							return false;  			
					});
	        	}else{
		    			stepProd =  document.getElementById("steps-producto-p-"+newIndex);    	
		    			if ((stepProd.dataset.revista == 1) || (stepProd.dataset.revista == 2))
		    				cargaTabs(stepProd.dataset.producto, stepProd.dataset.revista);
		    			else
		      				cargaTabs(stepProd.dataset.producto, 0);
		        }
		        
		    },
		    onFinished: function (event, currentIndex)
    		{	
        		if($("#esHoja").val() == 1){
        			swal({
						title:				'Cancelar producto.',
						text:				"¿Deseas cancelar?, se eliminarán los datos capturados.",
						type:				"warning",
						showCancelButton:	true,
						confirmButtonText:	"Sí",
						cancelButtonText:	"No",
						closeOnConfirm:		true,
						closeOnCancel:		true
					}, function(isConfirm){
						if (isConfirm){
        					cancelarNuevoProducto();
        					muestraOcultaCaptura();
						}
							
					});
	        	}else{
							muestraOcultaCaptura();
    			}	
		    }
		});     	
	});


	function cargaSeleccionTabs(pkPadrep){
		var pkformato = 0, producto=0,  periodo, reporte =0;

		<!---pkformato = <cfoutput>#prc.formato.pkformato#</cfoutput>;
		producto = <cfoutput>#prc.pkproducto#</cfoutput>;
		periodo = <cfoutput>#prc.formato.periodo#</cfoutput>;
		reporte = <cfoutput>#prc.formato.pkreporte#</cfoutput>; --->
				
		$.post('<cfoutput>#event.buildLink("CVU.productos.getSeleccionCaptura")#</cfoutput>', {
			pkPadre: pkPadrep,
			vista: 2
			}, 
			function(data){
			
				if(data == 0)
				{
					$("#esHoja").val(1);
					$("#divLlenado").show();
					$('#steps-producto a').last().parent().parent().prepend("<li><a id='btnGuardar' name='btnGuardar' onclick='guardarProducto();'>Guardar</a></li>");
					

					crearFilaNueva();
					//cargaFormulario();
				} else{
					if(pkPadrep == 127)
						$("#issnNoEncontrado").show();				//Si el producto padre es referente q artículos con issn no encontrad en el sistema, se coloca la leyenda

					$('#divSeleccionCaptura').html( data );
				}
			}
	    );	
	}

	function cargaFormularioCaptura(pkFila){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.getReporteLlenado")#</cfoutput>', {
				formato: $('#pkFormato').val(),
				periodo: $('#pkPeriodo').val(),
				reporte: $('#pkReporte').val(),
				producto: $('#pkProducto').val()

			}, function(data){
				$('#formularioCaptura').html(data);	
				obtenerDatosFila(pkFila);
				if($("#anio_issnPrecargados").val()!='')
					llenarPrecargados(); // Si el input tiene un valor, significa que existe el ISSN y puede precargar datos
		    });
	} 


<!---
* Fecha      : Marzo 2017
* Autor      : ABJM
* Descripcion: Crea una fila nueva en un formato (formato de producto(s))
* --->
function crearFilaNueva(){
   	var columnasEncabezado = [];
    var pkColumnas = [
			<cfoutput>
				<cfloop array="#prc.reporte.getEncabezado().getColumnasUltimoNivel()#" index="columna">
					{"data": "#columna.getpk_columna()#"},
				</cfloop>
			</cfoutput>
		]; 	
		for (var i = 0; i < pkColumnas.length; i++) {
			columnasEncabezado[i] = pkColumnas[i].data;
		}		
	
		return $.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.crearFilaNueva")#</cfoutput>', {
				formato: $('#pkFormato').val(),
				reporte: $('#pkReporte').val(),
				pkColumnas: JSON.stringify(columnasEncabezado),
				pkProducto: $('#pkProducto').val()
			},
			function(data){
				if (data > 0){
					//toastr.success('exitosamente','F agregada');
					$("#pkFila").val(data);
					cargaFormularioCaptura(data);
				} else {
					toastr.error('al crear la estructura del producto','Problema');
				}
			}
		);
	} 


function cancelarNuevoProducto(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.eliminarFilaFormulario")#</cfoutput>', {
		pkFila: $("#pkFila").val()
		}, 
		function(data){

			if (data > 0){
				toastr.success('exitosamente','Datos eliminados');	
				return 1;
			} else {
				toastr.error('al eliminar los datos','Problema');
				return 0;
			}
	}
	);	
}

function guardarProducto(){
	if(guardarNuevoProducto()==1){
		muestraOcultaCaptura();		
		cargaTablaControl($('#pkProducto').val(), $('#revista').val());				
		// cargaTabla($('#pkProducto').val(), $('#revista').val());		
	}

}

function cargarLlenado(){
	return true;	
}

</script>


