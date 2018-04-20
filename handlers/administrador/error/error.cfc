<!---
* =========================================================================
* IPN - CSII
* Sistema: SIPIFIFE - ADMINISTRADOR
* Modulo: ERRORES
* Sub modulo: ERRORES
* Fecha : Abril 13, 2015
* Autor : Sergio Eduardo Cuevas Olivares
* Descripcion: Handler para la mostrar los errores registrados
* =========================================================================
--->

<cfcomponent>
	<!---
	* Fecha : Abril 13, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="index" access="remote" returntype="void" output="false" hint="Carga datos para ver los errores">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn				= getModel("error.CN_Error");
			prc.tiposError		= cn.getTiposError();
			prc.nomUR			= cn.obtenerURs();
			Event.setView("error/Errores");
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verDetalleError" access="remote" returntype="void" output="false" hint="Ver detalle del error">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc 		  = Event.getCollection();
			var cn				= getModel("error.CN_Error");
			prc.informacion		= cn.verDetalleError(rc.pkError);
			prc.pkRegistro		= rc.pkError;
			Event.setView("error/DetalleError");
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="eliminarError" access="remote" returntype="void" output="false" hint="Eliminar error">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc 		  = Event.getCollection();
			var cn 		  = getModel("error.CN_Error");
			var resultado = cn.eliminarError( rc.pkError );
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>
	
	<!---
	* Modificacion : Se envia a la vista la fecha del error y las caracteristicas del archivo.
	* Fecha mod : Junio 05, 2015
	* Autor mod : Sergio E. Cuevas Olivares
	---------------------------------------
	* Fecha : Abril 20, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verErrorLinea" access="remote" returntype="void" output="false" hint="Visualiza la linea de error">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc 			= Event.getCollection();
			prc.archivo		= rc.nomArchivo;
			prc.linea		= rc.numeroLinea;
			prc.fechaError	= rc.fechaError;
			prc.info		= GetFileInfo(prc.archivo);
			
			Event.setView("error/LineaError").noLayout();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Abril 20, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verReferenciaDB_ORA" access="remote" returntype="void" output="false" hint="Visualiza paginas del ORA-0000X">
		<cfargument name="Event" type="any">
		<cfhttp url="https://docs.oracle.com/cd/B14117_01/appdev.101/a58231/appd.htm"></cfhttp>
		<cfscript>
			var rc 			= Event.getCollection();
			prc.contenido =  cfhttp.filecontent;
			Event.setView("error/ErrorDB").noLayout();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 04, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verTablaRegistros" access="remote" returntype="void" output="false" hint="Visualiza los registros">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn			= getModel("error.CN_Error");
			var rc			= Event.getCollection();
			prc.erroresReg	= cn.getErroresRegistrados(rc.numeroPagina, rc.tipoError, rc.ur, rc.fechaIni, rc.fechaFin);
			
			Event.setView("error/TablaErrores").noLayout();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="analisisInformacion" access="remote" returntype="void" output="no" hint="">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn				= getModel("error.CN_Error");
			var rc 				= Event.getCollection();
			
			prc.informacion		= cn.getListadoErrores(rc.pkRegistrosAz, rc.numeroPagina, rc.tipoError, rc.ur, rc.fechaIni, rc.fechaFin);
			Event.setView("error/AnalisisError").noLayout();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 16, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="consultaInformacion" access="remote" returntype="void" output="no" hint="">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn				= getModel("error.CN_Error");
			var rc 				= Event.getCollection();
			
			prc.erroresReg		= cn.obtenerListadoErrores(rc.pksRegistro);
			Event.setView("error/TablaRegistros").noLayout();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 24, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="visualizaDetalleError" access="remote" returntype="void" output="false" hint="Ver detalle del error">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc				= Event.getCollection();
			var cn				= getModel("error.CN_Error");
			prc.informacion		= cn.verDetalleError(rc.pkError);
			prc.pkRegistro		= rc.pkError;
			Event.setView("error/DetalleError").noLayout();
		</cfscript>
	</cffunction>
</cfcomponent>