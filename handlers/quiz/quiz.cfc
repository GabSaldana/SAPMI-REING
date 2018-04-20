<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Controlador para el menu primario
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Controlador para el cuestionario
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
			<cfif IsDefined('Session.cbstorage.portabilidad.esMovil') AND Session.cbstorage.portabilidad.esMovil EQ true>
				<cfset event.setView("quiz/quiz").setlayout('mainmobile')>
			<cfelse>
				<cfset event.setView("quiz/quiz").setlayout('main')>
			</cfif>

	</cffunction>

	<cffunction name="getPreguntas" access="remote" hint="regresa una estructura con las preguntas" returntype="any">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("quiz.CN_quiz") >
		<cfscript>
			resultado = CN.getPreguntas();
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<cffunction name="getPregunta" access="remote" hint="regresa una estructura con las preguntas" returntype="any">
		<cfargument name="event" type="any">
        <cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("quiz.CN_quiz") >
		<cfscript>
			resultado = CN.getPregunta(Session.cbstorage.usuario.ROL,rc.accion,rc.eje);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>
</cfcomponent>