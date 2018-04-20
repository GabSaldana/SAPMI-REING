<cfcomponent accessors="true">
	<cfproperty name="PKPROCESO"		type="numeric"	hint="pk del proceso">
	<cfproperty name="NOMBREPROCESO"	type="string"	hint="nombre del proceso">
	<cfproperty name="FECHAINICIO"		type="numeric"	hint="fecha de inicio">
	<cfproperty name="FECHAFIN"			type="numeric"	hint="fecha de fin">
	<cfproperty name="ESTADOPROCESO"	type="numeric"	hint="estado del proceso">
	<cfproperty name="PKREGLAMENTO"		type="numeric"	hint="pk del reglamento vigente">
	<cfproperty name="PKASPIRANTEPROCESO"		type="numeric"	hint="pkaspirante proceso">
	<cfproperty name="RIFECHAINI"		type="numeric"	hint="fecha de inicio de convocatoria">
	<cfproperty name="RIFECHAFIN"		type="numeric"	hint="fecha de fin de convocatoria">
	<cfproperty name="FECHAINIPROC"		type="numeric"	hint="fecha de inicio de convocatoria">
	<cfproperty name="FECHAFINPROC"		type="numeric"	hint="fecha de fin de convocatoria">

	<!---
		* Fecha:	Octubre 2017
		* autor:	Roberto Cadena
	--->
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
</cfcomponent>