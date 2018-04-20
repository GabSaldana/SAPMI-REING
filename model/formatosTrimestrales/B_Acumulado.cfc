<cfcomponent accessors="true"  >

	<cfproperty name="reportes" type="array" hint="contiene las informacion capturada en un array de reportes">

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="init">
		<cfscript>
			/* var reportes = [];
			this.setreportes(reportes); */
			return this;
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getInfoAcumulado">
		<cfscript>
			var jsonacumulado = '';
			var i = 1;
			var structSumas = structNew();
			var totales = [];

			for (reporte in this.getreportes()){
				var finalPeriodo = reporte.getJSONSumaFinalAcumulado(i++);
				var strucSumasPeriodo = deserializeJSON(finalPeriodo);
				jsonacumulado = jsonacumulado & finalPeriodo &',';
				arrayAppend(totales,strucSumasPeriodo);
			}

			var total = this.sumarValoresToArray(strucSumasPeriodo,totales);
			jsonacumulado = jsonacumulado & total &',';
			
			return jsonacumulado;
		</cfscript>
	</cffunction>	
		
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="sumarValoresToArray" hint="suma los valores de la fila al array que se envia">
		<cfargument name="periodo">
		<cfargument name="estructuraTotales">
		<cfscript>

			var nueva = StructKeyArray(periodo);

			for (var i=1; i lt ArrayLen(estructuraTotales); i++){

				for (var x=1; x lte ArrayLen(nueva); x++){
					if (structkeyexists(periodo,nueva[x])){

						if ( IsNumeric(estructuraTotales[i][nueva[x]]) ){
							periodo[nueva[x]] = periodo[nueva[x]] + estructuraTotales[i][nueva[x]];
						}else {
							periodo[nueva[x]] = 'TOTAL';
						}

					}
				}

			}

			return serializeJSON(periodo);
			
		</cfscript>
	</cffunction>
		
</cfcomponent>