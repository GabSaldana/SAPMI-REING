<cfcomponent accessors="true">
	<cfproperty name="PK_DATOSLOC"          hint="pk del domicilio">
	<cfproperty name="PK_COLONIA"           hint="codigo postal">	
	<cfproperty name="PK_PERSONA"           hint="calle">	
	<cfproperty name="CALLE"                hint="pk del domicilio">
	<cfproperty name="CORREO_ALTERNATIVO"   hint="calle">	
	<cfproperty name="CORREO_INSTITUCIONAL" hint="pais">
	<cfproperty name="DEDSCRIPCION_ESTADO"  hint="codigo postal">	
	<cfproperty name="ESTADO_REGISTRO"      hint="pk del domicilio">
	<cfproperty name="EXT_TELF"             hint="calle">	
	<cfproperty name="LOCALIDAD_SECCION"    hint="pais">
	<cfproperty name="NUMERO_EXT"           hint="codigo postal">	
	<cfproperty name="NUMERO_INT"           hint="pk del domicilio">
	<cfproperty name="NUM_CELULAR"          hint="calle">	
	<cfproperty name="OBSERVACION_RECHAZO"  hint="pais">
	<cfproperty name="TELEFONO_OFICINA"     hint="pais">
	<cfproperty name="TELEFONO_PARTICULAR"  hint="codigo postal">	
	<cfproperty name="TELF_RECADOS"         hint="pk del domicilio">	
	<cfproperty name="CP"						        hint="pk del domicilio">	
	<cfproperty name="DATOS_COLONIA"        hint="pk del domicilio">	

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
