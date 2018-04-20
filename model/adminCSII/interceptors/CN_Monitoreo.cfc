<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: MONITOREO
* Fecha: Mayo 29, 2015
* Descripcion: Componente de Negocio
* Autor: Sergio Eduardo Cuevas Olivares
* =========================================================================
--->
<cfcomponent>
	
	<cfscript>
		DAO =  CreateObject( 'component' , 'DAO_Monitoreo');
	</cfscript>
	
	<!---
	* Fecha : Mayo 29, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="registraAccesoUsuario" access="public" returntype="string">
		<cfargument name="pkUsuario"	type="numeric" required="yes" hint="">
		<cfargument name="ipHost"		type="string" required="yes" hint="">
		<cfargument name="navegador"	type="string" required="yes" hint="">
		<cfargument name="idioma"		type="string" required="yes" hint="">
		<cfargument name="plataforma"	type="string" required="yes" hint="">
		<cfargument name="version"		type="string" required="yes" hint="">
		<cfargument name="arquitectura" type="string" required="yes" hint="">
		<cfscript>
			return DAO.registraAccesoUsuario( arguments.pkUsuario, arguments.ipHost, arguments.navegador, arguments.idioma, arguments.plataforma, arguments.version, arguments.arquitectura );
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Mayo 29, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="registraAccionesUsuario" access="public">
		<cfargument name="pkMonitoreo"		type="numeric" required="yes" hint="">
		<cfargument name="metodoForm"		type="string" required="yes" hint="">
		<cfargument name="tContenido"		type="string" required="yes" hint="">
		<cfargument name="urlReferencia"	type="string" required="yes" hint="">
		<cfargument name="urlSolicitada"	type="string" required="yes" hint="">
		<cfargument name="parametros"		type="string" required="yes" hint="">
		<cfscript>
			return DAO.registraAccionesUsuario( arguments.pkMonitoreo, arguments.metodoForm, arguments.tContenido, arguments.urlReferencia, arguments.urlSolicitada, arguments.parametros );
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 02, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getAccesosRegistrados" access="public">
		<cfargument name="numeroPagina"		type="numeric" required="yes" hint="">
		<cfargument name="ur"				type="string" required="no" default="" hint="">
		<cfargument name="fechaIni"			type="string" required="no" default="" hint="">
		<cfargument name="fechaFin"			type="string" required="no" default="" hint="">
		<cfscript>
			return DAO.getAccesosRegistrados(arguments.numeroPagina, arguments.ur, arguments.fechaIni, arguments.fechaFin);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 02, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verDetalleAcceso" access="public">
		<cfargument name="pkAcceso"		type="numeric" required="yes" hint="">
		<cfscript>
			return DAO.verDetalleAcceso(arguments.pkAcceso);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Julio 03, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getNombresUR" access="public">
		<cfscript>
			return DAO.getNombresUR();
		</cfscript>
	</cffunction>
</cfcomponent>