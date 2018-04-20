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
	* Fecha creacion: Febrero 2018
	* @author GSA
	--->
	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<!--- EN CASO DE HABER ELEGIDO UN ROL ENVIA DIRECTO a la vista de ejes--->
		<cfif not isdefined('Session.cbstorage.usuario.pk')>
			<cfif IsDefined('Session.cbstorage.portabilidad.esMovil') AND Session.cbstorage.portabilidad.esMovil EQ true>
				<cfset event.setView("roles/rolesMobile").setlayout('mainmobile')>
			<cfelse>
				<cfset event.setView("roles/roles").setlayout('main')>
			</cfif>
		<cfelse>
			<cfset setNextEvent("ejes.ejes")>
		</cfif>
	</cffunction>
</cfcomponent>