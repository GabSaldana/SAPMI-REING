<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Controlador para el menu secundario
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Controlador para el acordeon de imagenes
* Autor: GSA
=========================================================================
--->
<cfcomponent output = "false" extends="coldbox.system.EventHandler">
    <!---
	* Desc.:	Se anadio bandera para identificar si se consulta desde un dispositivo movil
	* Fecha:	Marzo 28, 2018
	* -----------------------------
	* Fecha creacion: Febrero 2018
	* @author GSA
	--->
	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfif IsDefined('Session.cbstorage.portabilidad.esMovil') AND Session.cbstorage.portabilidad.esMovil EQ true>
			<cfset event.setView("carrousel/carrouselMobile").setlayout('mainmobile')>
		<cfelse>
			<cfset event.setView("carrousel/carrouselAlt").setlayout('main')>
		</cfif>
	</cffunction>

	<cffunction name="getEje" access="remote" hint="regresa el nombre del Eje" returntype="any">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("carrousel.CN_carrousel") >
		<cfscript>
			resultado = CN.getEje(rc.eje);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<cffunction name="getNumeroAcciones" access="remote" hint="regresa el numero de acciones de un eje" returntype="any">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("carrousel.CN_carrousel") >
		<cfscript>
			resultado = CN.getNumeroAcciones(rc.eje);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<cffunction name="getDatosAcciones" access="remote" hint="regresa los datos de las acciones de un eje" returntype="any">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("carrousel.CN_carrousel") >
		<cfscript>
			resultado = CN.getDatosAcciones(rc.eje);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>
</cfcomponent>