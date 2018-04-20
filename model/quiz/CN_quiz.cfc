<!---
* =========================================================================
* IPN - CSII
* Sistema: SII 
* Modulo: Principal
* Sub modulo: Login
* Fecha: Marzo 2018
* Descripcion: Componente de Negocio para el manejo de los cuestiionarios
* @author GSA
* =========================================================================
--->
<cfcomponent>
	<cfproperty name="dao" inject="quiz/DAO_quiz">
   	<cffunction name="getPreguntas" hint="Regresa una estructura de datos con un par de elementos: pk_reporte,pk_formato" returntype="any">
		<cfscript>
			var preguntas = dao.getPreguntas();
			var arrres = [];

				for(var x=1; x lte preguntas.recordcount; x++){
					var res = structnew();
					res.formato = preguntas.RRP_FK_FORMATO[x];
					res.reporte = preguntas.TRP_PK_REPORTE[x];
					Arrayappend(arrres,res);
				}
			return arrres;
		</cfscript>
	</cffunction>

	<cffunction name="getPregunta" hint="Regresa una estructura de datos con un par de elementos: pk_reporte,pk_formato" returntype="any">
		<cfargument name="rol" type="numeric" required="yes">
		<cfargument name="accion" type="numeric" required="yes">
		<cfargument name="eje" type="string" required="yes">
		<cfscript>
			var ejeNum = 1;
			if(eje eq 'E1'){
				ejeNum = 1;
			} else if(eje eq 'E2'){
				ejeNum = 2;
			} else if(eje eq 'E3'){
				ejeNum = 3;
			} else if(eje eq 'E4'){
				ejeNum = 4;
			} else if(eje eq 'E5'){
				ejeNum = 5;
			} else if(eje eq 'ET1'){
				ejeNum = 6;
			} else if(eje eq 'ET2'){
				ejeNum = 7;
			}

			var pregunta = dao.getPregunta(rol,accion,ejeNum);
			var arrres = [];
				for(var x=1; x lte pregunta.recordcount; x++){
					var res = structnew();
					res.formato = pregunta.RRP_FK_FORMATO[x];
					res.reporte = pregunta.TRP_PK_REPORTE[x];
					res.img = pregunta.RRP_IMAGEN[x];
					res.rol = pregunta.RRP_FK_ROL[x];
					res.accion = pregunta.RRP_FK_ACCION[x];
					ArrayAppend(arrres, res);
				}
			return arrres;
		</cfscript>
	</cffunction>
</cfcomponent>