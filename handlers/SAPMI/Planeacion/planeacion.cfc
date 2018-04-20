<cfcomponent>

	<!---<cfproperty name="CN" 	  inject="EDI.CN_evaluacion">--->

	<cffunction name="index" hint="Funcion principal del modulo de planeacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			event.setView("SAPMI/Planeacion/principal");
		</cfscript>
	</cffunction>

</cfcomponent>