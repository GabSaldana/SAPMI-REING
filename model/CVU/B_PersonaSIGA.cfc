<cfcomponent accessors="true">
	<cfproperty name="PK_PERSONAL"     hint="pk de la persona">
	<cfproperty name="UR"              hint="">
	<cfproperty name="AMATERNO"        hint="Appelido materno">
	<cfproperty name="APATERNO"        hint="Apellido Paterno">
	<cfproperty name="CUENTA_SAR"      hint="Cuenta SAR">
	<cfproperty name="CURP"            hint="">
	<cfproperty name="EDAD"            hint="">
	<cfproperty name="ESTADO"          hint="">
	<cfproperty name="ESTADO_CIVIL"    hint="">
	<cfproperty name="FECHA_NAC"       hint="Fecha de Nacimiento">
	<cfproperty name="GENERO"          hint="">
	<cfproperty name="HOMOCLAVE"       hint="">
	<cfproperty name="NACIONALIDAD"    hint="">
	<cfproperty name="NOMBRE"          hint="">
	<cfproperty name="NO_ISSSTE"       hint="Numero de ISSSTE">
	<cfproperty name="NO_SEGUROSOCIAL" hint="Numero de Seguridad Social">
	<cfproperty name="NUM_CARTILLA"    hint="Numero de Cartilla">
	<cfproperty name="NUM_EMPLEADO"    hint="Numero de empleado">
	<cfproperty name="NUM_IFE"         hint="Numero de IFE">
	<cfproperty name="NUM_PASAPORTE"   hint="Numero de Pasaporte">
	<cfproperty name="OTRA_ENTIDAD"    hint="">
	<cfproperty name="PAIS_NAC"        hint="">
	<cfproperty name="PK_EDO_CIVIL"    hint="">
	<cfproperty name="PK_ENTIDAD_MEX"  hint="">
	<cfproperty name="PK_GENERO"       hint="">
	<cfproperty name="PK_NACIONALIDAD" hint="">
	<cfproperty name="PK_PAIS_NAC"     hint="">
	<cfproperty name="RFC"             hint="">
	<cfproperty name="RUSP"            hint="">
	<cfproperty name="TIPO_EMPLEADO"   hint="">
	
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
			return this.getNOMBRE()&" "&this.getAPATERNO()&" "&this.getAMATERNO();
		</cfscript>
	</cffunction>

	<!---
		* Fecha : Diciembre 2017
		* author : Daniel Memije
	--->
	<cffunction name="getEdadCalc">
		<cfscript>			
			if(isDate(this.getFECHA_NAC())){
				return dateDiff("yyyy", this.getFECHA_NAC(), now());			
			}else{
				return "";
			}
		</cfscript>
	</cffunction>
	
</cfcomponent>
