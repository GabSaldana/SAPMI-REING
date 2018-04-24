<cfcomponent>

	<!---<cfproperty name="CN" 	  inject="EDI.CN_evaluacion">--->

	<cffunction name="index" hint="Funcion principal del modulo de programacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			event.setView("SAPMI/Programacion/Seguimiento/principal");
		</cfscript>
	</cffunction>

</cfcomponent>