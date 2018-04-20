
<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 14 de agosto de 2015
* Descripcion: 
* Objeto encargado de proveer los servicios y la lógica de negocio del modelo en el caso de los conjuntos de datos.
* Autor:Arturo Christian Santander Maya 
* ================================
--->



<cfcomponent accessors="true" singleton  threadSafe="true" >
	
	<cfproperty name="dao" inject="adminCSII.tablasDinamicas.DAO_ConjuntosDatos">
	<cfproperty name="populator" inject="wirebox:populator">
	<cfproperty name="wirebox" inject="wirebox">
	<cfproperty name="cache" inject="cachebox:default">
	
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	
	<!---
	 	*Fecha :17 de agosto de 2015
	 	* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="obtenerConjuntosUsuario" hint="Obtiene la informacion de los conjuntos de datos y crea los objetos de dominio correspondientes" >
		<cfargument name="idUsuario">
		<cfscript>
			var conjuntos=[];
			var conjuntosUsuario=dao.obtenerConjuntosUsuario(idUsuario);
			
			for(var con in conjuntosUsuario){
				var conjunto=obtenerConjuntoPorId(con.idConjunto);
				arrayAppend(conjuntos, conjunto);
			}

			return conjuntos;
		
		</cfscript>
	</cffunction>


	<!---
		*Fecha :26 de octubre de 2015
		* @author Arturo Christian Santander Maya 
						
  	--->


<cffunction name="obtenerConjuntoPorId" hint=" Obtiene la informacion de un conjunto y construye el objeto de dominio">
		<cfargument name="idCon">
		<cfscript>
			
			var conjuntoC=cache.get("conjunto_"&idCon);
			if(!isNull(conjuntoC)){
				return conjuntoC;
			}
			else{
				var consulta=dao.obtenerConjuntoPorId(idCon);

				var consultaConjunto=consulta["conjunto"];
				var consultaColsCon=consulta["columnas"];

				var consultaDatos=consulta["datos"];

				var conjunto=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.ConjuntoDatos"),consultaConjunto);
				var columnas=[];

				var consultaCols = new query();
				consultaCols.setDBType("query");
				consultaCols.setAttributes(sourceQuery=consultaColsCon);
				var consultaColsRes = consultaCols.execute(sql="SELECT DISTINCT(ID),TIPO,NOMBRE,NOMBREGENERAL,DESCRIPCION,PRIORIDAD,ICONO,TIPODATO FROM sourceQuery ORDER BY orden");
				var infoCols = consultaColsRes.getResult();

				
				
				for(var x=1; x lte infoCols.recordcount; x++){
					var colId=infoCols["ID"][x];
					var colNombre=infoCols["NOMBRE"][x];
					var columna=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Columna"),infoCols,x);
				

					var consultaFiltros=new query();
					consultaFiltros.setDBType("query");
					consultaFiltros.setAttributes(sourceQuery=consultaColsCon);
					var consultaFiltrosRes = consultaFiltros.execute(sql="SELECT IDFILTRO AS ID, REPFILTRO AS REPRESENTACION,NOMBREFILTRO AS NOMBRE, DEFFILTRO AS DEFINICION FROM sourceQuery WHERE ID="&colId&" AND IDFILTRO IS NOT NULL");
					var filtrosCol=consultaFiltrosRes.getResult();

					var consultaAgregaciones=new query();
					consultaAgregaciones.setDBType("query");
					consultaAgregaciones.setAttributes(sourceQuery=consultaColsCon);
					var consultaAgregacionesRes = consultaAgregaciones.execute(sql="SELECT IDOPR AS ID, NOMBREOPR AS NOMBRE, DESCOPR AS DESCRIPCION, REPOPR AS REPRESENTACION FROM sourceQuery WHERE ID="&colId&" AND IDOPR IS NOT NULL");
					var agregacionesCol=consultaAgregacionesRes.getResult();
				
				
					var filtrosN=[];
					var agregacionesN=[];
				
					
					
					for(var i=1; i lte filtrosCol.recordcount; i++){
						var filtro=	populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Filtro"),filtrosCol,i);
						arrayAppend(filtrosN, filtro);
					}


					for(var i=1; i lte agregacionesCol.recordcount; i++){
						var agregacion=	populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Agregacion"),agregacionesCol,i);
						arrayAppend(agregacionesN, agregacion);

					}
					
				
					
					columna.setFiltros(filtrosN);
					columna.setAgregaciones(agregacionesN);
				
				
					

					arrayAppend(columnas, columna);
				} 

				conjunto.setColumnas(columnas);
				
				conjunto.setDatos(consultaDatos);
			
				cache.set("conjunto_"&idCon,conjunto,120,20);
				return conjunto;
				
			} 

		</cfscript>
	</cffunction>

	<!---
		*Fecha :30 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	<cffunction name="obtenerFiltrosColumna" hint="Obtiene los filtros posibles para una columna">
		<cfargument name="idCon">
		<cfargument name="idCol">
		<cfscript>
			var conjunto =obtenerConjuntoPorId(idCon);
			var columna=conjunto.obtenerColumnaPorId(idCol);
			var valores=conjunto.obtenerValoresPosiblesCol(idCol);
			var resultados={};
			
			resultados["filtros"]=columna.getFiltros();
			resultados["valores"]=valores;

			return resultados;
		</cfscript>
	</cffunction>






</cfcomponent>