<cfcomponent accessors="true">
	<cfproperty name="PKCONVENIO">
	<cfproperty name="CONVENIO">
	<cfproperty name="OBJCONVENIO">
	<cfproperty name="TIEMPOTOTAL">
	<cfproperty name="TIEMPODEP">
	<cfproperty name="TIEMPOAREA">
	<cfproperty name="ESTADOACTUAL">
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

		<!---
		* Fecha :	agosto de 2017
		* author :	Roberto Cadeba
	--->
	<cffunction name="getTiempoTotalString" hint="Obtiene el tiempo total">
		<cfscript>
			return this.toText(this.getTIEMPOTOTAL());
		</cfscript>
	</cffunction>

	<!---
		* Fecha :	agosto de 2017
		* author :	Roberto Cadeba
	--->
	<cffunction name="getTiempoDepString" hint="Obtiene el tiempo total">
		<cfscript>
			return this.toText(this.getTIEMPODEP());
		</cfscript>
	</cffunction>

	<!---
		* Fecha :	agosto de 2017
		* author :	Roberto Cadeba
	--->
	<cffunction name="getTiempoAreaString" hint="Obtiene el tiempo total">
		<cfscript>
			return this.toText(this.getTIEMPOAREA());
		</cfscript>
	</cffunction>

	<!---
		* Fecha :	agosto de 2017
		* author :	Roberto Cadeba
	--->
	<cffunction name="toText" hint="Obtiene el tiempo y lo manda a una cadena">
		<cfargument name="tiempo" type="numeric" required="yes">
		<cfscript>
			var dias = fix(tiempo);
			var horas =  fix((tiempo - dias) * 24);
			var minutos = fix(((tiempo * 24) - ((dias * 24) + horas)) * 60);
			var segundos = fix(((tiempo * 24 * 60) - ((dias * 24 * 60) + (horas * 60 ) + minutos)) * 60);
			
			return (tiempo > 0) ? dias & " dias " & horas & ' horas ' & minutos & ' minutos '  & segundos & ' segundos' : "No aplica";
		</cfscript>
	</cffunction>

</cfcomponent>