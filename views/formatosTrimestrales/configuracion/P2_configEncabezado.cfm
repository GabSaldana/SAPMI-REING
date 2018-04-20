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

<style>
.verde{

	background-color:#1cc486;
	color:#fff;
	
}
.azul{

	background-color:#1c84c6;
	color:#fff;
}
.captura{
	color:#000;
}
</style>

<div class="container" >
	<div class="row">	
		<div class="col-md-6">
			<div class="btn-group-vertical" id="modFila">
				<button id="" class="btn btn-default btn-outline btn-xs" ><span class="fa fa-arrows-h">Filas:</span></button>
				<button id="bt-agregar-fila" class="btn btn-success btn-xs" ><span class="fa fa-plus">Agregar</span></button>
				<button id="bt-eliminar-fila" class="btn btn-warning btn-xs" ><span class="fa fa-minus">Eliminar</span></button>
			</div>		
			<div class="btn-group-vertical" id="modColumna">
				<button id="" class="btn btn-default btn-outline btn-xs" ><span class="fa fa-arrows-v">Columnas:</span></button>
				<button id="bt-agregar-columna" class="btn btn-success btn-xs" ><span class="fa fa-plus">Agregar</span></button>
				<button id="bt-eliminar-columna" class="btn btn-warning btn-xs" ><span class="fa fa-minus">Eliminar</span></button>
			</div>	
				
			<div class="btn-group-vertical" id="conbinarCelda">
				<button id="" class="btn btn-default btn-outline btn-xs" ><span class="fa fa-table">Combinar:</span></button>
			<button id="bt-unir-celdas" class="btn btn-success btn-xs" ><span class="fa fa-exchange">Unir</span></button>
			<button id="bt-separar-celdas" class="btn btn-warning btn-xs" ><span class="fa fa-arrows">Separar</span></button>
			</div>	
		</div>
		<div class="col-md-2">
		</div>
		
		<div class="col-md-2">
		</div>
		
		<div class="col-md-2" id="guardarDatos">
			<button id="bt-guardar-encabezado" class="btn btn-default btn-xs btn-outline dim pull-left ml5 guardarDatos" ><i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i></button>
		</div>
	</div>
	<div class="row">	
		<div class="col-md-12" id="guardar" style=" " >
			<cfset encabezado = prc.reporte.getencabezado()>
			<cfset columnas = encabezado.getColumnas()>
			<!--- <si esta definido el encabezado lo pinta si no pinta una estructura vacia > --->
			<cfif arraylen(columnas) gt 0>
				<div style="overflow-x: auto; width:90%">
					<table id="tablaEdicionEncabezado" class="table table-bordered">
						<cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
							<cfif i lt encabezado.getniveles()+1>
								<tr  >
								<cfloop  array="#columnas#" index="columna">
									<cfif columna.getNivel() eq i>
									<td align="center " class="azul celda" 
											val-pkcolumna="<cfoutput>#columna.getpk_columna()#</cfoutput>" 
											colspan="<cfoutput>#columna.gettotalHijosUltimoNivel()#</cfoutput>"
											nivel="<cfoutput>#columna.getNivel()#</cfoutput>"
											posicion="<cfoutput>#columna.getorden()#</cfoutput>">
										<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>
									</td>
									</cfif>
								</cfloop>
								</tr>
							</cfif>
						</cfloop>
					</table>
				</div> 
			<cfelse>
				<div style="overflow-x: auto; width:90%">
					<table id="tablaEdicionEncabezado" class="table table-bordered">
						<tr>
							<td align="center " class="azul celda" val-pkcolumna="" colspan="">	</td>
							<td align="center " class="azul celda" val-pkcolumna="" colspan="">	</td>
							<td align="center " class="azul celda" val-pkcolumna="" colspan="">	</td>
						</tr>
					</table>
				</div> 
			</cfif>
		</div>
	</div>
	
</div>

<!--- ********************************************************* Guia ********************************************************* --->
<ul id="tlyPageGuide" data-tourtitle="Captura de información">
	<li class="tlypageguide_top" data-tourtarget="#modFila">
		<div>Filas del encabezado<br>
		El botón <i class="fa fa-plus"></i> añade una nueva fila en la parte inferior del encabezado.<br>
		El botón <i class="fa fa-minus"></i> elimina la fila inferior del encabezado..</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#modColumna">
		<div>Columnas del encabezado<br>
		El botón <i class="fa fa-plus"></i> añade una nueva columna en el costado derecho del encabezado.<br>
		El botón <i class="fa fa-minus"></i> elimina la columna del extremo derecho del encabezado..</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget="#conbinarCelda">
		<div>Combinar celdas<br>
		El botón <i class="fa fa-exchange"></i> combinará las celdas seleccionadas.<br>
		El botón <i class="fa fa-arrows"></i> separará la celda seleccionada.</div>
	</li>	
	<li class="tlypageguide_left" data-tourtarget="#guardarDatos">
		<div>Guardar información<br>
		Al seleccionar el botón <i class="glyphicon glyphicon-floppy-disk"></i> se guardará la información capturada del encabezado del formato de reporte.</div>
	</li>
