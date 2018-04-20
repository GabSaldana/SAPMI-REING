
<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Editor de Visualizaciones 
* Fecha 21 de agosto de 2015
* Descripcion: 
* Objeto encargado de proveer los servicios y la lógica de negocio del modelo en el caso de las visualizaciones.
* Autor:Arturo Christian Santander Maya 
* ================================
--->

<cfcomponent accessors="true" singleton>
	<cfproperty name="daoConjuntos" inject="adminCSII.tablasDinamicas.DAO_ConjuntosDatos">
	<cfproperty name="populator" inject="wirebox:populator">
	<cfproperty name="wirebox" inject="wirebox">
	<cfproperty name="cache" inject="cachebox:default">
	
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!---
		*Fecha :26 de octubre de 2015
		* @author Arturo Christian Santander Maya 
	--->
	<cffunction name="obtenerVisualizacionesUsrCon" hint="Obtiene las visualizaciones pertenecientes al usuario y conjunto de datos seleccionados">
		<cfargument name="idUsr">
		<cfargument name="conjunto">
		<cfscript>
			var visUsuario=dao.obtenerVisualizacionUsrCon(idUsr,conjunto.getId());
			var visualizaciones=[];

			for(var vis in visUsuario){
				var visualizacion=obtenerVisualizacionPorId(vis.idVis,conjunto);
			
				arrayAppend(visualizaciones, visualizacion);
				
			}

			return visualizaciones;
		
		</cfscript>
	</cffunction>


	<!---
		*Fecha :27 de octubre de 2015
		* @author Arturo Christian Santander Maya 
	--->

	<cffunction name="obtenerVisualizacionPorId" hint="Obtiene los datos de una visualizacion y contruye su objeto de dominio">
		<cfargument name="idVis">
		<cfargument name="conjunto">
		<cfscript>
			var visualizacionC=cache.get("vis_"&idVis);
			if(!isNull(visualizacionC)){
				return visualizacionC;
			}
			else{

				var consulta=dao.obtenerVisualizacionPorId(idVis);

				var consultaVis=consulta["visualizacion"];
				var consultaTipo=consulta["tipo"];
				var consultaColsVis=consulta["columnas"];
				var consultaPropiedades=consulta["propiedades"];
				
				var visualizacion=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Visualizacion"),consultaVis);
				var tipoVis=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.TipoVisualizaciones"),consultaTipo);

				var consultaCols = new query();
				consultaCols.setDBType("query");
				consultaCols.setAttributes(sourceQuery=consultaColsVis);
				var consultaColsRes = consultaCols.execute(sql="SELECT DISTINCT(ID) FROM sourceQuery");
				var infoCols = consultaColsRes.getResult();


				var columnas=[];
				var propiedades=[];

				for (var x=1; x lte consultaPropiedades.recordcount; x++ ){
					var propiedad=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Propiedad"),consultaPropiedades,x);
					arrayAppend(propiedades, propiedad);
				}
				for(var x=1; x lte infoCols.recordcount; x++){
					var idCol=infoCols["ID"][x];
					var columna=duplicate(conjunto.obtenerColumnaPorId(idCol));
					if (not isNull(columna) ){
						
						var filtros=[];
						var agregaciones=[];

						var consultaFiltros=new query();
						consultaFiltros.setDBType("query");
						consultaFiltros.setAttributes(sourceQuery=consultaColsVis);
						var consultaFiltrosRes = consultaFiltros.execute(sql="SELECT IDFILTRO AS ID,VALFILTRO AS VALOR,IDFILTCOLVIS  FROM sourceQuery WHERE ID="&idCol&" AND IDFILTRO IS NOT NULL");
						var filtrosCol=consultaFiltrosRes.getResult();


						var consultaAgregaciones=new query();
						consultaAgregaciones.setDBType("query");
						consultaAgregaciones.setAttributes(sourceQuery=consultaColsVis);
						var consultaAgregacionesRes = consultaAgregaciones.execute(sql="SELECT IDOPR AS ID, IDAGRCOLVIS  FROM sourceQuery WHERE ID="&idCol&" AND IDOPR IS NOT NULL");
						var agregacionesCol=consultaAgregacionesRes.getResult();



						for(var i=1; i lte filtrosCol.recordcount; i++){
							var filtro=	duplicate(columna.obtenerFiltroPorId(filtrosCol["ID"][i]) );
							if (not isNUll(filtro) ){
								filtro.setValor(filtrosCol["VALOR"][i]);
								filtro.setIdFiltColVis(filtrosCol["IDFILTCOLVIS"][i]);
								arrayAppend(filtros, filtro);
							}
							
						}

						for(var i=1; i lte agregacionesCol.recordcount; i++){
							var agregacion=duplicate( columna.obtenerAgregacionPorId(agregacionesCol["ID"][i]) );
							if (not isNull(agregacion) ){
								agregacion.setIdAgrColVis(agregacionesCol["IDAGRCOLVIS"][i]);
								arrayAppend(agregaciones, agregacion);
							}
						}
						columna.setFiltros(filtros);
						columna.setAgregaciones(agregaciones);
						arrayAppend(columnas, columna);
					}
				
				}
					
				visualizacion.setTipo(tipoVis);				
				visualizacion.setColumnas(columnas);			
				visualizacion.setPropiedades(propiedades);

				cache.set("vis_"&idVis,visualizacion,120,20);
				return visualizacion;
			}		
			
		
		</cfscript>
	</cffunction>

	<!---
		*Fecha :27 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	<cffunction name="crearVisualizacion" hint="Crea una nueva visualizacion">
		<cfargument name="idUsr">
		<cfargument name="conjunto">
		<cfscript>
			var consultaIdVis=dao.crearVisualizacion(idUsr,conjunto.getId());
			var visualizacion=obtenerVisualizacionPorId(consultaIdVis,conjunto);
			return visualizacion;
		</cfscript>
	</cffunction>


	
	<!---
		*Fecha :27 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	<cffunction name="obtenerTiposVis" hint="Obtiene los tipos de visualizacion disponibles">
		<cfscript>
			var tipos=[];
			var consultaTipos=dao.obtenerTiposVis();
			for(var x=1; x lte consultaTipos.recordcount; x++){
				var tipo=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.TipoVisualizaciones"),consultaTipos,x);
					arrayAppend(tipos, tipo);
			} 

			
			return tipos;
		</cfscript>
	</cffunction>


	
	<!---
		*Fecha :27 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="eliminarVisualizacion" hint="Elimina una visualizacion">
		<cfargument name="idVis">
		<cfscript>

			try{
				var vistaPrevia=dao.eliminarVisualizacion(idVis);
				var pngPath=expandPath(vistaPrevia);
	    	
		    	if(fileExists(pngPath)){
		    		FileDelete(pngPath);
	    		}
	    		cache.clear("vis_"&idVis);
		
			}
			
			catch(any excpt){
			
				return excpt;
			
			}					
			
			return true;
		</cfscript>
	</cffunction>


	<!---
		*Fecha :27 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->


	<cffunction name="copiarVisualizacion" hint="Utiliza los datos de una visualizacion para crear una nueva ">
		<cfargument name="idVis">
		<cfargument name="idUsr">
		<cfargument name="conjunto">
		
		<cfscript>
		
			var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
			var consultaIdVis=dao.copiarVisualizacion(idVis,idUsr);
			var visualizacionC=obtenerVisualizacionPorId(consultaIdVis,conjunto);
			
			var pngPathOrg=expandPath(visualizacion.getVistaPrevia());
	    	var pngPathCp=expandPath(visualizacionC.getVistaPrevia());
	    	
	    	if(fileExists(pngPathOrg)){
	    		FileCopy(pngPathOrg, pngPathCp);
	    	}

	    	cache.set("vis_"&consultaIdVis,visualizacionC,120,20);
			return visualizacionC;
						
			
			

		</cfscript>
		
	</cffunction>


	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

  	<cffunction name="agregarComponenteVis" hint="Integra la agregacion  una metrica o dimension a una visualizacion">
		<cfargument name="idVis">
		<cfargument name="idCol">
		<cfargument name="conjunto">
		<cfargument name="idAgr">
		
		<cfscript>
			

			var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
			cache.clear("vis_"&idVis);
			var columna=visualizacion.obtenerColumnaPorId(idCol);
			

			if(isNull(columna) ){
				var consultaCol=dao.agregarColumnaVis(idVis,idCol);
				columna= populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Columna"),consultaCol);
				visualizacion.agregarColumna(columna);
			}
	
					
			var consultaAgr=dao.insertarAgregacionColVis(idVis,idCol,idAgr);
			var agregacion= populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Agregacion"),consultaAgr);

			columna.insertarAgregacion(agregacion);
			cache.set("vis_"&idVis,visualizacion,120,20);

			if (columna.getTipo() eq 'M' and not isNUll(visualizacion.obtenerPropiedadPorId(1))){
				var tituloMetricas=visualizacion.obtenerFilasVisCadena();
				modificarValorPropiedadVis(idVis,1,tituloMetricas,conjunto);
			}
			
			return columna;
		</cfscript>
	</cffunction>	

	
	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	<cffunction name="cambiarTipoVisualizacion" hint="Modifica el tipo de una visualizacion">
		<cfargument name="idVis">
		<cfargument name="idTipoNuevo">
		<cfargument name="conjunto">
		<cfscript>
			try{	
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				var consulta=dao.cambiarTipoVisualizacion(idVis,idTipoNuevo);
				var consultaTipo=consulta["tipo"];
				var consultaPropiedades=consulta["propiedades"];
				var tipoVis=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.TipoVisualizaciones"),consultaTipo);
				var propiedades=[];

				for (var x=1; x lte consultaPropiedades.recordcount; x++ ){
					var propiedad=populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Propiedad"),consultaPropiedades,x);
					arrayAppend(propiedades, propiedad);
				}
				visualizacion.setPropiedades(propiedades);
				visualizacion.setTipo(tipoVis);	
				cache.set("vis_"&idVis,visualizacion,120,20);

				

			}
			
			catch(any excpt){
			
				return excpt;
			
			}					
			
			return visualizacion;
		
		
		
		</cfscript>
	</cffunction>


	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="cambiarNombreVis" hint="Cambia el nombre de una visualizacion">
		<cfargument name="idVis">
		<cfargument name="nombreNuevo">
		<cfargument name="conjunto">
		<cfscript>
			try{
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				dao.cambiarNombreVis(idVis,nombreNuevo);
				visualizacion.setNombre(nombreNuevo);
				cache.set("vis_"&idVis,visualizacion,120,20);

				
			}
			
			catch(any excpt){
			
				return excpt;
			
			}					
			
			return true;

		</cfscript>
		
	</cffunction>
	
	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="cambiarDescVis" hint="Modifica la descripcion de una visualizacion">
		<cfargument name="idVis">
		<cfargument name="descNueva">
		<cfargument name="conjunto">
		<cfscript>
			try{
				
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				dao.cambiarDescVis(idVis,descNueva);
				visualizacion.setDescripcion(descNueva);
				cache.set("vis_"&idVis,visualizacion,120,20);
		
			}
			
			catch(any excpt){
			
				return excpt;
			
			}					
			
			return true;

		</cfscript>
		
	</cffunction>


	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

  	<cffunction name="eliminarComponenteAgrVis" hint="Elimina la agregacion de una metrica o una dimension de la visualizacion">
		<cfargument name="idVis">
		<cfargument name="idCol">
		<cfargument name="idAgrColVis">
		<cfargument name="conjunto">
		
		
		<cfscript>
			
			try {
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				columna=visualizacion.obtenerColumnaPorId(idCol);
				dao.eliminarAgregacionColVis(idAgrColVis);
				columna.eliminarAgregacion(idAgrColVis);
				if(arrayIsEmpty(columna.getAgregaciones()) and arrayIsEmpty(columna.getFiltros()) ){
					dao.eliminarColumnaVis(idVis,idCol);
					visualizacion.eliminarColumna(idCol);
				}
				
				cache.set("vis_"&idVis,visualizacion,120,20);
				if (columna.getTipo() eq 'M' and not isNUll(visualizacion.obtenerPropiedadPorId(1))){
					modificarValorPropiedadVis(idVis,1,"",conjunto);
				}
			}
			catch(any excpt){
				return excpt;
			}					
			
			return true;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

  	<cffunction name="agregarFiltroVis" hint="Agrega un filtro para una demension a una visualizacion">
		<cfargument name="idVis">
		<cfargument name="idCol">
		<cfargument name="conjunto">
		<cfargument name="idFlt">
		<cfargument name="valFlt">
		
		<cfscript>
			
	
			var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
			cache.clear("vis_"&idVis);
			var columna=visualizacion.obtenerColumnaPorId(idCol);
			

			if(isNull(columna) ){
				var consultaCol=dao.agregarColumnaVis(idVis,idCol);
				columna= populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Columna"),consultaCol);
				visualizacion.agregarColumna(columna);
			}
		
			if (columna.getTipoDato() eq 2){
				valFlt="'"&valFlt&"'";
			}			
			var consultaFlt=dao.insertarFiltroColVis(idVis,idCol,idFlt,valFlt);
			var filtro= populator.populateFromQuery(wirebox.getInstance("adminCSII.tablasDinamicas.Filtro"),consultaFlt);
				
			columna.insertarFiltro(filtro);

			var filtrosTitulo=visualizacion.obtenerFiltrosCadena();
				
			cache.set("vis_"&idVis,visualizacion,120,20);
			modificarValorPropiedadVis(idVis,0,filtrosTitulo,conjunto);
			return columna;

		</cfscript>
	</cffunction>


	<!---
		*Fecha :3 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

  	<cffunction name="eliminarComponenteFltVis" hint="Elimina un fitro de una una visualizacion ">
		<cfargument name="idVis">
		<cfargument name="idCol">
		<cfargument name="idFiltColVis">
		<cfargument name="conjunto">
		
		
		<cfscript>
			
			try {
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				columna=visualizacion.obtenerColumnaPorId(idCol);
				dao.eliminarFiltroColVis(idFiltColVis);
				columna.eliminarFiltro(idFiltColVis);
				if(arrayIsEmpty(columna.getAgregaciones()) and arrayIsEmpty(columna.getFiltros()) ){
					dao.eliminarColumnaVis(idVis,idCol);
					visualizacion.eliminarColumna(idCol);
				}
				var filtrosTitulo=visualizacion.obtenerFiltrosCadena();
				cache.set("vis_"&idVis,visualizacion,120,20);
				modificarValorPropiedadVis(idVis,0,filtrosTitulo,conjunto);
			}
			catch(any excpt){
				return excpt;
			}					
			
			return true;
		</cfscript>
	</cffunction>


	<!---
		*Fecha :3 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->


	<cffunction name="filtrarDatos" hint="Aplica los filtros definidos en una visualizacion al los datos del conjunto ">
		<cfargument name="visualizacion">
		<cfargument name="conjunto">
		
		<cfscript>
			var datos=duplicate(conjunto.getDatos());
			var columnas=visualizacion.getColumnas();
			var numFiltCol=0;
			var filtConsulta="";

			for (var columna in columnas){
				var filtros=columna.getFiltros();
				if(arrayIsEmpty(filtros)){
					continue;
				}
				numFiltCol++;
				
				if(numFiltCol>1){
					filtConsulta=filtConsulta&" AND ";						
				}
				var numFilt=0;
				var filtCol="(";
				for(var filtro in filtros){
					numFilt++;
					if(numFilt>1){
						filtCol=filtCol&" OR ";	
					}	
					filtCol=filtCol&"COL_"&columna.getId()&filtro.getRepresentacion()&filtro.getValor();
				
				} 		
				filtConsulta=filtConsulta&filtCol&")";
			}
			

			if (numFiltCol){
				var consultaFiltro = new query();
				consultaFiltro.setDBType("query");
				consultaFiltro.setAttributes(sourceQuery=datos);
				consultaFiltroRes = consultaFiltro.execute(sql="SELECT * FROM sourceQuery WHERE "&filtConsulta&"");
				datos = consultaFiltroRes.getResult();
			}

			
			return datos;

		</cfscript>
	</cffunction>




	<!---
		*Fecha :3 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

 
	<cffunction name="obtenerDefinicionVisualizacion" hint="Crea la definicion (cadena JSON utilizada para la creacion de la grafica) para la visualizacion a partir de los datos del conjunto ">
		<cfargument name="idVis">
		<cfargument name="conjunto">
		
		<cfscript>
			
			var visualizacion= obtenerVisualizacionPorId(idVis,conjunto);
			cache.clear("vis_"&idVis);
			var tipo=visualizacion.getTipo();
			var definicion=deserializeJSON(FileRead(ExpandPath(tipo.getDefinicion())));
			var datosVis=filtrarDatos(visualizacion,conjunto);
			switch(tipo.getClasificacion()){
				case "MultiCol":
					definicionMultiCol(visualizacion,definicion,datosVis);
				break;
				case "MonoCol":
					definicionMonoCol(visualizacion,definicion,datosVis);
				break;
			}
			agregarPropiedadesDef(visualizacion,definicion);
			visualizacion.setDefinicion(SerializeJSON(definicion));
			dao.actualizarDefinicionVisualizacion(idVis,SerializeJSON(definicion));	
			cache.set("vis_"&idVis,visualizacion,120,20);
			return definicion;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :3 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="definicionMonoCol" hint="Crea la definicion de los datos para graficas de una sola dimension(columna)">
		<cfargument name="visualizacion">
		<cfargument name="definicion">
		<cfargument name="datosVis">
		
		<cfscript>
			var columnas=visualizacion.getColumnas();
			for (var columna in columnas){
				var agregaciones=columna.getAgregaciones();
				if(columna.getTipo() eq 'D' and not arrayIsEmpty(agregaciones)){
					var dimension=columna;
				}
				if(columna.getTipo() eq 'M' and not arrayIsEmpty(agregaciones)){
					var metrica=columna;
				}

			}



			var consultaAgregacion = new query();
			consultaAgregacion.setDBType("query");
			consultaAgregacion.setAttributes(sourceQuery=datosVis);
			consultaAgregacionRes = consultaAgregacion.execute(sql="SELECT COL_"&dimension.getId()&" as etiqueta, "&metrica.getAgregaciones()[1].getRepresentacion()&"(COL_"&metrica.getId()&") as valor FROM sourceQuery GROUP BY COL_"&dimension.getId());
			var valores=consultaAgregacionRes.getResult();
			

			for ( var i = 1 ; i LTE valores.recordcount ; i++ ){
				var str={};
				str["label"]=valores["etiqueta"][i];
				str["value"]=valores["valor"][i];
				arrayAppend(definicion["dataSource"]["data"],str);
				
			
			}
	
			return;
	
		</cfscript>
	</cffunction>


	<!---
		*Fecha :3 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="definicionMultiCol" hint="Crea la definicion de los datos para graficas de dos dimensiones(columna)">
		<cfargument name="visualizacion">
		<cfargument name="definicion">
		<cfargument name="datosVis">
		
		
		<cfscript>
			var columnas=visualizacion.getColumnas();
			var esDim=0;
			for (var columna in columnas){
				var agregaciones=columna.getAgregaciones();
				if(columna.getTipo() eq 'D' and not arrayIsEmpty(agregaciones)){
					if (esDim){
						if(agregaciones[1].getIdAgrColVis()>categoria.getAgregaciones()[1].getIdAgrColVis()){
							var dimension=categoria;
							categoria=columna;
						}
						else{
							var dimension=columna;
						}
						
					}
					else{
						esDim++;
						var categoria=columna;
					}
				}
				if(columna.getTipo() eq 'M' and not arrayIsEmpty(agregaciones)){
					var metrica=columna;
				}
 
			}

		
		
			var seriesConsultas=[];
			if (IsDefined("dimension")){
				
								
				var valoresDimension=valoresPosiblesConsulta("COL_"&dimension.getId(),datosVis);
				
				
				for(var i=1;i LTE valoresDimension.recordcount;i++){
					var serie={};
				
					var consultaAgregacion = new query();
					consultaAgregacion.setDBType("query");
					consultaAgregacion.setAttributes(sourceQuery=datosVis);
					if (dimension.getTipoDato() eq 2){
						consultaAgregacionRes = consultaAgregacion.execute(sql="SELECT COL_"&categoria.getId()&" as etiqueta, "&metrica.getAgregaciones()[1].getRepresentacion()&"(COL_"&metrica.getId()&") as valor FROM sourceQuery WHERE COL_"&dimension.getId()&"='"&valoresDimension["VALORES"][i]&"' GROUP BY COL_"&categoria.getId());
					}
					else{
						consultaAgregacionRes = consultaAgregacion.execute(sql="SELECT COL_"&categoria.getId()&" as etiqueta, "&metrica.getAgregaciones()[1].getRepresentacion()&"(COL_"&metrica.getId()&") as valor FROM sourceQuery WHERE COL_"&dimension.getId()&"="&valoresDimension["VALORES"][i]&"  GROUP BY COL_"&categoria.getId());
			
					}
					var valores=consultaAgregacionRes.getResult();

					serie["nombre"]=valoresDimension["VALORES"][i];
					serie["valores"]=valores;
					
					arrayAppend(seriesConsultas, serie);
				}
			
			}
			else{
				var serie={};

				var consultaAgregacion = new query();
				consultaAgregacion.setDBType("query");
				consultaAgregacion.setAttributes(sourceQuery=datosVis);
				consultaAgregacionRes = consultaAgregacion.execute(sql="SELECT COL_"&categoria.getId()&" as etiqueta, "&metrica.getAgregaciones()[1].getRepresentacion()&"(COL_"&metrica.getId()&") as valor FROM sourceQuery GROUP BY COL_"&categoria.getId());
				var valores=consultaAgregacionRes.getResult();
				serie["valores"]=valores;
				arrayAppend(seriesConsultas, serie);
			}
			
			
		

			var categoriaCont={};
			categoriaCont["category"]=[];
			var valoresCategoria=valoresPosiblesConsulta("COL_"&categoria.getId(),datosVis);	
			
			for(var i=1;i LTE valoresCategoria.recordcount;i++){
				var catStr={};
				catStr["label"]=ToString(valoresCategoria["VALORES"][i]);
				arrayAppend(categoriaCont["category"],catStr);
			}
			
			arrayAppend(definicion["dataSource"]["categories"], categoriaCont);

			for(var serieCon in seriesConsultas){
				var serie={};
				if (structKeyExists(serieCon, "nombre")){
					serie["seriesname"]=serieCon["nombre"];
				}
				serie["data"]=[];
				for(var i=1;i LTE valoresCategoria.recordcount;i++){
					var el={};
					for(var j=1;j LTE serieCon["valores"].recordcount;j++){
						if(serieCon["valores"]["ETIQUETA"][j] eq valoresCategoria["VALORES"][i]){
							el["value"]=serieCon["valores"]["VALOR"][j];
							break;
						}
					}
					if (not StructKeyExists(el, "value")){
						el["value"]=0;
					}
					arrayAppend(serie["data"], el);
				}
				arrayAppend(definicion["dataSource"]["dataset"], serie);				
			}
			
			
			return;
	
		</cfscript>
	</cffunction>


	<!---
		*Fecha :4 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="valoresPosiblesConsulta" hint="Obtiene los valores posibles para una columna del conjunto de datos" >
		<cfargument name="idCol">
		<cfargument name="consulta">
		<cfscript>
			
			var consultaDatosCol=new query();
			consultaDatosCol.setDBType("query");
			consultaDatosCol.setAttributes(sourceQuery=consulta);
			var consultaDatosColRes = consultaDatosCol.execute(sql="SELECT  DISTINCT("&idCol&") as VALORES FROM sourceQuery ");
			return consultaDatosColRes.getResult();	
		
		</cfscript>
	</cffunction>	


	<!---
		*Fecha :4 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="guardarImagenVis" hint="Convierte la imagen recibida a formato png y la almacena en el servidor">
		<cfargument name="idVis">
		<cfargument name="conjunto">
		<cfargument name="svg">
		
	    <cfscript>
	    	try {
	    		var visualizacion= obtenerVisualizacionPorId(idVis,conjunto);
		    	var svgPath=expandPath("/includes/img/reportesAdhoc/vistasVis/temp.svg");
		    	var pngPath=expandPath(visualizacion.getVistaPrevia());
		    	
		    	if(fileExists(pngPath)){
		    		FileDelete(pngPath);
		    	}
		    	if(fileExists(svgPath)){
		    		FileDelete(svgPath);
		    		}		
		    	FileWrite(svgPath,svg,"utf-8");
		    	
		    	var t=createObject("java", "org.apache.batik.transcoder.image.PNGTranscoder").init();
			    var svgURI = createObject("java", "java.io.File").init(svgPath).toURL().toString();	
		    	var input   = createObject("java", "org.apache.batik.transcoder.TranscoderInput").init(svgURI);
		    	var ostream   = createObject("java", "java.io.FileOutputStream").init(pngPath);
		    	var output  = createObject("java", "org.apache.batik.transcoder.TranscoderOutput").init(ostream);
		    	
		
				
		    	t.transcode(input, output);
		    	ostream.flush();
		    	ostream.close();

		    	FileDelete(svgPath);

	    	}
	    	catch(any excpt) {
	    		return excpt;
	    	} 
	    	
	    	return true;
	    </cfscript>    
	</cffunction>


	<!---
		*Fecha :5 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

  	<cffunction name="eliminarDefinicionVis" hint="Elimina la definicion de una visualizacion (cadena JSON utilizada para la creacion de la grafica)">
		<cfargument name="idVis">
		<cfargument name="conjunto">
		
		
		<cfscript>
			
			try {
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				dao.actualizarDefinicionVisualizacion(idVis,"");
				visualizacion.setDefinicion("");	

				var pngPath=expandPath(visualizacion.getVistaPrevia());
				
				if(fileExists(pngPath)){
			    		FileDelete(pngPath);
			    	}

							
				cache.set("vis_"&idVis,visualizacion,120,20);
			}
			catch(any excpt){
				return excpt;
			}					
			
			return true;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :9 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="modificarAgrCol" hint="Modifica la agregacion de una columna para una visualizacion">
		<cfargument name="idVis">
		<cfargument name="idAgrColVis">
		<cfargument name="idCol">
		<cfargument name="idAgr">
		<cfargument name="conjunto">
		<cfscript>
			try {
				
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				dao.modificarAgrCol(idAgrColVis,idAgr);
				var agregacion=duplicate(conjunto.obtenerColumnaPorId(idCol).obtenerAgregacionPorId(idAgr));
				var columna=visualizacion.obtenerColumnaPorId(idCol);
				columna.eliminarAgregacion(idAgrColVis);
				agregacion.setIdAgrColVis(idAgrColVis);
				columna.insertarAgregacion(agregacion);
				cache.set("vis_"&idVis,visualizacion,120,20);
				if (columna.getTipo() eq 'M' and not isNUll(visualizacion.obtenerPropiedadPorId(1))){
					var tituloMetricas=visualizacion.obtenerFilasVisCadena();
					modificarValorPropiedadVis(idVis,1,tituloMetricas,conjunto);
				}
			}
			catch(any excpt){
				return excpt;
			}					
			
			return true;
			
		</cfscript>
	</cffunction>

	<!---
		*Fecha :11 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="agregarPropiedadesDef" hint="Agrega las propiedades definidas para una visualizacion a su definicion">
			<cfargument name="visualizacion">
			<cfargument name="definicion">
			<cfscript>
				var propiedades=visualizacion.getPropiedades();
				for (var propiedad in propiedades){
					definicion["dataSource"]["chart"][propiedad.getDefinicion()]=propiedad.getValor();
				}
			</cfscript>
	</cffunction>			

	<!---
		*Fecha :11 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="modificarValorPropiedadVis" hint="Modifica el valor de una propiedad asociada a una visualizacion">
		<cfargument name="idVis">
		<cfargument name="idProp">
		<cfargument name="valor">
		<cfargument name="conjunto">
		<cfscript>
			try {
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
				cache.clear("vis_"&idVis);
				dao.modificarValorPropiedadVis(idVis,idProp,valor);
				var propiedad=visualizacion.obtenerPropiedadPorId(idProp);
				propiedad.setValor(valor);
				cache.set("vis_"&idVis,visualizacion,120,20);
			}
			catch(any excpt){
				return excpt;
			}					
				
			return true;
			
		</cfscript>
	</cffunction>

	
	<!---
		*Fecha :18 de noviembre de 2015
		* @author Arturo Christian Santander Maya 
  	--->


	<cffunction name="obtenerPropiedadVis" hint="Obtiene la propiedad de una visualizacion">
		<cfargument name="idVis">
		<cfargument name="idProp">
		<cfargument name="conjunto">
		<cfscript>
			try {
				var visualizacion=obtenerVisualizacionPorId(idVis,conjunto);
			    var propiedad=visualizacion.obtenerPropiedadPorId(idProp);
			}
			catch(any excpt){
				return excpt;
			}					
				
			return propiedad;
			
		</cfscript>
	</cffunction>





</cfcomponent>	



