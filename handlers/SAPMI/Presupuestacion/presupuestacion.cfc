<cfcomponent>

	<!---<cfproperty name="CN" 	  inject="EDI.CN_evaluacion">--->

	<cffunction name="index" hint="Funcion principal del modulo de presupuestacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			event.setView("SAPMI/Presupuestacion/principal");
		</cfscript>
	</cffunction>

</cfcomponent>