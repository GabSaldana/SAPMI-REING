<cfcomponent accessors="true">
	<cfproperty name="PK_MOVIMIENTO" hint="pk de los datos">
	<cfproperty name="NOMBRE" type="string">
	<cfproperty name="DESCRIPCION" type="string" >
	<cfproperty name="OBSERVACION" type="string" >
	<cfproperty name="ACCIONES" type="string" >
	<cfproperty name="ACCIONESCVE" type="string" >
	<cfproperty name="CER_DESCRIPCION" type="string" >
	<cfproperty name="NOMEDO" type="string" >
	<cfproperty name="NUMEDO" type="string" >
	<cfproperty name="PKASPIRANTEPROCESO" type="string" >
	<cfproperty name="CESESTADO" type="numeric" >
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