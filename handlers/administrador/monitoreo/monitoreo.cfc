<!---
* =========================================================================
* IPN - CSII
* Sistema: SIPIFIFE - ADMINISTRADOR
* Modulo: Monitoreo
* Sub modulo: monitoreo
* Fecha : Junio 01, 2015
* Autor : Sergio Eduardo Cuevas Olivares
* Descripcion: Handler para visualizar el monitoreo de los accesos que realiza el usuario
* =========================================================================
--->

<cfcomponent>
	<!---
	* Fecha : Junio 01, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="index" access="remote" returntype="void" output="false" hint="">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn				= getModel("interceptors.CN_Monitoreo");
			prc.nomUR			= cn.getNombresUR();
			
			Event.setView("monitoreo/Accesos");
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 01, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verSeguimiento" access="remote" returntype="void" output="false" hint="">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc 		  = Event.getCollection();
			var cn				= getModel("interceptors.CN_Monitoreo");
			prc.informacion		= cn.verDetalleAcceso(rc.pkAcceso);
			prc.pkRegistro		= rc.pkAcceso;
			Event.setView("monitoreo/DetalleAcceso");
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Julio 03, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verTablaRegistros" access="remote" returntype="void" output="false" hint="Visualiza los registros">
		<cfargument name="Event" type="any">
		<cfscript>
			var cn			= getModel("interceptors.CN_Monitoreo");
			var rc			= Event.getCollection();
			prc.regAccesos		= cn.getAccesosRegistrados(rc.numeroPagina, rc.ur, rc.fechaIni, rc.fechaFin);
			
			Event.setView("monitoreo/TablaAccesos").noLayout();
		</cfscript>
	</cffunction>
</cfcomponent>