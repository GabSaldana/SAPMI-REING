<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIIS
* Modulo:		Tiempos
* Fecha:		Agosto de 2017
* Descripcion:	CN de los tiempos de los convenios
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfcomponent>

    <cfproperty name="populator"	inject="wirebox:populator">
    <cfproperty name="wirebox"		inject="wirebox">
    <cfproperty name="cache"		inject="cachebox:default">
	<cfproperty name="DAO"			inject="adminCSII.tiempos.DAO_tiempos">
	<cfproperty name="daoEstado"	inject="utils.maquinaEstados.DAO_maquinaEstados">

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getProced" access="remote" hint="Obtiene todos los procedimientos">
		<cfscript>
			return DAO.getProced();
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllConvenios" access="remote" hint="Obtiene todos los convenios">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfscript>
			return DAO.getAllConvenios(proced);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllAreas" access="remote" hint="Obtiene todas las areas">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfscript>
			return DAO.getAllAreas(proced);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllEstados" access="remote" hint="Obtiene todos los estados de los convenios">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfscript>
			return DAO.getAllEstados(proced);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllRoles" access="remote" hint="Obtiene todos los roles de los convenios">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfscript>
			return DAO.getAllRoles(proced);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getTiempo" access="remote" hint="Obtiene el tiempo transcurrido de un convenio">
		<cfargument name="proced"		type="numeric"	required="yes" hint="filtra el tiempo por procedimiento">
		<cfargument name="area"			type="numeric"	required="yes" hint="filtra el tiempo por areas">
		<cfargument name="estado"		type="numeric"	required="yes" hint="filtra el tiempo por estados">
		<cfargument name="rol"			type="numeric"	required="yes" hint="filtra el tiempo por rol">
		<cfargument name="fechaInicio"	type="string"	required="yes" hint="filtra el tiempo por fecha de inicio">
		<cfargument name="fechaFin"		type="string"	required="yes" hint="filtra el tiempo por fecha de fin">
		<cfscript>
			//poblar todos los convenios existentes
			var registros = [];
			cont = 0;
			var convenios = DAO.getAllConvenios(proced);
			for(i = 1; i lte convenios.recordcount; i++){
				var fila = populator.populateFromQuery(wirebox.getInstance("adminCSII/tiempos/B_TIEMPO"),convenios,i);
				fila.setTIEMPOAREA(DAO.getTiempo(proced, convenios.PKCONVENIO[i], 1, estado, rol, fechaInicio, fechaFin));
				fila.setTIEMPODEP(DAO.getTiempo(proced, convenios.PKCONVENIO[i], 2, estado, rol, fechaInicio, fechaFin));
				fila.setTIEMPOTOTAL(DAO.getTiempo(proced, convenios.PKCONVENIO[i], 0, estado, rol, fechaInicio, fechaFin));
				fila.setESTADOACTUAL(daoEstado.obtenerEstadoActual(proced, convenios.PKCONVENIO[i]).NOM_EDO);
				if(fila.getTIEMPOTOTAL() != 0 ){
				 	arrayAppend(registros, fila);
					cont ++;
				}
			}
			
			//Poblar ultima fila para sumas
			if(cont > 1){
				var suma = structNew();
				var totalTotal = 0;
				var totalDependencia = 0;
				var totalArea = 0;

				for(fila in registros){
					totalDependencia += fila.getTIEMPODEP();
					totalArea += fila.getTIEMPOAREA();
					totalTotal += totalArea + totalDependencia;
				}

				var lastRow = populator.populateFromStruct(wirebox.getInstance("adminCSII/tiempos/B_TIEMPO"),suma,1);

				lastRow.setPKCONVENIO(0);
				lastRow.setCONVENIO('&##931;');
				lastRow.setOBJCONVENIO('SUMA TOTAL:');
				lastRow.setTIEMPOAREA(totalArea);
				lastRow.setTIEMPOTOTAL(totalTotal);
				lastRow.setTIEMPODEP(totalDependencia);
				arrayAppend(registros, lastRow);
			}
			return registros;
		</cfscript>
	</cffunction>

</cfcomponent>