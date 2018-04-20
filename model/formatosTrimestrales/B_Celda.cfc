<!---
* ================================
* IPN – CSII
* Sistema: 
* Modulo: 
* Sub modulo: 
* Fecha
* Descripcion: 
* Objeto de negocio para las
* ================================
--->
<cfcomponent accessors="true"  >
	<cfproperty name="PKCELDA">
	<cfproperty name="valorcelda">
	<cfproperty name="PK_COLUMNA">
	<cfproperty name="PK_FILA">
	<cfproperty name="PK_TIPOFECHA">
	<cfproperty name="ISNOMBRE">
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="init">
		<cfscript>
			propiedades=[];
			columnas=[];
			return this;
		</cfscript>
	</cffunction>	

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="celdaToJSON" hint="Retorna la referencia a una columna de la visualizacion" >
		<cfargument name="idCol">
			<cfscript>
				return '"'&this.getPK_COLUMNA() &'":"'& JSStringFormat(this.getvalorcelda())&'"';
			</cfscript>
	</cffunction>
</cfcomponent>