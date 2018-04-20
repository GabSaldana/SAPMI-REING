<cfprocessingdirective pageEncoding="utf-8">

<style>
.verde{
	background-color:#1cc486;
	color:#fff;
}
.azul{
	background-color:#1c84c6;
	color:#fff;
}
.amarillo{							<!--- ABJM Amarillo para el analisis automatico--->
   background-color:#edbf28;
   color:#fff;
}
</style>

<div class="container">
	<div class="row">
		<div class="col-md-12">
            <div class="alert alert-info row">
                <strong>Para seleccionar o deseleccionar una columna, basta con hacer click sobre ella.</strong>
				<br>
				<strong>Para verificar una columna analizada, basta con hacer click sobre ella.</strong>
                <br><br>
                Las columnas seleccionadas se muestran en color verde <span class="badge" style="background-color:#1cc486">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>, las columnas deseleccionadas se muestran en color azul <span class="badge" style="background-color:#1c84c6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>, y las columnas analizadas se muestran en color amarillo <span class="badge" style="background-color:#edbf28">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>.  <!--- ABJM Amarillo para las columnas del analisis automatico--->
            </div>
        </div>
		<div class="col-md-12" id="encabezado">
			<cfset encabezado = prc.reporte.getencabezado()>
			<cfset columnas = encabezado.getColumnas()>
			<input type="hidden" id="nvls" name="niveles" value="<cfoutput>#encabezado.getniveles()#</cfoutput>">		
			<!--- <si esta definido el encabezado lo pinta si no pinta una estructura vacia > --->
			<cfif arraylen(columnas) gt 0>
				<div style="overflow-x: auto; width:90%">
					<table id="tablaEdicionEncabezado" class="table table-bordered">
						<cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
							<cfif i lt encabezado.getniveles()+1>
								<tr>
								<cfloop  array="#columnas#" index="columna">
									<cfif columna.getNivel() eq i>
								       	<td align="center" class="azul celda" 
												id="<cfoutput>#columna.getpk_columna()#</cfoutput>"
												panal="<cfoutput>#columna.getpanalisis()#</cfoutput>"
												val-pkcolumna="<cfoutput>#columna.getpk_columna()#</cfoutput>" 
												colspan="<cfoutput>#columna.gettotalHijosUltimoNivel()#</cfoutput>"
												nivel="<cfoutput>#columna.getNivel()#</cfoutput>"
												posicion="<cfoutput>#columna.getorden()#</cfoutput>" onclick="getConfigColumna(this);" >	
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
		<br> <br>
		<div class = "row">
		<div class="col-md-4">
		</div>
		<div class="col-md-4" id="deseleccion">
			<button id="deseleccionar" type="button" class="btn btn-block btn-primary" data-toggle="modal" onclick="deseleccionar()"><span class="fa fa-eraser"></span> Deseleccionar columnas</button>
		</div>
		<div class="col-md-4">
		</div>
		</div>
	</div>
	<br>
</div>
	

