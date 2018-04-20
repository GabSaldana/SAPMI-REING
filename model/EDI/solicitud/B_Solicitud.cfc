<cfcomponent accessors="true">
	<cfprocessingdirective pageEncoding="utf-8">
	<cfproperty name="PK_SOLICITUD" 	hint="pk de los datos">
	<cfproperty name="PK_PERSONA" 		hint="">
	<cfproperty name="PK_ASPIRANTE" 	hint="">
	<cfproperty name="REQUISITOS" 	type="array"	hint="">
	
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
		* author : Marco Torres
	--->
	<cffunction name="setTrequisitos"  hint="agrega un trequisito a un crequisito donde corresponde">
		<cfargument name="tRequisito">
		<cfscript>
			for (cRequisito in this.getREQUISITOS()){
				if( tRequisito.getPK_CREQUISITO() eq   cRequisito.getPK_CREQUISITO()){
					cRequisito.appendTRequisitos(tRequisito);
					return true;
				}	
			}
			return false;
		</cfscript>
	</cffunction>
	
	<!---
		* Fecha : Noviembre 2017
		* author : Marco Torres
	--->
	<cffunction name="validaRequisitos" hint="valida que el aspirante cumpla con los requisitos minimos">
		<cfscript>
			var cumpleRequisitoObligatorio= 1;
			var cumpleRequisitoOpcional = 0;
			var numeroRequisitoOpcional = 0;
			var incumplidos=[];
			respuesta = {};
			
			
			for (requisito in this.getREQUISITOS()){
				if(requisito.getC_OBLIGATORIO() EQ 1){
					if(!requisito.cumpleRequisito()){
						arrayAppend(incumplidos,'Articulo: '&requisito.getArticulo() &' Sección: '&requisito.getSeccion());				
					}
				}else{
					cumpleRequisitoOpcional = cumpleRequisitoOpcional + requisito.cumpleRequisito();
					numeroRequisitoOpcional++;
				}
			}
			
			if(cumpleRequisitoOpcional GT 0 OR numeroRequisitoOpcional EQ 0){
				respuesta.cumple = true;	
			}
			respuesta.incumplidos = incumplidos;
			respuesta.cumple = false;	
			return respuesta;
		</cfscript>
	</cffunction>
	
</cfcomponent>