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

<!--- handsontable --->
<cfprocessingdirective pageEncoding="utf-8">

<cfinclude template="/views/formatosTrimestrales/funcionesGeneralesTablas_js.cfm">

<cfset encabezado = prc.reporte.getEncabezado()>
<cfset informacion = prc.reporte.getInformacionGeneral()>
<cfset opciones = prc.optionsmap>

<style>
	.footerAcciones{
		position: fixed;
	    bottom: 0px;
	    background-color:rgba(255,255,255,.9);
	    width:100%;
	    border-top:solid 2px #1ab394;
	    padding:5px;
	    z-index:100;
	}

	.notaModal{
		width: 300px;
		height: 300px;
		resize: none;
		padding: 10px 15px;
		box-sizing: border-box;
	}
</style>

<div class="container" >
	<div class="row">
		<div class="col-md-12">
			<div style=" width: 103%; margin-left:-29px;margin-top:-10px;">
				<div class="htCenter handsontable" id="columnaCatalogo"  style="height: 700px; overflow: hidden; width: 100%; background-color: #ddd;" data-originalstyle="height: 670px; overflow: hidden; width: 100%;" >
				</div>
			</div>
		</div>
	</div>
</div>


	<div class="row">
		<div class="footerAcciones">
			<div class="col-sm-3">
			</div>

			<div class="col-sm-6">
				<button type='button' class='col-sm-2  btn btn-primary btn-outline nextBtn dim btn-xs' style="margin-right: 15px"  title='Guardar Información' id="guardarInfo" name="guardarInfo" onclick="guardarInfo();">
					<i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i>
				</button><!---
				 <button type='button' class='btn btn-default btn-xs btn-outline dim pull-left ml5' style="margin-right: 15px" title='Guardar Plantilla' id="setPlantilla" name="setPlantilla" onclick="sumarTotal();">
					<i class="glyphicon glyphicon-plus" style="font-size:21px;"></i>
				</button> --->

				<button type='button' class='col-sm-2  btn btn-info btn-outline nextBtn dim btn-xs' style="margin-right: 15px"  title='Nota Técnica' id="notaTecnica" name="notaTecnica" onclick="notaTecnicaTabla();">
					<i class="glyphicon glyphicon-bookmark" style="font-size:21px;"></i>
				</button>

				<button type='button' class='col-sm-2  btn btn-success btn-outline nextBtn dim btn-xs' style="margin-right: 15px"  title='Añadir fila' id="anadirFila" name="anadirFila"  onclick="anadirFila();">
					<i class="glyphicon glyphicon-plus-sign" style="font-size:21px;"></i>
				</button>


				<button type='button' class='col-sm-2 btn btn-danger btn-outline nextBtn dim btn-xs' style="margin-right: 15px"  title='Eliminar fila' id="eliminarFila" name="eliminarFila"   onclick="eliminarFilaH();">
					<i class="glyphicon glyphicon-minus-sign" style="font-size:21px;"></i>
				</button>
				
				<button type='button' class='col-sm-2 btn btn-info btn-outline nextBtn dim btn-xs' style="margin-right: 15px"  title='Comprobar Sumas' id="comprobarSumas" name="comprobarSumas"   onclick="comprobarSumas(<cfoutput>#encabezado.getNiveles()#</cfoutput>);">
					<i class="fa fa-refresh" style="font-size:21px;"></i>
				</button>
				
				<cfoutput query="prc.acciones">
					<cfif listFind(ACCIONESCVE,'CapturaFT.Validacion','$')>
		        		<button class="col-sm-2 btn btn-sm btn-success guiaValidar btn-outline nextBtn dim btn-xs"  title="Validar Formato" onclick="cambiarEstadoRT('CapturaFT.Validacion','Validar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');"> <i class="fa fa-thumbs-o-up fa-2x"></i>
		        		</button>
		            </cfif>

		            <cfif listFind(ACCIONESCVE,'CapturaFT.Rechazo','$')>
		        		<button class="col-sm-2 btn btn-sm btn-warning guiaRechazar btn-outline nextBtn dim btn-xs"  title="Rechazar Formato" onclick="cambiarEstadoRT('CapturaFT.Rechazo','Rechazar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');"> <i class="fa fa-thumbs-o-down fa-2x"></i>
		        		</button>
		            </cfif>

		            <cfif listFind(ACCIONESCVE,'CapturaFT.Eliminar','$')>
		            	<button class="col-sm-2 btn btn-sm btn-danger guiaEliminar btn-outline nextBtn dim btn-xs"  title="Eliminar Formato" onclick="cambiarEstadoRT('CapturaFT.Eliminar','Eliminar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');"> <i class="fa fa-trash fa-2x"></i>
		        		</button>
		            </cfif>
	        	</cfoutput>

	        </div>

			<div class="col-sm-3">
			</div>
		</div>
	</div>


