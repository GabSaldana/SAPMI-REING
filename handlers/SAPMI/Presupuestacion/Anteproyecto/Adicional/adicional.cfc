<cfcomponent>

	<cffunction name="index" hint="Funcion principal del modulo de evaluacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			event.setView("SAPMI/Presupuestacion/Anteproyecto/Adicional/principal");
		</cfscript>
	</cffunction>

</cfcomponent>