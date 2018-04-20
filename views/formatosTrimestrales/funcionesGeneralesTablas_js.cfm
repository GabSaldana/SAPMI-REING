<script>


	var hot_guardar;				// A.B.J.M. Indica si hay nuevos cambios a guardar
	<!---
	* Fecha      : Febrero 2017
	* Autor      : Ana Juarez
	* Descripcion: elementos visuales de la carga de la vista de de la tabla (vista previa de la captura)
	* --->
	function cerrarColumna2(){
		
		$('#cont-columna').hide();
		$('#divConfiguracion').addClass('col-md-12').removeClass('col-md-8');
	}




   	<!--- Funciones para realizar el render de la tabla --->
    function firstRowRenderer(instance, td, row, col, prop, value, cellProperties) {
	    Handsontable.renderers.TextRenderer.apply(this, arguments);
	    td.style.color = 'white';
	    td.style.background = '#1c84c6';
	    td.style.align = 'center';
	    
	    cellProperties.readOnly = true
  	}
    
    function columnaBloqueada(instance, td, row, col, prop, value, cellProperties) {
	    Handsontable.renderers.TextRenderer.apply(this, arguments);
		td.style.fontWeight = 'bold';
		td.style.color = 'gray';
		td.style.background = '#BDBDBD';
	}
	
	function columnaFecha(instance, td, row, col, prop, value, cellProperties) {
	    Handsontable.renderers.TextRenderer.apply(this, arguments);
		td.style.fontWeight = 'bold';
		td.style.color = 'BLACK';
		td.style.background = '#1ab394';
	   	$(td).append("<span class='fa fa-calendar'></span>");	 
	}
	
	function columnaSumable(instance, td, row, col, prop, value, cellProperties) {
	    Handsontable.renderers.TextRenderer.apply(this, arguments);
	    td.style.fontWeight = 'bold';
		td.style.color = 'BLACK';
		td.style.background = '#49e';
	}	
	function columnaDropdown(instance, td, row, col, prop, value, cellProperties) {
	    Handsontable.renderers.TextRenderer.apply(this, arguments);
	    td.style.fontWeight = 'bold';
		td.style.color = 'BLACK';
	   	td.style.background = '#1ab394';
	   	$(td).append("<span class='fa fa-caret-square-o-down pull-right'></span>");	      
	}
	

	
	function columnaMonto(instance, td, row, col, prop, value, cellProperties) {
	    Handsontable.renderers.TextRenderer.apply(this, arguments);
	    td.style.fontWeight = 'bold';
		td.style.color = 'gray';
	   	td.style.background = '#eee';  
	}
	
	
	function noRender(instance, td, row, col, prop, value, cellProperties) {
	      Handsontable.renderers.TextRenderer.apply(this, arguments);	
	}
	
	Handsontable.renderers.registerRenderer('columnaSumable', 	columnaSumable);
	Handsontable.renderers.registerRenderer('columnaBloqueada', columnaBloqueada);
	Handsontable.renderers.registerRenderer('columnaDropdown', 	columnaDropdown);
	Handsontable.renderers.registerRenderer('columnaFecha', 	columnaFecha);
	Handsontable.renderers.registerRenderer('noRender', 		noRender);
	
	
	//Handsontable.editors.registerEditor('numericoCinco', 		numericoCinco);
	
	
		
	<!--- Funciones para realizar las sumas tabla --->
    function sumarTotal(changes,source) {
    	if(source === 'edit' || source === 'paste' || source ==='autofill'){
			var filasModificadas = getFilasModificadas(changes);
			for(x = 0;x< filasModificadas.length;x++){
				var i =  filasModificadas[x];
				var filaData = hot.getSourceDataAtRow(i);
				sumar(filaData,i);
			}
		}

		if (source === 'loadData') {
		 	return;
		}
		hot_guardar=1;
	}
	/* 
	
	*/
	function comprobarSumas(inicio) {
   		$('#wrapper').append('<div  class="cargandoDiv" style="position:absolute;top:0;left:0;width:100%;height:800%;background-color:gray;opacity:0.1;z-index;9999999999999999999;" ></div>');
		$('#mdl-cubrir').modal('show');
   		
   		for(x = inicio;x< hot.countRows()-1;x++){
			var filaData = hot.getSourceDataAtRow(x);
			sumar(filaData,x);
		}
		
		$('#mdl-cubrir').modal('hide');
		$('.cargandoDiv').remove();
	}

	function sumar(fila,numFila){
		for(elem in sumables){
    		for(sumable in sumables){
   				var sumatoria = 0;
    			var ArrayOrigen = sumables[sumable].origen;
    			var ArrayOperandos = sumables[sumable].operandos;
    			for(colOrigen in ArrayOrigen){	   
    				
					if(ArrayOperandos[colOrigen] == 1){
						sumatoria = sumatoria + Number(fila[ArrayOrigen[colOrigen]]);	
					} else {
    					sumatoria = sumatoria - Number(fila[ArrayOrigen[colOrigen]]);
    				}  	
    			}
    			fila[sumables[sumable].destino] = sumatoria;
	    	}
    	}
    	for(sumable in sumables){
    		hot.setDataAtRowProp(numFila,sumables[sumable].destino,fila[sumables[sumable].destino],'afterchange');
    	}  			
    }
	
	function getFilasModificadas(changes){
	
		var filasModificadas = [];
		var filaAnterior = null;

		for(celdaModificada in changes){
			var rowIndex = changes[celdaModificada][0];
			var columnIndex = changes[celdaModificada][1];
			if(rowIndex != filaAnterior){
				var oldValue = changes[celdaModificada][2];
				var newValue = changes[celdaModificada][3];
				
				if(oldValue !=newValue){
					filasModificadas.push(rowIndex);
				}
				filaAnterior = rowIndex;
			}
		}
		return filasModificadas;
	}
	
	function numericoCinco(){
	
		
	}
	
	<!--- Funciones de validacion de columnas --->
    numericoUno = /^\d{1}/;
  	cadenaDiez = function (value, callback, col,row) {
		if (value.toString().length > 10){
        	callback(false);
		} else {
			callback(true);
		}
  	}
  	
  	
  	numericoUno = /^(null|\d{0,1})$/;
  	numericoUnorequerido = /^\d{1}$/;
  	numericoCinco = /^(null|\d{0,5}$)/;
  	numericoCincoRequerido = /^\d{1,5}$/;
  	numericoDoce= /^(null|\d{0,12}$)/;							
  	numericoDoceRequerido = /^\d{1,12}$/; 						
  	  	 						 		   
  	numericoDocePN= /^(null|-?\d{0,12}$)/;							//* A.B.J.M. Nuevo tipo de datos: nmerico de 12 negativo y positivo.
  	numericoDoceRequeridoPN = /^-?\d{1,12}$/; 						//* A.B.J.M. Nuevo tipo de datos: nmerico de 12 negativo y positivo. Requerido.
	
	numericoDosDecimalesPN = /^(null|-?\d{0,12}.\d{0,2})$/;			//* A.B.J.M. Nuevo tipo de datos: nmerico de 12 con dos decimales negativo y positivo. 
  	numericoDosDecimalesRequeridoPN = /^-?\d{0,12}.\d{0,2}$/;		//* A.B.J.M. Nuevo tipo de datos: nmerico de 12 con dos decimales negativo y positivo. Requerido.
  	
  	numericoDosDecimales = /^(null|\d{0,12}.\d{0,2}|\d{0,12})$/;			 
 	numericoDosDecimalesRequerido= /^\d{0,12}.\d{0,2}$/;				
  	numericoTresDecimales= /^(null|\d{0,12}.\d{0,3}|\d{0,12})$/;
  	numericoTresDecimalesRequerido= /^\d{1,12}.\d{1,3}$/;
  	
  	cadenaDiez = function (value, callback, col,row) {
		if(value == null){
  				callback(true);
		} else {
			if (value.toString().length > 10){
		       	callback(false);
			} else {
				callback(true);
			}
		}
  	}
  	
  	cadenaDiezRequerida = function (value, callback) {
  		if(value == null){
  				callback(false);
		} else {
	  		if (value.toString().length > 10 || value.toString().length == 0 ){
	        	callback(false);
			} else {
				callback(true);
			}
  		}
  	}
  	
  	cadenaCincuenta = function (value, callback) {
		if(value == null){
  				callback(true);
		} else {
			if (value.toString().length > 50){
        		callback(false);
			} else {
				callback(true);
			}
		}
  	}
  	
  	cadenaCincuentaRequerida = function (value, callback) {
  		if(value == null){
  				callback(false);
		} else {
			if (value.toString().length > 50 || value.toString().length == 0 ){
	        	callback(false);
			} else {
				callback(true);
			}
		}
  	}
  	
  	cadenaDosCincuenta = function (value, callback) {
		if(value == null){
  				callback(true);
		} else {
			if (value.toString().length > 250){
	        	callback(false);
			} else {
				callback(true);
			}
		}
  		
  	}
  	
  	cadenaMilRequerida = function (value, callback) {
		if(value == null){
  				callback(false);
		} else {
			if (value.toString().length > 1000 || value.toString().length == 0 ){
	        	callback(false);
			} else {
				callback(true);
			}
		}
  	}
  	
  	cadenaMil = function (value, callback) {
  		if(value == null){
  				callback(true);
		} else {
			if (value.toString().length > 1000){
	        	callback(false);
			} else {
				callback(true);
			}
		}
  		
  	}
  	
  	cadenaDosCincuentaRequerida = function (value, callback) {
		if(value == null){
  				callback(false);
		} else {
			if (value.toString().length > 250 || value.toString().length == 0 ){
	        	callback(false);
			} else {
				callback(true);
			}
		}
  	}
  	cadenaDosCincuenta = function (value, callback) {
		if(value == null){
  				callback(true);
		} else {
			if (value.toString().length > 250){
	        	callback(false);
			} else {
				callback(true);
			}
		}
  	}
  	
  	
  	fechaNoRequerida = function (value, callback) {
		if (!value) {
			callback(true);
		} else {
			Handsontable.DateValidator.call(this, value, callback);
		}
  	}
  	
  	catalogoNoRequerido = function (value, callback) {
		if (!value) {
			callback(true);
		} else {
			Handsontable.AutocompleteValidator.call(this, value, callback);
		}
  	}
	
  	//Validador (Error: no deja limpiar las celdas de los catalogos dependientes)
  	catalogoRequerido = function(value, callback){
  		if(!value){
  			callback(false);
  		}
  		else{
  			Handsontable.AutocompleteValidator.call(this, value, callback);  			
  		}
  	}

  	cadenaCuatroMilRequerida = function (value) {
		if(value == null){
			return false;
		} else {
			if (value.toString().length > 4000 || value.toString().length == 0 ){
				return false;
			} else {
				return true;
			}
		}
	}

	seleccionMultiple = function (value) {
		return true;
	}

	seleccionUnica = function (value) {
		return true;
	}

	listaReordenable = function (value) {
		return true;
	}

	seleccionArchivo = function (value) {
		return true;
	}

	archivoRequerido = function (value) {
		if (value.length == 0){
			return false;
		}else {
			return true;
		}
	}

	fechaRequerida = function (value) {
		if (value == '') {
  			return false;
  		} else {
  			return true;
  		}
  	}
	
</script>