<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: 
* Fecha 14 de agosto de 2015
* Descripcion: 
* Objeto de negocio para las propiedades de una visualizacion.
* Autor:Arturo Christian Santander Maya 
* ================================
--->




<cfcomponent accessors="true" >
	<cfproperty name="id">
	<cfproperty name="editable">
	<cfproperty name="nombre">
	<cfproperty name="icono">
	<cfproperty name="definicion">
	<cfproperty name="valor">
	<cfproperty name="etiqueta">
	<cfproperty name="tipo">
	<cfproperty name="representacion">
	
	

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>