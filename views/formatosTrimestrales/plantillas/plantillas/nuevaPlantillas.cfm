<!---
* =========================================================================
* IPN - CSII
* Sistema:	INTRANET EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:    16 de Mayo del 2016
* Descripcion:	Vista Principal de las Plantillas
* Autor: Isaul Nieto.
* =========================================================================
--->

<!--- handsontable --->
<link rel="stylesheet" type="text/css" href="/includes/js/handsontable/handsontable0.15.0-beta6/handsontable.full.min.css">
<script type="text/javascript" src="/includes/js/handsontable/handsontable0.15.0-beta6/handsontable.full.js"></script>
	<div class="row">
		<div class="form-group col-md-8">
			<label for="namePlantilla">
			Nombre de la Plantilla:
			</label><br />
			<div class="input-group gia-guardar-plant">
				<div id="calendario_solicitud">
					 <input type="text" class="form-control nombrePlantilla"  name="namePlantilla" id="namePlantilla" value="" >
				</div>
				<div class="input-group-btn">
					<button type='button' class='btn btn-primary guardar' title='Guardar Plantilla' id="setPlantilla" name="setPlantilla" onclick="setPlantillaNueva();">
						<i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row" >
		<div class="col-md-12">
			<div class="htCenter handsontable gia-datos" id="columnaCatalogo" style="height: 600px; overflow: hidden; width: 100%; background-color: #fafafa;" data-originalstyle="height: 600px; overflow: hidden; width: 100%;">
			</div>
		</div>
	</div>
<script>	
	
	
	
	<!---
	* Descripcion: Configuracion inicial del grid de Handsontable, 
	* Fecha: 17 de mayo del 2016
	* Autor: Isaul Nieto.
	--->  
var data1 = [
      [],
	  []
    ],

    container = document.getElementById('columnaCatalogo'),
    hot;
   
	hot = new Handsontable(container, {
		data: data1,
		colHeaders: true,
		rowHeaders: true,
		manualColumnResize: true,
		mergeCells: [ ],
		className : 'htMiddle',
		maxCols : 1,
		minCols :1,
		minRows :1,
		minSpareCols:0,
		minSpareRows :1,
		contextMenu: true,
		contextMenu: ['undo', 'redo', 'remove_row'],
		comments: true
	});
  
	<!---
	* Descripcion: Funcion que obtiene los valores del grid y hace la peticion del guardado de la plantilla
	* Fecha: 17 de mayo del 2016
	* Autor: Isaul Nieto.
	--->  
	function setPlantillaNueva(){
		if( namePlantilla.value == null || namePlantilla.value.length == 0 || /^\s+$/.test(namePlantilla.value)){
   			toastr.error('Error','Nombre en blanco');
   		}
   		else{
			var f = (hot.countRows(0)-1); // numero de filas
			valorColumnaPlantilla = new Array();
			for (var i =0; f > i; i++ ){
				var valor = hot.getDataAtCell(i,0);
				if((f-1) == i ){
					valorColumnaPlantilla[i] = valor  ;
				}else{
					valorColumnaPlantilla[i] = valor  + "@@";
				}
			}
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.setPlantilla")#</cfoutput>', { 
				nombrePlantilla: $("#namePlantilla").val(),
				valoresPlantilla: valorColumnaPlantilla.toString() }, 
			function(respuestaUR){
				if(respuestaUR == 1){
					alert("Plantilla Guardada.");
					location.reload();
				}
			});
		}
	}	
</script>