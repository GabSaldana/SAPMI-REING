<cfcomponent accessors="true">
	<cfproperty name="PK_PERSONA"      hint="pk de los datos">
	<cfproperty name="GENERO"       hint="">
	<cfproperty name="NOMBRE"          hint="">
	<cfproperty name="APPAT"           hint="">
	<cfproperty name="APMAT"           hint="">
	<cfproperty name="CURP"            hint="">
	<cfproperty name="NACIONALIDAD" hint="">
	<cfproperty name="CLAVE_LADA"      hint="">
	<cfproperty name="RFC"             hint="">
	<cfproperty name="CORREO_IPN"      hint="">
	<cfproperty name="CORREO_ALTERNO"  hint="">
	<cfproperty name="FK_UR"           hint="">
	<cfproperty name="FK_TRAYECTORIA"  hint="">
	<cfproperty name="FECHA_CAPTURA"   hint="">
	<cfproperty name="FK_PERSONASIGA"  hint="">
	<cfproperty name="EXT_OFICINA"     hint="">
	<cfproperty name="NUM_EMPLEADO"    hint="">
	<cfproperty name="FK_USUARIO"      hint="">
	<cfproperty name="FK_EDI"          hint="">
	<cfproperty name="ESTADO"          hint="">
	<cfproperty name="RUTA"            hint="">
	
	<!---
		* Fecha : Octubre 2017
		* author : Marco Torres
	--->
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!---
		* Fecha : Octubre 2017
		* author : Daniel Memije
	--->
	<cffunction name="getNombreCompleto">
		<cfscript>
			return this.getNOMBRE()&" "&this.getAPPAT()&" "&this.getAPMAT();
		</cfscript>
	</cffunction>
	
</cfcomponent>