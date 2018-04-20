<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha 24 de agosto de 2015
* Descripcion: 
* Objeto de negocio para los tipos de visualizaciones.
* Autor:Arturo Christian Santander Maya 
* ================================
--->




<cfcomponent accessors="true">
	<cfproperty name="id">
	<cfproperty name="clasificacion">
	<cfproperty name="nombre">
	<cfproperty name="definicion">
	<cfproperty name="vistaPrevia">
	<cfproperty name="icono">
	<cfproperty name="descripcion">
	<cfproperty name="maxCol">
	<cfproperty name="maxFil">
	<cfproperty name="minCol">
	<cfproperty name="minFil">
	

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>	

	



</cfcomponent>