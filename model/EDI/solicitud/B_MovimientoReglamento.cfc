<cfcomponent accessors="true">
	
	<cfproperty name="PROCESO" hint="PROCESO ACTIVO">
	<cfproperty name="MOVIMIENTOS" type="array">
	
	
	<!---
		* Fecha : Octubre 2017
		* author : Marco Torres
	--->
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!---
		* Fecha : Noviembre 2017
		* author : Marco Torres
	--->
	<cffunction name="getMovimientosDisponibles">
		<cfscript>
			var movimientos = [];
			for(movimiento in this.getMOVIMIENTOS()){
				if(movimiento.getNumEdo() gtE 2){
					var mov= []; 
					arrayAppend(mov,movimiento);
					return mov;
				}
				arrayAppend(movimientos,movimiento);
			}
			return movimientos;
		</cfscript>
	</cffunction>

</cfcomponent>