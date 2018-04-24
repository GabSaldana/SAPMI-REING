<cfcomponent>

	<!---<cfproperty name="CN" 	  inject="EDI.CN_evaluacion">--->
	<cffunction name="index" hint="Funcion principal del modulo de evaluacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			event.setView("SAPMI/Planeacion/MisionVision/principal");
		</cfscript>
	</cffunction>

</cfcomponent>