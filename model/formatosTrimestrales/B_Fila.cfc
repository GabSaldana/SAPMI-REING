<cfcomponent accessors="true"  >
	<cfproperty name="PK_FILA">
	<cfproperty name="EVALUACION_ETAPAS">
	<cfproperty name="PK_CPRODUCTO">
	<cfproperty name="SELECCIONADO">
	<cfproperty name="TPP_EVALUADO">
	<cfproperty name="PRODUCTO_ELIMINAR" default="0">
	<cfproperty name="celdas" type="array">

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="filaToJSON" hint=" crea el json de una fila">
		<cfargument name="secciones">
		<cfscript>
			var listaJson = '{"PK_FILA":'&this.getPK_FILA();
			for (var celda in this.getceldas()){
				listaJson= listaJson &','&celda.celdaToJSON();
			}
			return listaJson&'}';
		</cfscript>
	</cffunction>

	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getCeldabyPKColumna" hint="obtiene una celda de la fila por el pk de la celda">
		<cfargument name="pkColumna">
		<cfscript>
			for (var celda in this.getCeldas()){
				if (celda.getPK_COLUMNA() eq pkColumna){
					return celda;
				}
			}
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="sumarValoresToArray" hint="suma los valores de la fila al array que se envia">
		<cfargument name="structSumas">
		<cfscript>
			//var estructura = structSumas;
			for (celda in this.getCeldas()){				
				var valorCelda = replace(celda.getvalorcelda(),",","","all" );
				if( isNumeric(valorCelda )){
					if (structkeyexists(structSumas,celda.getPK_COLUMNA())){
						structSumas[celda.getPK_COLUMNA()] = structSumas[celda.getPK_COLUMNA()] + valorCelda;
					} else {
						structSumas[celda.getPK_COLUMNA()] = valorCelda;
					}
				}
			}
			return structSumas;
		</cfscript>
	</cffunction>

	<!---
    * Fecha : Febrero 2018
    * author : Marco Torres
	--->
	<cffunction name="getNombreProducto" hint="extrae el anio de una cadena">
		<cfscript>
			for (celda in this.getCeldas()){
				if(celda.getISNOMBRE() eq 1)
				return celda.getvalorcelda();				
			}
		</cfscript>
	</cffunction>
</cfcomponent>
