<cfcomponent accessors="true">
	
	<cfproperty name="PK_ESCOLARIDAD">
	<cfproperty name="PK_OBTENCIONGRADO">
	<cfproperty name="PK_PERSONA">
	<cfproperty name="PK_USUARIO">
	<cfproperty name="PROCESO">
	<cfproperty name="EDO_EVALUACION">
	<cfproperty name="FECHA_INICIO">
	<cfproperty name="FECHA_TERMINO">
	<cfproperty name="FECHA_OBTENCION">
	<cfproperty name="ESCUELA">
	<cfproperty name="CAMPO_CONOCIMIENTO">
	<cfproperty name="CEDULA_PROFESIONAL">
	<cfproperty name="PNPC">
	<cfproperty name="GRADO">
	<cfproperty name="CLASIFICACION">
	<cfproperty name="SUBCLASIFICACION">
	<cfproperty name="CLASIFICACION_ROMANO">
	<cfproperty name="SUBCLASIFICACION_ROMANO">
	<cfproperty name="ANIO">
	<cfproperty name="EVALUACIONES" type="array">
	
	<!---
		* Fecha : Marzo 2018
		* author : Daniel Memije
	--->
	<cffunction name="init">
		<cfscript>			
			this.setEVALUACIONES(arrayNew(1));
			return this;
		</cfscript>
	</cffunction>

	<!---
		* Fecha : Marzo 2018
		* author : Daniel Memije
	--->
	<cffunction name="initAnio">
		<cfscript>			
			this.setANIO(dateFormat(this.getFECHA_OBTENCION(),"yyyy"));			
		</cfscript>
	</cffunction>

</cfcomponent>
