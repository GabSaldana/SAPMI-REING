<cfcomponent accessors="true">
	<cfproperty name="PK_CREQUISITO" hint="pk del catalogo de requisitos">
	<cfproperty name="PK_MOVIMIENTO" hint="pk del movimiento">
	<cfproperty name="PK_PERSONA" 	hint="pk de la persona">
	<cfproperty name="ARTICULO" 	hint="Ariculo del reglamento">
	<cfproperty name="SECCION" 		hint="Seccion del reglamento">
	<cfproperty name="CUMPLE" 	type="boolean"	default="false" hint="indica si ya cumplio el requisito">
	<cfproperty name="C_OBLIGATORIO" hint="si es obligatorio en la tabla">
	<cfproperty name="TREQUISITOS" type="array" hint="si es obligatorio en la tabla" default="[]">
	
	<!---
	* Fecha : Noviembre 2017
	* author : Marco Torres
	--->
	<cffunction name="init">
		<cfscript>
			var r = [];
			this.setTREQUISITOS(r);
			return this;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Noviembre 2017
	* author : Marco Torres
	--->
	<cffunction name="getColor"  hint="obtiene el color con que debe pinrtarse el elemento en la vista">
		<cfscript>
			if(this.getCumple() eq 0 and this.getC_OBLIGATORIO() EQ 1)
				return 'danger';
			else if(this.getCumple() eq 0)
				return 'warning';
			else
				return 'info';	
				
				
		</cfscript>
	</cffunction>	
	
	
	<!---
	* Fecha : Noviembre 2017
	* author : Marco Torres
	--->
	<cffunction name="appendTRequisitos" hint="aggrega un trequisito al array">
		<cfargument name="tRequisito">
		<cfscript>
			arrayAppend(this.getTREQUISITOS(),tRequisito); 
		</cfscript>
	</cffunction>

	<!---
	* Fecha : Noviembre 2017
	* author : Marco Torres
	--->
	<cffunction name="cumpleRequisito" hint="valida que el aspirante cumpla con este requisito">
		<cfscript>
			var cumpleRequisitoObligatorio= 1;
			var cumpleRequisitoOpcional = 0;
			var numeroRequisitoOpcional = 0;
			
			for (tRequisito in this.getTREQUISITOS()){
				if(tRequisito.getT_OBLIGATORIO() EQ 1){
					if(tRequisito.getTIENEREQUISITO() EQ 0){
						this.setCUMPLE(false);
						return false;
					}
				}else{
					cumpleRequisitoOpcional = cumpleRequisitoOpcional + tRequisito.getTIENEREQUISITO();
					numeroRequisitoOpcional++;
				}
			}
			if(cumpleRequisitoOpcional GT 0 or numeroRequisitoOpcional EQ 0){
					this.setCUMPLE(true);
					return true;	
			}
			
			this.setCUMPLE(false);
			return false;
		</cfscript>
	</cffunction>
</cfcomponent>