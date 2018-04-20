<cfcomponent accessors="true">
	<cfproperty name="NOMBRE">
	<cfproperty name="RFC">
	<cfproperty name="PK_PERSONA">
	<cfproperty name="NIVEL">
	<cfproperty name="ZONA_PAGO">
	<cfproperty name="RESIDENCIA">
	<cfproperty name="ANIOGRACIA">
	<cfproperty name="CVEOFICIO">
	<cfproperty name="CLAVE">
	<cfproperty name="PK_ASPROC">

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!---
	* Fecha :	Marzo de 2018
	* author :	Alejandro Tovar
	--->
	<cffunction name="setClaveNormal" hint="Coloca la clave dependiendo de que le hayan otorgado al investigador">
		<cfargument name="cveGracia" 	 type="any" hint="clave del año de gracia">
		<cfargument name="cveResidencia" type="any" hint="clave de la residencia">
		<cfargument name="clave" 		 type="any" hint="clave">
		<cfargument name="nivel" 		 type="any" hint="nivel del investgador">
		<cfscript>

			if(this.getRESIDENCIA() EQ 1){
				this.setCLAVE(arguments.cveResidencia);
			}else{
				this.setCLAVE(clave);
			}

			if(this.getANIOGRACIA() EQ 1){
				this.setCLAVE(arguments.cveGracia);
			}else{
				this.setCLAVE(clave);
			}

			this.setNIVEL(arguments.nivel);

		</cfscript>
	</cffunction>

	<!---
	* Fecha :	Marzo de 2018
	* author :	Alejandro Tovar
	--->
	<cffunction name="setRfcCorto" hint="Obtiene el rcf a 10 caracteres">
		<cfargument name="rfc" type="any" hint="rfc">
		<cfscript>
			var rfcCorto = '';

			if (Len(rfc) GT 10){
				rfcCorto = Mid(rfc, 1, 10);
				this.setRFC(rfcCorto);

			}else if (Len(rfc) EQ 10){
				this.setRFC(rfc);

			}else if (Len(rfc) LT 10){

				var size = 10 - Len(rfc);
				var aux = '';
				for (i = 1; i <= size; i++){
					aux = 'X' & aux;
				}

				this.setRFC(rfc&aux);
			}

		</cfscript>
	</cffunction>

</cfcomponent>