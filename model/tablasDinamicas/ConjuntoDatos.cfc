
<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 14 de agosto de 2015
* Descripcion: 
* Objeto de negocio para los conjuntos de datos.
* Autor:Arturo Christian Santander Maya 
* ================================
--->




<cfcomponent accessors="true" >
	<cfproperty name="id">
	<cfproperty name="nombre">
	<cfproperty name="fechaCreacion">
	<cfproperty name="fechaUltMod">
	<cfproperty name="fechaPub">
	<cfproperty name="descripcion">
	<cfproperty name="columnas" type="array">
	<cfproperty name="datos">
	

	<cffunction name="init">
		<cfscript>
			columnas=[];
			return this;
		</cfscript>
	</cffunction>

	<!---
		*Fecha :26 de octubre de 2015
		* @author Arturo Christian Santander Maya 
	--->
	<cffunction name="obtenerColumnaPorId" hint="Obtiene una columna del conjunto de datos">
		<cfargument name="idCol">
			<cfscript>
				for (columna in columnas){
					if(columna.getId() eq idCol){
						return columna;
					}
				}
				return ;
			</cfscript>
		
	</cffunction>	

	<!---
		*Fecha :26 de octubre de 2015
		* @author Arturo Christian Santander Maya 
	--->
	<cffunction name="obtenerValoresPosiblesCol" hint="Obtiene los valores posibles para una columna del conjunto de datos">
		<cfargument name="idCol">
		<cfscript>
			var consultaDatosCol=new query();
			consultaDatosCol.setDBType("query");
			consultaDatosCol.setAttributes(sourceQuery=datos);
			
			var consultaDatosColRes = consultaDatosCol.execute(sql="SELECT  DISTINCT(COL_"&idCol&") as VALORES FROM sourceQuery ");
			var datosCol=consultaDatosColRes.getResult();

			return datosCol;
		</cfscript>
	</cffunction>




</cfcomponent>