</ul>

<script>	
	
	
	$(document).ready(function () {	
	
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: crea una fila completa
		* --->
		$('#bt-agregar-fila').click(function(){
			/*realiza el conteo de columnas*/
			var colCount = 0;
		    $('#tablaEdicionEncabezado tr:last').each(function () {
		    	$('td',this).each(function () {
			    	if ($(this).attr('colspan')&& $(this).attr('colspan') != 0) {
			            colCount += +$(this).attr('colspan');
			        } else {
			            colCount++;
			        }
		    	});
		    });
		    /*agrega las filas en la tabla*/
		    var $row = $('<tr></tr>');
		    for(var i=0; i < colCount; i++ ){
		    	var $td = crearCelda();
		    	$row.append($td);
		    }
			$('#tablaEdicionEncabezado tbody:last').append($row);
 		});
 		
 		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: crea una celda para fila de la tabla
		* --->
		$('#bt-agregar-columna').click(function(){
			$('#tablaEdicionEncabezado tr').each(function () {
				$td = crearCelda();
		 		$(this).append($td);
		    });
		});
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: funcion que elimina una columna
		* --->
		$('#bt-eliminar-columna').click(function(){
			$('#tablaEdicionEncabezado tr').find('th:last, td:last').each(function () {
			    if ($(this).attr('colspan')&& $(this).attr('colspan') != 0 && $(this).attr('colspan') != 1){
					$(this).attr('colspan',$(this).attr('colspan')-1);
			    } else {
			    	$(this).remove();
			    }
			});
			
		});
 		
 		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: funcion que elimina una fila
		* --->
		$('#bt-eliminar-fila').click(function(){
			$('#tablaEdicionEncabezado tr:last').remove();
		});
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: funcion que une las celdas seleccionadas solo en horizontal puede unir varias celdas a la vez
		* --->
		$('#bt-unir-celdas').click(function(){
			var fila = 0;
			var colCount = 0;
		    var tdColspan = null;
			$('#tablaEdicionEncabezado tr').each(function () {
		    	/*si no es nulo asignamos el cospan que le corresponde(aplica cuando la union es en la ultima celda de una fila)*/
		    	if(tdColspan != null){
		    		tdColspan.attr('colspan',colCount);
	      			tdColspan = null;
	      			colCount = 0;
      			}
		    	$('td',this).each(function () {
		    		/*en caso de que tenga la clase para union suma el colspan que sea necesario*/
		      		if($(this).hasClass('verde')){
		      			$(this).removeClass('verde');
 						$(this).addClass('azul');
		      			if ($(this).attr('colspan') && $(this).attr('colspan') != 0) {
				            colCount += +$(this).attr('colspan');
				        } else {
				            colCount++;
				        }
		      			/*si es la primera la almacena si no elomina el resto*/
		      			if(tdColspan == null){
		      				tdColspan = $(this);	
		      			} else {
		      				$(this).remove();
		      			}
		      		} else{
		      			if(tdColspan != null){
		          			tdColspan.attr('colspan',colCount);
			      			tdColspan = null;
			      			colCount = 0;
		      			}
		      		}
				});
				fila++;
		    });
		});
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: funcion que separa las celdas seleccionadas
		* --->
		$('#bt-separar-celdas').click(function(){
			$('#tablaEdicionEncabezado tr').each(function () {
		    	$('td',this).each(function () {
		      		if($(this).hasClass('verde')){
	      				var anteriorColspan = $(this).attr('colspan');
	      				$(this).attr('colspan',0);
	      				for(cel = 1; cel < anteriorColspan; cel++){
	      					crearCelda().insertAfter(this);
	      				}
		      		}
				});
			});
		});
		
		$('td').click(function(){
			removerInputs($(this));
 			$(this).toggleClass('azul verde');
 		});
 		
 		$('td').dblclick(function(){
 			removerVerdes();
 			$(this).html(crearInputCelda($(this).text().trim()));
 		});
	
 		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: funcion que guarda el encabezado en la base de daots
		* --->
		$('#bt-guardar-encabezado').click(function(){
			var numfila = 1;
			var idTmp = 1;
	    	var encabezado = [];
	    	/*crea un array con los datos de la tabla deja pendiente los datos de los padres*/
	    	$('#tablaEdicionEncabezado tr').each(function () {
		    	var fila = [];
		    	var colCount = 0;
		    	var valorCelda;
					$('td',this).each(function () {
	    				var colspantd = 0;
	    				if ($(this).attr('colspan') && $(this).attr('colspan') != 0) {
				            colspantd = $(this).attr('colspan');
				    	} else {
				            colspantd = 1;
				        }
				        if ($(this).text().trim()=='') {
				        	valorCelda = '-';
				        }else{
				        	valorCelda = $(this).text().trim();
				        }
	    				var valTD ={'valor': valorCelda,
		      					'pkColumna':$(this).attr('val-pkcolumna'),
		      					'nivel':numfila,
		      					'colspan':colspantd,
		      					'posicion':colCount,
		      					'idTmp':idTmp,
		      					'pkpadre':'0',
		      					'idTMPpadre':'0'}
			      		fila.push(valTD);
			      		
			      		idTmp++;
	    				/*sumatoria para calcular la posicion de inicio*/
	    				colCount += +colspantd;
					});
				encabezado.push(fila);
				numfila++;
		    });
		    /*recorre el objeto para obtener los datos de los padres*/
		   	for(var i=1; i < encabezado.length; i++){
	   			var filaAct = encabezado[i];
			    var filaAnt = encabezado[i-1];
			    for(var j=0; j < filaAct.length; j++){
			    	/*recorre la fila del padre y revisa el rango para encontrar su padre*/
					for(var k=0; k < filaAnt.length; k++){
						if(filaAct[j].posicion >= filaAnt[k].posicion && filaAct[j].posicion < (filaAnt[k].posicion + filaAnt[k].colspan )){
							filaAct[j].pkpadre 		= filaAnt[k].pkColumna;
							filaAct[j].idTMPpadre 	= filaAnt[k].idTmp;
						}
					}
				}
			}
						
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.guardarEstructuraReporteP2")#</cfoutput>', {
				encabezado: JSON.stringify(encabezado),
				formato: $('#in-formatos').val(),
				}, 
				function(data){
					cargaVistaPrevia();
		    	}
		    );
		});
	});


	<!---
	* Fecha      : Diciembre 2016
	* Autor      : Marco Torres
	* Descripcion: crea celdas con sus respectivas funcio0nes
	* --->
	function crearCelda(){
		var $td = $('<td></td>').addClass('azul');
		$td.on('click',function(){
			$(this).toggleClass('azul verde');
    	});
		$td.dblclick(function(){
			removerVerdes();
 			$(this).html(crearInputCelda($(this).text().trim()));
 		});
		return $td;
	}
	
	<!---
	* Fecha      : Diciembre 2016
	* Autor      : Marco Torres
	* Descripcion: crea los ipnputs de captura de titulos de encabezado
	* --->
	function crearInputCelda(valorOriginal){
			$vinp = $('<textarea type="text"></textarea>');
 			$vinp.val(valorOriginal);
 			$vinp.addClass('captura');
 			$vinp.keypress(function(e){
 				if(e.which == 13) {
 				        $(this).parent().html($(this).val());
				    }
		    		$(this).parent().addClass('azul').removeClass('verde');
				});
			$vinp.blur(function(){
					$(this).parent().html($(this).val());
					
			    });
		return $vinp;
	}
	
	<!---
	* Fecha      : Diciembre 2016
	* Autor      : Marco Torres
	* Descripcion: Quita todos las clases verdes(selecion) de la tabla
	* --->
	function removerVerdes(){
		$('#tablaEdicionEncabezado tr').each(function () {
			$('td',this).each(function () {
	    		$(this).removeClass('verde');
		    	$(this).addClass('azul');
	    		if(typeof($(this).children( ":input").val() !=='undefined')){
	    			$(this).html($(this).children( ":input").val());
	    		}
			});
		});
	}
	
	<!---
	* Fecha      : Diciembre 2016
	* Autor      : Marco Torres
	* Descripcion: Quita los inputs visibles y acualiza los valores de la tabla
	* --->
	function removerInputs(celda){
		$('#tablaEdicionEncabezado tr').each(function () {
			$('td',this).each(function () {
	    		if(celda.text() !== $(this).text()){
	    				if(typeof($(this).children( ":input").val() !=='undefined')){
		    			$(this).html($(this).children( ":input").val());
		    		}
	    		}
			});
		});
	}
	
</script>