<script>
	$(document).ready(function () {
	    $("#deseleccionar").hide();
		$("#pksColumnas").val('');		
		$('#tablaEdicionEncabezado td').click(function(){

		   if ((this).getAttribute("class")=="amarillo")			<!--- ABJM   Color amarillo, es una celda analizada y se cambia a seleccionada *FALTA agregar la actualización de la bandera en la BD --->
				$(this).toggleClass('amarillo verde');				
    	   else
				$(this).toggleClass('azul verde');
						
			columnaSeleccionada();
 		});

 		$("#box-formatosRegistrados .panel-heading strong").text('<cfoutput>#prc.nombreReporte.NOMBREFMT[1]#</cfoutput>');///

	});

   	<!---
    * Fecha: Junio 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Deselecciona las columnas seleccionadas.
    * --->
	function deseleccionar(){
		$('.verde').each(function(){
			$(this).toggleClass('verde azul');
		});
		$("#deseleccionar").hide();
		$(".cont-dimensiones").hide();
		$(".cnt-hechos").hide();
		$('.actualizaHecho').hide();
		$('.actualizaDimension').hide();
		$("#indicaciones").hide();
	}

	<!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda en un arreglo las columnas del encabezado seleccionadas.
    * --->
	function columnaSeleccionada(){
		var columnas = [];
		var nivel;
		nivel = 0;
		$('.verde').each(function(){
			columnas.push($(this).attr('val-pkcolumna'));
			if (nivel == 0){
				if($(this).attr('nivel') != $("#nvls").val())
					nivel = 1;
			}
		});

		$("#pksColumnas").val(JSON.stringify(columnas));

		if(columnas.length > 1){
			$("#deseleccionar").show();
			document.getElementById("contDimensiones").className="panel panel-primary cont-dimensiones";
			document.getElementById("contHechos").className="panel panel-primary cnt-hechos";
			document.getElementById("asociaDimension").className="btn btn-primary";
			document.getElementById("asociaHecho").className="btn btn-primary";
			 
		}
			
		// Muestra las asociaciones cuando hay una columna seleccionada.
		if (columnas.length > 0){	
			$("#indicaciones").show();	
			$(".cont-dimensiones").show();
			$(".cnt-hechos").show();
		}else {
			$("#indicaciones").hide();
			$(".cont-dimensiones").hide();
			$(".cnt-hechos").hide();
		}

		//Si la columna seleccionada es de un nivel superior, no se muestra la asociación de métricas
		if(nivel == 1){
			$(".cnt-hechos").hide();
			}
		
		//Si solamente una columa seleccionada ya esta asociada solo permite actualizar.
		if ( $('.actualizaDimension').is(":visible") || $('.actualizaHecho').is(":visible") ){
			if (columnas.length == 1){
				$(".cont-dimensiones").hide();
				$(".cnt-hechos").hide();
			}   
		}


		//Si la columna esta asociada a una dimension, da la posibilidad de asociar a un hecho
		if ($('.actualizaDimension').is(":visible")){
			if(nivel == 0){
				$(".cnt-hechos").show();
			} else {
				$(".cnt-hechos").hide();			
			}	
		}

		//Si la columna esta asociada a un hecho, da la posibilidad de asociar a una dimension
		if ($('.actualizaHecho').is(":visible")){
			$(".cont-dimensiones").show();
			document.getElementById("inClasificacion").selectedIndex = "2";
		}


		//Si la columna esta asociada tanto a un hecho como a una columna, no da posibilidad de asociar nuevamente.
		if ($('.actualizaHecho').is(":visible") &&  $('.actualizaDimension').is(":visible")){
			if (columnas.length > 1){
				$(".cont-dimensiones").show();
				if(nivel == 0)
					$(".cnt-hechos").show();
				else 
					$(".cnt-hechos").hide();	
			}else {
				$(".cont-dimensiones").hide();
				$(".cnt-hechos").hide();
			}
		}


		if (columnas.length == 1){
			$("#deseleccionar").hide();
			document.getElementById("contDimensiones").className="panel panel-warning cont-dimensiones";
			document.getElementById("contHechos").className="panel panel-warning cnt-hechos";
			document.getElementById("asociaDimension").className="btn btn-warning";
			document.getElementById("asociaHecho").className="btn btn-warning";
			$('.verde').each(function(){
				getConfigDimensionColumna2($(this));
				getConfigHechoColumna2($(this));
			});			
		}
	}


	<!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Verifica las secciones mostradas de acuerdo a la unica columna seleccionada.
    * --->
	function columnaSeleccionada2(){
		var columnas = [];
		var nivel;
		nivel = 0;
		$('.verde').each(function(){
			columnas.push($(this).attr('val-pkcolumna'));
			if (nivel == 0){
				if($(this).attr('nivel') != $("#nvls").val())
					nivel = 1;
			}
		});

		$("#pksColumnas").val(JSON.stringify(columnas));

		// Muestra las asociaciones cuando hay una columna seleccionada.
		if (columnas.length > 0){
			$(".cont-dimensiones").show();
			$(".cnt-hechos").show();
		}else {
			$(".cont-dimensiones").hide();
			$(".cnt-hechos").hide();
		}
		
		//Si la columna seleccionada es de un nivel superior, no se muestra la asociación de métricas
		if(nivel == 1){
			$(".cnt-hechos").hide();
		}
		
		//Si la columna seleccionada es de un nivel superior, no se muestra la asociación de métricas
		if($("#nvl").val() ==  $("#nvls").val()){
			$(".cnt-hechos").show();
		} else {
			$(".cnt-hechos").hide();			
		}	
		
		//Si solamente una columa seleccionada ya esta asociada solo permite actualizar.
		if ($('.actualizaDimension').is(":visible") || $('.actualizaHecho').is(":visible") ){
			if (columnas.length == 1){
				$(".cont-dimensiones").hide();
				$(".cnt-hechos").hide();
			}   
		}

		//Si la columna esta asociada a una dimension, da la posibilidad de asociar a un hecho
		if ($('.actualizaDimension').is(":visible")){
			if(nivel == 0){
				$(".cnt-hechos").show();
			} else {
				$(".cnt-hechos").hide();			
			}
		}

		//Si la columna esta asociada a un hecho, da la posibilidad de asociar a una dimension
		if ($('.actualizaHecho').is(":visible")){
			$(".cont-dimensiones").show();
			document.getElementById("inClasificacion").selectedIndex = "2";
		}

		//Si la columna esta asociada tanto a un hecho como a una columna, no da posibilidad de asociar nuevamente.
		if ($('.actualizaHecho').is(":visible") &&  $('.actualizaDimension').is(":visible")){
			if (columnas.length > 1){
				$(".cont-dimensiones").show();
				$(".cnt-hechos").show();
			}else {
				$(".cont-dimensiones").hide();
				$(".cnt-hechos").hide();
			}
		}
	}


	<!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la seccion de dimension cuando solo una columna esta seleccionada.
    * --->
	function getConfigDimensionColumna2(columna){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getConfigDimenColumna")#</cfoutput>',{
                pkColumna: $(columna).attr('val-pkcolumna'),
                pkCubo: $("#pkCubo").val()
            },
            function(data){
                if (data.ROWCOUNT > 0){
                	$("#inDimensionUpdate").val(data.DATA.PKDIM[0]);
                	$("#inClasificacionUpdate").val(data.DATA.PKCLASIF[0]);
                	$("#pkDimCols").val(data.DATA.PKDIMCOLS[0]);
					getcolumasDimensionUpdate();
                	$("#inColDimUpdate").val(data.DATA.PKCOL[0]);
        			$(".actualizaDimension").css("display", "block");
        			$(".actualizaDimension .panel-heading strong").text($( columna).text() );
                	columnaSeleccionada2();
                }
            }
        );
	}


	<!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la seccion de hecho cuando solo una columna esta seleccionada.
    * --->
	function getConfigHechoColumna2(columna){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getConfigHechoColumna")#</cfoutput>',{
                pkColumna: $(columna).attr('val-pkcolumna'),
                pkCubo: $("#pkCubo").val()
            },
            function(data){
                if (data.ROWCOUNT > 0){
            		$("#inHechoUpdate").val(data.DATA.PKHECHO[0]);
            		$("#pkHechoColm").val(data.DATA.PKCOLHEC[0]);
            		$(".actualizaHecho").css("display", "block");
            		$(".actualizaHecho .panel-heading strong").text( $(columna).text() );
                	columnaSeleccionada2();
                }
            }
        );
	}


	<!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene el hecho y dimension al que esta asociada la columna.
	* -------------------------------
    * Descripcion de la modificacion:  Modificación para colocar la clasificación de manera automática.
    * Fecha de la modificacion: 06/06/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
	function getConfigColumna(Columna){	
	   pre = $(Columna).attr('panal');
	   if (pre=='1'){			<!--- ABJM   Color amarillo, es una celda analizada y se cambia a seleccionada, y se actualiza bandera en la BD --->
				$.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.update_AnalisisAutomatico")#</cfoutput>',{
                	pkColumna: $(Columna).attr('val-pkcolumna'),
                	pkCubo: $("#pkCubo").val()
            	},
            	function(data){
            		
            	}
        		);   
        		(Columna).setAttribute("panal", "0");       				
		}	
		$(".actualizaHecho").css("display", "none");
		$(".actualizaDimension").css("display", "none");

		var pkCol = $(Columna).attr('val-pkcolumna');
		$("#columnaActualizar").val(pkCol);

		getConfigDimensionColumna(Columna);
		getConfigHechoColumna(Columna);
	}


	<!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene la dimension a la que esta asociada la columna.
    * --->
	function getConfigDimensionColumna(columna){
		if ($(columna).hasClass('azul')){
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getConfigDimenColumna")#</cfoutput>',{
	                pkColumna: $(columna).attr('val-pkcolumna'),
	                pkCubo: $("#pkCubo").val()
	            },
	            function(data){
	                if (data.ROWCOUNT > 0){
	                	$("#inDimensionUpdate").val(data.DATA.PKDIM[0]);
	                	$("#inClasificacionUpdate").val(data.DATA.PKCLASIF[0]);
	                	$("#pkDimCols").val(data.DATA.PKDIMCOLS[0]);
						getcolumasDimensionUpdate();
	                	$("#inColDimUpdate").val(data.DATA.PKCOL[0]);
	        			$(".actualizaDimension").css("display", "block");
	        			$(".actualizaDimension .panel-heading strong").text($( columna).text() );
	                	columnaSeleccionada();
	                }
	            }
	        );
		}
	}


	<!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene el hecho al que esta asociada la columna.
    * --->
	function getConfigHechoColumna(columna){
		if ($(columna).hasClass('azul')){
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getConfigHechoColumna")#</cfoutput>',{
	                pkColumna: $(columna).attr('val-pkcolumna'),
	                pkCubo: $("#pkCubo").val()
	            },
	            function(data){
	                if (data.ROWCOUNT > 0){
	            		$("#inHechoUpdate").val(data.DATA.PKHECHO[0]);
	            		$("#pkHechoColm").val(data.DATA.PKCOLHEC[0]);
	            		$(".actualizaHecho").css("display", "block");
	            		$(".actualizaHecho .panel-heading strong").text( $(columna).text() );
	                	columnaSeleccionada();
	                }
	            }
	        );
	    }
	}


</script>
