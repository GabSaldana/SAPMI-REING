<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 25 de agosto de 2015
* Descripcion: 
* Objeto de negocio para las visualizaciones.
* Autor:Arturo Christian Santander Maya 
* ================================
--->




<cfcomponent accessors="true"  >
	<cfproperty name="id">
	<cfproperty name="conjunto">
	<cfproperty name="nombre">
	<cfproperty name="fechaCreacion">
	<cfproperty name="fechaUltMod">
	<cfproperty name="fechaPub">
	<cfproperty name="descripcion">
	<cfproperty name="definicion">
	<cfproperty name="vistaPrevia">
	<cfproperty name="tipo">
	<cfproperty name="columnas" type="array">
	<cfproperty name="propiedades" type="array">
	

	
	

	<cffunction name="init">
		<cfscript>
			propiedades=[];
			columnas=[];
			return this;
		</cfscript>
	</cffunction>	

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	<cffunction name="obtenerColumnaPorId" hint="Retorna la referencia a una columna de la visualizacion" >
		<cfargument name="idCol">
			<cfscript>
				for (var columna in columnas){
					if(columna.getId() eq idCol){
						return columna;
					}
				}
				return;
			</cfscript>
		
	</cffunction>

	
	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="eliminarColumna" hint="Elimina una columna de la visualizacion ">
		<cfargument name="idCol">
		<cfscript>
			for (var i =1;i<=arrayLen( columnas);i++){
				if(columnas[i].getId() eq idCol){
					ArrayDeleteAt(columnas,i);
			
				}
			}
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="agregarColumna" hint="Agrega una columan a la visualizacion">
		<cfargument name="columna">
		<cfscript>
			arrayAppend(columnas, columna);

		</cfscript>
	</cffunction>

	<!---
		*Fecha :9 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="obtenerColumnasOrdPorAgr" hint="Obtiene un arreglo de las columnas pertenecientes a la visualizacion ordenadas por agregacion">
		<cfscript>
			var columnasOrd=[];
			for (var columna in columnas){
				if (arrayIsEmpty(columna.getAgregaciones())){
					continue;	
				}
				arrayAppend(columnasOrd,duplicate(columna));
			}

			for (var i=2;i< arrayLen(columnasOrd);i++){
				var j=i;
				while(j>1 and columnasOrd[j-1].getAgregaciones()[1].getIdAgrColVis()>columnasOrd[j].getAgregaciones()[1].getIdAgrColVis()){
					arraySwap(columnasOrd,j-1,j);
					j--;
				}

			}
			  
			return columnasOrd;

		</cfscript>

	</cffunction>	


	<!---
		*Fecha :9 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="obtenerPropiedadPorId" hint="Obtiene una propiedad de la visualizacion">
		<cfargument name="idProp">
			<cfscript>
				for (var propiedad in propiedades){
					if(propiedad.getId() eq idProp){
						return propiedad;
					}
				}
				return;
			</cfscript>
		
	</cffunction>
	<!---
		*Fecha :11 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="obtenerFiltrosCadena" hint="Obtiene una cadena con los filtros agregados a la visualizacion">
		<cfscript>
			var filtrosCadena="";
			var esPrimerFlt=1;
			for (var col in columnas){
				var filtros=col.getFiltros();
				if(col.getTipo() eq "D" and not arrayIsEmpty(filtros)){
					var esPrimerVal=1;
					for(var flt in filtros){
						if (not esPrimerFlt){
							filtrosCadena=filtrosCadena&",";
						}
						if(esPrimerVal){
							filtrosCadena=filtrosCadena&" "&col.getNombre()&" "&flt.getRepresentacion()&" "&flt.getValor();
							esPrimerVal=0;
						}
						else{
							filtrosCadena=filtrosCadena&" "&flt.getValor();	
						}

						
						esPrimerFlt=0;
					}
				}

			}
			return filtrosCadena;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :12 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->


  	<cffunction name="obtenerFilasVisCadena" hint="Obtiene una cadena con las filas de la visualizacion">
		<cfscript>
			var filasCadena="";
			var esPrimerAgr=1;
			for (var col in columnas){
				if(col.getTipo() eq "M"){
					var agregaciones=col.getAgregaciones();
					for(var agr in agregaciones){
						if (not esPrimerAgr){
							filasCadena=filasCadena&",";
						}
						
						filasCadena=filasCadena&" "&agr.getNombre()&" ("&col.getNombre()&")";
						esPrimerAgr=0;
					}
				}

			}
			return filasCadena;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :13 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

  	<cffunction name="tieneDefinicion" hint="Evalua si existe una definicion para la visualizacion">
  		<cfscript>
  			if(len(definicion)>1){
  				return true;
  			}	
  			else{
  				return false;
  			}			
  		</cfscript>
  	</cffunction>


</cfcomponent>