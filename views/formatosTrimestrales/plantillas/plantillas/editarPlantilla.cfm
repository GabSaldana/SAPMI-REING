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
		<div class="col-md-12 gia-save-ed">

			<button id="btnSave" name="btnSave" type="button" class="btn btn-primary btn-xs dim pull-left ml5 guardar" title="Guardar" onclick="guardaEdicionPlantilla();" style="font-size:13px;">
			   <i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i>
			</button>
		</div>
	</div>
	<div class="row ">
		<div class="col-md-12 gia-datos">
			<div class="htCenter handsontable" id="edicionPlantilla" style="height: 700px; overflow: hidden; width: 100%; background-color: #fafafa;" data-originalstyle="height: 700px; overflow: hidden; width: 100%;" >
			</div>
		</div>
	</div>
<script>
	
	<!---
	* Descripcion: Configuracion inicial del grid de Handsontable, 
	* Fecha: Diciembre 2016
	* Autor: Marco Torres
	--->  
var data1 = [<cfoutput>#prc.elementosPlant#</cfoutput>],

    container = document.getElementById('edicionPlantilla'),
    hotEdit;
 
   	hotEdit = new Handsontable(container, {
    	data: data1,
     	colHeaders: ['Elementos'],
     	rowHeaders:true,
     	columns:[{'data':'val'}],
	 	manualColumnResize: true,
	 	mergeCells: [ ],
	 	className : 'htMiddle',
	 	minSpareRows :1,
	 	contextMenu: true,
	 	contextMenu: ['undo', 'redo', 'remove_row']
	});
  
	<!---
	* Descripcion: Funcion para el guardado de de datos de la plantilla
	* Fecha: Diciembre 2016
	* Autor: Marco Torres
	--->
	function guardaEdicionPlantilla(){
		var valor= [];
		valor = hotEdit.getData();
		
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.updateValorPlantilla")#</cfoutput>', {
			PK_PLANTILLA : <cfoutput>#prc.pkPlantilla#</cfoutput>,
			datos: JSON.stringify(valor)
			}, 
			function(data){
				cargarEdicion(<cfoutput>#prc.pkPlantilla#</cfoutput>);
	    	}
		);
		
	}
</script>

</html>