<div id="modal-Consulta" class="modal inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true"  data-keyboard="true">
    <div class="modal-dialog modal-lg " style="width:95%;height:90%;">
        <div class="modal-content">
            <div class="modal-header">
            <h4 class="modal-title">Vista Previa del Reporte</h4>
            </div>
            <div class="modal-body">
				<div id="divConsulta" style="overflow:auto;max-height:500px;"></div>
			</div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-default"><span class="fa fa-times"></span> Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div id="mdl-notaTabla" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-sm">
		<div class="modal-content" style="width:362px">
			<div class="modal-header">
				<button id="closeNota" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">Nota Técnica</h4>
			</div>
			<div class="modal-body">
				<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
					<label>Escribe una nota:</label>
				</cfif>
				<textarea id="notaTabla" class="notaModal alert-info" readonly></textarea>
			</div>
			<div class="modal-footer">
				<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
					<button id="btn-guardarNota" class="btn btn-info pull-right" onclick="guardarNotaTecnicaTabla();"><i class="fa fa-floppy-o"></i> Guardar nota</button>
				</cfif>
			</div>
		</div>
	</div>
</div>

<script>

	var hot;
	var data1 = [<cfoutput>#informacion#</cfoutput>];
	var container = document.getElementById('columnaCatalogo');
	var sumables= <cfoutput>#encabezado.getJSONSumables()#</cfoutput>;
	var selectedRow1;			// A.B.J.M. Indica la posición de la fila inicio de la selección
	var selectedCol1;			// A.B.J.M. Indica la posición de la columna inicio de la selección
	var selectedRow2;			// A.B.J.M. Indica la posición de la fila fin de la selección
	var selectedCol2;			// A.B.J.M. Indica la posición de la columna fin de la selección
	var rowplus;				// A.B.J.M. Para guardar la propiedad minSpareRows del handsontable
	var contenidoCatalogoOrigen = null;	//D.M.F		Para guardar el catalogo de origen al pegar

	selectedRow1 = -1;			// A.B.J.M. Inicializar en -1, para indicar que aun no a seleccionado alguna celda en la tabla
    selectedCol1 = -1;
    selectedRow2 = -1;
    selectedCol2 = -1;
    hot_guardar=0;				// A.B.J.M. No hay nuevos cambios a guardar

    var pkCatOrigen = <cfoutput>#prc.reporte.getpkCatalogoOrigen()#</cfoutput>;
    var pkCatDestino = <cfoutput>#prc.reporte.getpkCatalogoDestino()#</cfoutput>;


	$(document).ready(function () {
	
	    var optionsMap = <cfoutput>#serializeJSON(opciones)#</cfoutput> //D.M.F	Inicializacion del mapeo de dependencias

	  	
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Esta funciom sirve para poder visualizar el dropdown cuando esta al final de la pagina
		* --->
		console.time("Tempo Inicial");
    	var reset = false;
    	setInterval(function(){
           	var editor = hot.getActiveEditor();
          	if (editor && !reset && typeof editor.htContainer !=='undefined' ){
            	reset = true;
              	editor.htContainer.scrollIntoView(false);
          	}else
               reset = false;
       		},
       		100
       	);

		<!---
		* Descripcion: Configuracion inicial del grid de Handsontable,
		* Fecha: Diciembre 2016
		* Autor: Marco Torres
		--->

		hot = new Handsontable(container, { //Inicio Instancia HOT
		   	data: data1,
		    colHeaders: false,
		    <!--- 	colHeaders: [<cfoutput>#encabezado.getListaNombresEncabezado()#</cfoutput>], --->
		    rowHeaders: true,
		 	fixedRowsTop:<cfoutput>#encabezado.getNiveles()#</cfoutput>,
		 	manualColumnResize: false,
		 	className : 'htCenter',
		 	minRows :1,
		 	minSpareCols:0,
		 	minSpareRows :<cfoutput>#prc.reporte.getfilafija()#</cfoutput>,
		 	contextMenu: true,
		 	contextMenu: ['undo', 'redo', 'remove_row','row_above','row_below'],

			afterSelection: function (r, c, r2, c2) {							// A.B.J.M. Para guardar las celdas seleccionadas
                selectedRow1 = r;
                selectedCol1 = c;
                selectedRow2 = r2;
                selectedCol2 = c2;
            },

           // afterDeselect:function () {
           // 	if (selectedRow1 != -1){
           //     	hot.selectCell(selectedRow1, selectedCol1, selectedRow2, selectedCol2);
           //     }
           // },

		 	columns:[
			 	<cfoutput>
				 	<cfloop array="#encabezado.getColumnasUltimoNivel()#" index="columna">
						{
							"type":  "#columna.getType()#",
							"allowInvalid" : false,
							<cfif prc.reporte.getpkCatalogoDestino() neq columna.getpk_columna()>
								"source":  #serializeJSON(columna.getSource())#,
							</cfif>							
							"readOnly":  #columna.getbloqueada()#,
							"data":  "#columna.getData()#",
							<cfif #columna.getbloqueada()#>
								"renderer": "columnaBloqueada",
							<cfelse>
								"renderer": "#columna.getrenderer()#",
							</cfif>
							"strict": true,
							<cfif columna.getValidator() neq 'noValidator'>
								"validator": #columna.getValidator()#,
							</cfif>							
						},
					</cfloop>
			 	</cfoutput>
		 	],

		 	<!--- <cfoutput>#serializeJSON(encabezado.getColumnasUltimoNivel())#</cfoutput> ,--->
		 	mergeCells: <cfoutput>#encabezado.getMergeJSON()#</cfoutput>,
		 	afterChange:sumarTotal,
		 	beforeRemoveRow:eliminarfila,
		 	cells: 
		 		function (row, col, prop) {
				      var cellProperties = {};
			      if (row < <cfoutput>#encabezado.getNiveles()#</cfoutput>) {
			        cellProperties.renderer = firstRowRenderer; // uses function directly
			      }
			      return cellProperties;
		    	},
			afterSelectionEndByProp: function (r, c, r2, c2) {							// A.B.J.M. Para cargar la configuración de Información Columna en captura
				if((r <  <cfoutput>#encabezado.getNiveles()#</cfoutput>)&&(c == c2)&&(r == r2)){
                	cargarConfiguracionCol(r,c);
				}
				else{
					cerrarColumna();
				}
            },
            beforeChange: cambiarSeleccionCatalogo,
           	afterInit: setCatalogoInicio,           	
		}); //Fin Instancia HOT

	 	rowplus=hot.getSettings().minSpareRows;
	 	if(rowplus == 0){																		// A.B.J.M. Si es una tabla fija
  			hot.updateSettings({															// A.B.J.M. Para mostrar las acciones en español
  				contextMenu: {
					items: {
      					"undo": { name: 'Deshacer'},
      					"redo": { name: 'Rehacer'}
					}
      			}
  			});
  	 	} else{
	 		hot.updateSettings({																	// A.B.J.M. Para mostrar las acciones en español
	    		contextMenu: {
      				items: {
      					"undo": { name: 'Deshacer'},
      					"redo": { name: 'Rehacer'},
      					"hsep1": "---------",
      					"remove_row": { name: 'Eliminar Fila'	},
      					"hsep2": "---------",
        				"row_above": { name: 'Agregar fila arriba'},
        				"row_below": { name: 'Agregar fila abajo' }
      				}
    			}
  			});
  	//var opc = {items: {['undo', 'redo']}};
		}
  		editarBotones();  		

  		function cambiarSeleccionCatalogo(changes, source) {
  			
  			if (!changes) {
  				return;
  			}
  			var instance = this;  		

  			changes.forEach(function(change) {
  				if (change[1] == pkCatOrigen && source != "paste" && change[2] != change[3]) {  				  				
					instance.setDataAtRowProp(change[0], pkCatDestino, "");
  				}  				
  				var row = change[0];
  				var col = change[1];
  				var newValue = change[3];  				
  				var cellMeta,options;			
  				if (col == pkCatOrigen) {
  					setCatalogo.call(instance,row,newValue);
  					instance.render();
  				}

  				if(source == "paste"){  								  	
  					if(col == pkCatOrigen){
  						contenidoCatalogoOrigen = newValue;
  					}else if(col == pkCatDestino){
  						var control = $.inArray(newValue,optionsMap[contenidoCatalogoOrigen]);
  						if(control >= 0){
	  						instance.setDataAtRowProp(row, pkCatDestino,newValue);
	  					}else{	  							  					
	  						change[3] = null;
	  					}
	  					contenidoCatalogoOrigen = null;	  					
  					}			
  					instance.render();  					
  				}
  			});
  		}

  		function setCatalogoInicio() {  			
  			var instance = this;
	        var data = instance.getData();
  			var value;  			
  			var value2;
  			for (var row = 0; row < data.length-1; row++) {  				
  				value = data[row][pkCatOrigen];
  				value2 = data[row][pkCatDestino];
				instance.setDataAtRowProp(row, pkCatOrigen,value);
				instance.setDataAtRowProp(row, pkCatDestino,value2);
				instance.render();  				
  			}
  		}  	

  		function setCatalogo(row,value) {  			
  			var instance = this;
  			var opciones = optionsMap[value];		  			
  			instance.setCellMeta(row,instance.propToCol(pkCatDestino),'source',opciones);		
  			instance.setCellMeta(row,instance.propToCol(pkCatDestino),'allowInvalid',false);  			
  			instance.render();  			
  		}
	});


		<!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Belem Juárez Méndez
		* Descripcion: Para cargar la configuración de la columna seleccionada
		* --->
		function cargarConfiguracionCol(fila,columna){
			cargarVistaConfiguracionCol(fila,columna,<cfoutput>#encabezado.getNiveles()#</cfoutput>);
		}




		<!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Belem Juárez Méndez
		* Descripcion: Modifica los botones de añadir y eliminar fila, dependiendo si headsontable es fija o no
		* --->
		function editarBotones(){
			//alert(rowplus);
			if(rowplus == 0){
				document.getElementById("eliminarFila").setAttribute("style",'display:none;');
				document.getElementById("anadirFila").setAttribute("style",'display:none;');
			}
		}



	<!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Belem Juárez Méndez
		* Descripcion: Añade una fila al final del handsontable
		* --->
		function anadirFila(){
			hot.alter('insert_row');
		}

	<!---
		* Fecha      : Febrero 2017
		* Autor      : Ana Belem Juárez Méndez
		* Descripcion: Elimina una fila seleccionada del handsontable
		* --->
		function eliminarFilaH(){
			var aux, numMay, numMen,i,mensaje;

			if(selectedRow1!=-1){
				aux=1;
				if((selectedRow2-selectedRow1)<0){
					numMay = selectedRow1;
					numMen = selectedRow2;
			 	}else{
			 		numMay = selectedRow2;
					numMen = selectedRow1;
				}
				mensaje="Seguro(a) que deseas eliminar la(s) fila(s): ";
				for(i=numMen+1; i<=numMay+1;i++){
					mensaje = mensaje + i + ", ";
				}
				if (confirm(mensaje) == true) {
        			aux = aux + (numMay-numMen);
					hot.alter('remove_row',  selectedRow1,  aux);
   			 	}
			}
			else{
				alert("Necesitas seleccionar una o más filas para eliminar.");
			}
		}

	 	<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Elimina una fila de la base de datos
		* --->
		function eliminarfila(fila,num){
			/*crea un array con las filas a eliminar, solo las que tienen pk_fila*/
			var arrayEliminadas= [];
			for(i = 0;i<num;i++){
				filaData = hot.getSourceDataAtRow(fila+i);
				if(filaData['PK_FILA'] > 0){
					arrayEliminadas.push(filaData['PK_FILA']);
				}
			}
			if(arrayEliminadas.length > 0){
				$.post('capturaFT/eliminarFilas', {
					periodo: <cfoutput>#prc.reporte.getpkPeriodo()#</cfoutput>,
					pkCformato: <cfoutput>#prc.reporte.getpkCformato()#</cfoutput>,
					pkReporte: <cfoutput>#prc.reporte.getpkReporte()#</cfoutput>,
					arrayEliminadas: JSON.stringify(arrayEliminadas)
					},
					function(data){
						//$('#tabla').html( data );
			    	}
			    );
			}
		}

		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion:
		* --->
		function guardarInfo(){			

			var errores = 0;

		 	/*esto es para evitar un error muy extraño al momento de validar columnas con nombre muy largos*/
			 hot.updateSettings({
	            rowHeaders: false
	        });

			hot.validateCells(function(){
				//Hace que el encabezado sea valido
				for(var i = 0; i < <cfoutput>#encabezado.getNiveles()#</cfoutput>;i++){
				   for(var  j = 0;j< hot.countCols();j++ ){
				   		var celda=	hot.getCellMeta(i,j);
				   			celda.valid=true;
				   }
				}
				//Hace que la ultima fila sea valida
			   	for( var j = 0;j< hot.countCols();j++ ){
			   		var celda=	hot.getCellMeta(hot.countRows()-1,j);
			   			celda.valid=true;
			   	}
				hot.render();

				for(var i = <cfoutput>#encabezado.getNiveles()#</cfoutput>;i< hot.countRows()-1;i++){
				   for(var j = 0;j< hot.countCols();j++ ){
				   		var celda=	hot.getCellMeta(i,j);
				   		if (celda.valid == false){
				   			errores++;
				   		}
				   }
				}

				if(errores > 0){
		 			alert("Existen valores en las celdas que no cumplen con los tipos de dato requerido: " + errores);

		 			/*esto es para evitar un error muy extraño al momento de validar columnas con nombre muy largos*/
		 			/*hot.updateSettings({
			            rowHeaders: true
			        });
			        hot.render();*/
				} else {
			 		var valor= [];
					valor = hot.getData();

					if(confirm('¿Desea guardar la informacion?')){
						$.post('capturaFT/guardarinfo', {
							periodo: <cfoutput>#prc.reporte.getpkPeriodo()#</cfoutput>,
							pkTformato: <cfoutput>#prc.reporte.getpkTformato()#</cfoutput>,
							pkCformato: <cfoutput>#prc.reporte.getpkCformato()#</cfoutput>,
							pkReporte: <cfoutput>#prc.reporte.getpkReporte()#</cfoutput>,
							datos: JSON.stringify(valor)
							},

							function(data){
								
								if(validaReporte == 'validaReporte'){
									<cfoutput query="prc.acciones">
										<cfif listFind(ACCIONESCVE,'CapturaFT.Validacion','$')>
							        		<cfoutput>validarRT('CapturaFT.Validacion','Validar Formato', #pkreporte#,'#JSStringFormat(nombre)#','#JSStringFormat(PERIODO)#','#JSStringFormat(CLAVE)#', '#nombre#');</cfoutput>
								        </cfif>
						        	</cfoutput>
									
								} else {
									cargarTabla();
								}
							}
						);
						hot_guardar=0;									// A.B.J.M. Cambios guardados
					}
				}
			});
		}

		function validarRT(accion, textoAccion, pkRegistro, nombreFormato, periodoFormato, claveFormato, nombReportes){
			cambiarEstadoRT(accion, textoAccion, pkRegistro, nombreFormato, periodoFormato, claveFormato, nombReportes);
		}
		function notaTecnicaTabla(){
			$.post('capturaFT/cargarNota', {
				formato: $('#pkformato').val(),
				periodo: $('#pkperiodo').val(),
				reporte: $('#pkReporte').val()
			}, function(data){
				$("#mdl-notaTabla").modal('show');
				$('#notaTabla').val(data.DATA.NOTA[0]);
				<cfif listFind(prc.acciones.ACCIONESCVE,'CapturaFT.captura','$')>
					$('#notaTabla').prop('readonly', false);
				</cfif>
			});
		}

		function guardarNotaTecnicaTabla(){
			$.post('capturaFT/guardarNota', {
				formato: $('#pkformato').val(),
				periodo: $('#pkperiodo').val(),
				reporte: $('#pkReporte').val(),
				nota: $('#notaTabla').val()
			}, function(data){
				if (data > 0){
					toastr.success('','Nota Guardada');
					$("#mdl-notaTabla").modal('hide');
				} else{
					toastr.error('','Error al Guardar');
				}
		    });
		}
		
		function quitarRowHeader(){
	 		hot.updateSettings({
	            rowHeaders: true
	        });
				hot.render();
	        
	    }
	/*function sumarTotalFinal() {
		console.log(hot.countCols());
		for(i = 0;i< hot.countCols();i++){
		    $col = hot.getDataAtCol(i);
		    var sum = $col.reduce(function(a, b) {
		    	if(b!=null & !isNaN(a)){
			    	//if(typeof(a))
			    	return Number(a) + Number(b);
		    	} else {
		    		return a;
		    	}
		    });
		    var index = hot.getData().length;
		    if(!isNaN(sum)){
		    	hot.setDataAtCell(index - 1, i, sum);
		    }
		}
	}*/
</script>
