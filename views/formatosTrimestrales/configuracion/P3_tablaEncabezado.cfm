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

<cfinclude template="/views/formatosTrimestrales/funcionesGeneralesTablas_js.cfm">
 
<cfset encabezado = prc.reporte.getEncabezado()>
<cfset informacion = prc.reporte.getInformacionGeneral()>

<cfif arraylen(encabezado.getColumnas()) gt 0>
	<div class="row">
		<div class="col-md-12">
		   	<div class="htCenter handsontable" id="columnaCatalogo" style="height: 300px; overflow: hidden; width: 100%; background-color: #fefeff;" data-originalstyle="height: 300px; overflow: hidden; width: 100%;">
			</div>			
		</div>
	</div>	

	<script>	
		$(document).ready(function () {

		});
		<!---
		* Descripcion: Configuracion inicial del grid de Handsontable, 
		* Fecha: 
		* Autor: 
		--->  
		var data1 = [<cfoutput>#informacion#</cfoutput>];
		var container = document.getElementById('columnaCatalogo');
		var hot;
		var sumables= <cfoutput>#encabezado.getJSONSumables()#</cfoutput>;    
	    
	  	hot = new Handsontable(container, {
	    	data: data1,
	    	
		    colHeaders: false,
		    rowHeaders: false,
	    	<!--- 	//colHeaders: [<cfoutput>#prc.encabezadolista#</cfoutput>], --->
		 	manualColumnResize: true,
		 	mergeCells: <cfoutput>#encabezado.getMergeJSON()#</cfoutput>,
		 	className : 'htCenter',
		 	minRows :1,
		 	minSpareCols:0,
		 	minSpareRows :1,
		 	columns:
			 	 [
				 	<cfoutput>
					 	<cfloop array="#encabezado.getColumnasUltimoNivel()#" index="columna">
							{
								"type":  "#columna.getType()#",
								"source":  #serializeJSON(columna.getSource())#,
							"readOnly":  #columna.getbloqueada()#, 			// #columna.getReadOnly()#,			A.B.J.M Para que se vean reflejados los cambios de bloqueo de columnas
								"data":  "#columna.getData()#",
							<cfif #columna.getbloqueada()#>					//"renderer": "#columna.getrenderer()#",	A.B.J.M Para que se vean reflejados los cambios de bloqueo de columnas
								"renderer": "columnaBloqueada",
							<cfelse>
								"renderer": "#columna.getrenderer()#",
							</cfif>
								"strict": true,
								<cfif columna.getValidator() neq 'noValidator'>
									"validator": #columna.getValidator()#
								</cfif>
							},
						</cfloop>
				 	</cfoutput>
			 	], 
		 	afterChange:sumarTotal,
		 	cells: function (row, col, prop) {
	 		      var cellProperties = {};
			      if (row < <cfoutput>#encabezado.getNiveles()#</cfoutput>) {
			        cellProperties.renderer = firstRowRenderer; // uses function directly
			      }
			      return cellProperties;
		    },
		 	afterSelectionEndByProp: cargarConfiguracionCol
		});

		function cargarConfiguracionCol(fila,columna){
			cargarVistaConfiguracionCol(fila,columna,<cfoutput>#encabezado.getNiveles()#</cfoutput>);
		}	
	</script>

<cfelse>
	<div class="row">
		<div class="col-md-12">
			No existe la estructura del encabezado, Favor de capturarla.
		</div>
	</div>
</cfif>

</html>
