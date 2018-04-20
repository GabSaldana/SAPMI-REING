<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Controlador para el menu primario
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Controlador para los roles
* Autor: GSA
=========================================================================
--->
<cfcomponent output = "false" extends="coldbox.system.EventHandler">
    <!---
	* Desc.:	Se anadio consulta que verifica las acciones que tiene el eje de acuerdo al rol
	* para activar o desactivar dicho acceso
	* Fecha:	Abril 2, 2018
	* -----------------------------
	* Desc.:	Se anadio bandera para identificar si se consulta desde un dispositivo movil
	* Fecha:	Marzo 27, 2018
	* -----------------------------
	* Fecha creacion: Febrero 2018
	* @author GSA
	--->
	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
        <!---<cfscript>
			var cnCarrusel			= getModel("carrousel.CN_carrousel");
			Request.accionesEjes	= cnCarrusel.getAccionesEjesPorRol(Session.cbstorage.usuario.ROL);
		</cfscript>--->
        <cfif IsDefined('Session.cbstorage.portabilidad.esMovil') AND Session.cbstorage.portabilidad.esMovil EQ true>
			<cfset event.setView("main/indexMobile").setlayout('mainmobile')>
		<cfelse>
			<cfset event.setView("main/index").setlayout('main')>
		</cfif>
	</cffunction>
</cfcomponent>