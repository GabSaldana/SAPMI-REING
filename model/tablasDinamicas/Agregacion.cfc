<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 25 de agosto de 2015
* Descripcion: 
* Objeto de negocio para los tipos de visualizaciones.
* Autor:Arturo Christian Santander Maya 
* ================================
--->




<cfcomponent accessors="true">
	<cfproperty name="id">
	<cfproperty name="idAgrColVis">
	<cfproperty name="nombre">
	<cfproperty name="descripcion">
	<cfproperty name="representacion">
	

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>	

</cfcomponent>