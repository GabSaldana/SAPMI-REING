<cfcomponent accessors="true">
	<cfproperty name="estados" type="array">

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	
	<cffunction name="setCambios">
		<cfargument name="cambio">
		<cfscript>
			for(estado in this.getEstados()){
				if(cambio.getPK_EDO_ANTERIOR() eq estado.getPK_ESTADO()){
					estado.setCambio(cambio);
				}
			}
		</cfscript>
	</cffunction>


	<cffunction name="setCambiosLink">
		<cfargument name="cambio">
		<cfscript>
			for(estado in this.getEstados()){
				if(cambio.getPK_EDO_actual() eq estado.getPK_ESTADO()){
					estado.setCambioLkn(cambio);
				}
			}
		</cfscript>
	</cffunction>

</cfcomponent>