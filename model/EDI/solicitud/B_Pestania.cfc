<cfcomponent accessors="true">
	<cfproperty name="PK_PESTANIA" >
	<cfproperty name="PK_MOVIMIENTO" >
	<cfproperty name="NOMBRE" hint="Nombre">
	<cfproperty name="MOVIMIENTO" hint="Nombre">
	<cfproperty name="CLAVE" hint="Clave">
	<cfproperty name="REQUISITOS" type="array">
	
	<!---
		* Fecha : Octubre 2017
		* author : Marco Torres
	--->
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
</cfcomponent>