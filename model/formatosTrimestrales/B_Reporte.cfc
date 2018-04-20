<cfcomponent accessors="true"  >
	<cfproperty name="nombre" 					hint="nombre del formato">
	<cfproperty name="clave" 					hint="clave del formato">
	<cfproperty name="version"					hint="version del formato">
	<cfproperty name="vigencia"					hint="version del formato">
	<cfproperty name="UR"						hint="unidad responsable de la captura">
	<cfproperty name="URnombre"						hint="unidad responsable de la captura">
	<cfproperty name="clasificacion"			hint="unidad responsable de la captura">
	<cfproperty name="filafija"					hint="Indica si el numero de filas es exacto">
	<cfproperty name="instrucciones"			hint="instrucciones de captura">
	
	<cfproperty name="periodo"					hint="nombre del periodo del reporte solo en (en la captura)">
	
	<cfproperty name="pkCFormato"				hint="pk de la tabla CFORMATO">
	<cfproperty name="pkTFormato"				hint="pk de la tabla Tformato">
	<cfproperty name="pkPeriodo"				hint="pk del periodo (en la captura)">
	<cfproperty name="pkReporte"				hint="pk del reporte (en la captura)">
	<cfproperty name="pkProducto"				hint="pk del producto (en la captura)">

	<cfproperty name="encabezado"				hint="contiene la esructura del encabezado">
	<cfproperty name="filas" type="array"		hint="contiene las informacion capturada en un array de filas">

	<cfproperty name="agruparCol" default="0"	hint="pk de la columna de referencia para clacular subtotales">
	<cfproperty name="sumaFinal" default="1"	hint="bandera que indica si se realiza la suma final">
	
	
	<cfproperty name="pkColumnaSeccion" 		hint="pk de la columna que sirve de referencia para realizar la suma por secciones">
	<cfproperty name="pkPlantillaSeccion" 		hint="pk de la plantila que contiene las secciones">
	<cfproperty name="pkAsociacion" 			hint="pk de asociacion de las plantilas">
	<cfproperty name="secciones" 				hint="estructura con las secciones y los valores asociados">

	<cfproperty name="pkCatalogoOrigen"		hint="pk de la columna de origen del catalogo">
	<cfproperty name="pkCatalogoDestino"		hint="pk de la columna de destino del catalogo">	

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="init">
		<cfscript>
			var filas = [];
			this.setFilas(filas);
			return this;
		</cfscript>
	</cffunction>	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getJSONInformacion" hint="crea un JSON con las filas y celdas solo la informacion capturada">
		<cfscript>
			var filasJSON = '';
			/*crea un JSON  con las filas y celdas*/
			for(fila in this.getFilas()){
				filasJSON= filasJSON & fila.filaToJSON()&',';
			}
		</cfscript>
		<cfreturn filasJSON>
	</cffunction>
	
	<!---
    * Fecha : Febrero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="setInformacionSecciones" hint="agrega las celdas de secciones a todas las filas">
		<cfscript>
			for(fila in this.getFilas()){
				fila.agregarSeccion(this.getpkColumnaSeccion(),this.getsecciones());
			}
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getInformacionGeneral" hint="crea un JSON con las filas y celdas la informacion capturada mas el json del encabezado">
		<cfscript>
			var JSONinfo = ''; 
			 JSONinfo = JSONinfo &this.getEncabezado().getJSONPkUltimoNivel();
			 JSONinfo = JSONinfo & this.getJSONInformacion() ;
		</cfscript>
		<cfreturn JSONinfo>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getInformacionFinal" hint="crea un JSON con las filas y celdas la informacion capturada mas todas las configuraciones de sumas ">
		<cfscript>
			var JSONinfo = ''; 
			var tieneSecciones = false;

			/*en caso de tener secciones agrega la celda de secciones a la filas*/
			if(this.getpkColumnaSeccion() neq '' AND  arraylen(this.getsecciones()) neq 0){
				this.setInformacionSecciones();
				tieneSecciones = true;
			} 
			
			if (this.getagruparCol() eq 0 OR this.getagruparCol() eq ''){
				
				if(tieneSecciones){
					ordenarBycolumnaPK('seccion');
					JSONinfo = JSONinfo & this.getJSONSumas(tieneSecciones);
				} else {
					JSONinfo = JSONinfo & this.getJSONInformacion();
				}
			} else {
				ordenarBycolumnaPK(this.getagruparCol());
				/*si tiene secciones ordena la filas de acuerdo a la columna de secciones*/
				if(tieneSecciones)
					ordenarBycolumnaPK('seccion');
				JSONinfo = JSONinfo & this.getJSONSumas(tieneSecciones);
			}
			
			if (this.getSumaFinal() eq 1){
				JSONinfo = JSONinfo & this.getJSONSumaFinal();
			}
		
		</cfscript>
		<cfreturn JSONinfo>
	</cffunction>	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getJSONSumas" hint="crea un JSON con las filas y celdas la informacion capturada mas las configuraciones de sumas por columna">
		<cfargument name="tieneSecciones">
		<cfscript>
			var filasJSON = '';
			/*crea un JSON array con las filas y celdas*/
			var ant = '';
			var seccionant = '';
			
			for(fila in this.getFilas()){
				
				if(tieneSecciones){
					if (this.getagruparCol() neq 0 and this.getagruparCol() neq ''){
						if ((ant neq '' && fila.getCeldabyPKColumna(this.getagruparCol()).getValorcelda() neq ant)
							OR(seccionant neq '' && fila.getCeldabyPKColumna('seccion').getValorcelda() neq seccionant)){
							filasJSON= filasJSON & this.getSumasbyValor(ant,this.getagruparCol(),seccionant)&',';
						}
					}
					
					if (seccionant neq '' && fila.getCeldabyPKColumna('seccion').getValorcelda() neq seccionant){
						filasJSON= filasJSON & this.getSumasbyValor(seccionant,'seccion',seccionant)&',';
					}
				} else {
					if (ant neq '' && fila.getCeldabyPKColumna(this.getagruparCol()).getValorcelda() neq ant){
						filasJSON= filasJSON & this.getSumasbyValor(ant,this.getagruparCol(),'')&',';
					}
				}
				
				filasJSON= filasJSON & fila.filaToJSON()&',';
				
				if (this.getagruparCol() neq 0 and this.getagruparCol() neq ''){
				 ant = fila.getCeldabyPKColumna(this.getagruparCol()).getValorcelda();
				}
				if(tieneSecciones){
					seccionant = tostring(fila.getCeldabyPKColumna('seccion').getValorcelda());
				}
			}
			if (this.getagruparCol() neq 0 and this.getagruparCol() neq ''){
					filasJSON= filasJSON & this.getSumasbyValor(ant,this.getagruparCol(),seccionant)&',';
			}
			if(tieneSecciones){
				filasJSON= filasJSON & this.getSumasbyValor(seccionant,'seccion','')&',';
			}
		</cfscript>
		<cfreturn filasJSON>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="ordenarBycolumnaPK" hint="ordena el arreglo en base a la columna seleccionada (getagruparCol)">
		<cfargument name="pkColumna"  >
		<cfscript>
			var sortOrder = "asc";        
	        var sortType = "textnocase";
	        
	        var sortArray = arraynew(1);
	        var returnArray = arraynew(1);
	        
	        for(fila in this.getFilas()){
	        	var celda = fila.getCeldabyPKColumna(pkColumna);
	        	 arrayAppend(sortArray, ToString(celda.getValorcelda()));
			}
	        arraySort(sortArray,sortType,sortOrder);
	        for(valor in sortArray){
	            arrayAppend(returnArray,extraerFila(valor,pkColumna));
	        }
	        this.setFilas(returnArray);
		</cfscript>
	</cffunction>	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="extraerFila" hint="obtiene y elimina una fila del arreglo">
		<cfargument name="valor" >
		<cfargument name="pkColumna"  >
		
		<cfscript>
			var count = 1;
			for(fila in this.getFilas()){
	        	if (fila.getCeldabyPKColumna(pkColumna).getValorcelda() eq valor){
					var filareturn =  fila;
					ArrayDeleteAt(this.getFilas(),count);
					return filareturn;
				}
				count ++;
			}
		</cfscript>
	</cffunction>
		
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getSumasbyValor" hint="obtiene las sumas de un valor de la columna seleccionada (getagruparCol)">
		<cfargument name="valor" type="string">
		<cfargument name="pkColumna">
		<cfargument name="seccionActual">
		<cftry>
		<cfscript>
			/*se crea una estructura que contendra las sumas del reporte*/
			var structSumas = structnew();
			/*si essuma toria de seccion pone los valores que corresponden en la estructura*/
			if(pkColumna neq 'seccion'){
				structSumas["PK_FILA"] = 'SUBTOTAL';
				structSumas[pkColumna] = 'SUBTOTAL ' & valor; 
			} else {
				structSumas["PK_FILA"] = 'SUBTOTALSECCION';
				structSumas[this.getpkColumnaSeccion()] = 'SUBTOTAL SECCION ' & valor; 
			}
			/*recorre todas la filas para formar el json del reporte*/
			for(var fila2 in this.getFilas()){
				if(pkColumna neq 'seccion'){
					/*en caso de que tenga secciones realiza los calculos para esa columna en la seccion*/
					if(seccionActual neq ''){
						if (fila2.getCeldabyPKColumna(pkColumna).getValorcelda() eq valor
							AND fila2.getCeldabyPKColumna('seccion').getValorcelda() eq seccionActual 
							)
						{
							structSumas = fila2.sumarValoresToArray(structSumas);
						}
					} else {
						if (fila2.getCeldabyPKColumna(pkColumna).getValorcelda() eq valor){
							structSumas = fila2.sumarValoresToArray(structSumas);
						}
					}
				} else {
					/*calcula el total por cada seccion */
					if (fila2.getCeldabyPKColumna(pkColumna).getValorcelda() eq valor ){
						structSumas = fila2.sumarValoresToArray(structSumas);
					}
				}
			}
			return serializeJSON(structSumas);
		</cfscript>
			<cfcatch>
				<cfdump var=" " label="Error ">
					<h2>La configuraci&oacute;n de los subtotales no se realiz&oacute; correctamente</h2> <br>
					<h3>Favor de revisar la configuraci&oacute;n <strong>"Calcular SubTotales para cada grupo de valores en esta columna"</strong> en el m&oacute;dulo <strong>"&nbsp; <i class="fa fa-list-alt"></i>Configuraci&oacute;n de Formatos" </strong>. </h3> 				
				<cfabort>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getJSONSumaFinal" hint="obtiene las suma del reporte">
		<cfscript>
			var structSumas = structnew();
			structSumas["PK_FILA"] = 'TOTAL';
			structSumas[this.getagruparCol()] = 'TOTAL '; 
			for(var fila3 in this.getFilas()){
	        		structSumas = fila3.sumarValoresToArray(structSumas);
			}
			return serializeJSON(structSumas);
		</cfscript>
	</cffunction>	


	<cffunction name="getInformacionFinalAcumulado" hint="crea un JSON con las filas y celdas la informacion capturada mas todas las configuraciones de sumas ">
   		<cfargument name="periodo">
		<cfscript>
			var JSONinfo = ''; 
			var tieneSecciones = false;

			/*en caso de tener secciones agrega la celda de secciones a la filas*/
			if(this.getpkColumnaSeccion() neq '' AND  arraylen(this.getsecciones()) neq 0){
				this.setInformacionSecciones();
				tieneSecciones = true;
			} 
			
			if (this.getagruparCol() eq 0 OR this.getagruparCol() eq ''){
				JSONinfo = JSONinfo & this.getJSONInformacion();
			} else {
				ordenarBycolumnaPK(this.getagruparCol());
				/*si tiene secciones ordena la filas de acuerdo a la columna de secciones*/
				if(tieneSecciones)
					ordenarBycolumnaPK('seccion');
				JSONinfo = JSONinfo & this.getJSONSumas(tieneSecciones);
			}
			
			if (this.getSumaFinal() eq 1){
				JSONinfo = JSONinfo & this.getJSONSumaFinalAcumulado(periodo);
			}


			/* var z = serializeJSON(JSONinfo);
			writedump(isJSON(z));
			abort; */

		</cfscript>
		<cfreturn JSONinfo>
	</cffunction>



   	<cffunction name="getJSONSumaFinalAcumulado" hint="obtiene las suma del reporte">
   		<cfargument name="periodo">
		<cfscript>
			var structSumas = structnew();
			structSumas["PK_FILA"] = 'TOTAL';
			
			if(periodo eq 1){
				structSumas[this.getagruparCol()] = 'Primer periodo'; 
			}
			if(periodo eq 2){
				structSumas[this.getagruparCol()] = 'Segundo periodo'; 
			}
			if(periodo eq 3){
				structSumas[this.getagruparCol()] = 'Tercer periodo'; 
			}
			if(periodo eq 4){
				structSumas[this.getagruparCol()] = 'Cuarto periodo'; 
			}


			for(var fila3 in this.getFilas()){
	        		structSumas = fila3.sumarValoresToArray(structSumas);
			}
			return serializeJSON(structSumas);
		</cfscript>
	</cffunction>	



</cfcomponent>