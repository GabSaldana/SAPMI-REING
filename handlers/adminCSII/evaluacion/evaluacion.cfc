<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Administracion de acciones formativas
* Sub modulo:
* Fecha : 04 de Marzo de 2016
* Autor :
* Descripcion: Handler
* =========================================================================
--->

<cfcomponent >

	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset event.setView("accionFormativa/admonAccionFormativa")>
	</cffunction>

	<!---
	* Fecha : 25 de abril de 2016
	* Autor : Yareli Andrade
	----------------------------
	* Fecha : 07 de junio de  2016
	* Autor : Víctor Manuel Mazón Sánchez
	* Modificacion: Se Hacecomunicacion con el negocio para quitar las consultas de la vista
	
	--->
	<cffunction name="getFormularioEval" access="remote" returntype="void" output="false" hint="Obtiene los reportes de un conjunto y usuario especifico">
		<cfargument name="event" type="any">
   		<cfargument name="prc" type="any">
		<cfscript>
			var cn	= getModel("adminCSII.evaluacion.CN_Evaluacion");
			prc.forma = cn.getForma(1);  //Este parametro se encuentra fijo en uno por que actualmente solo se tiene el corte de tiempo uno, pero debe verse la forma de cambiarlo
			prc.escalas = cn.getEscalas();
			prc.pkUsuario = rc.pkUsuario;
			prc.pkusuarioEval = rc.pkusuarioEval;
			event.setView("adminCSII/evaluacion/cargarEvaluacion").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Fecha : 28 de abril de 2016
	* Autor : Yareli Andrade
	--->
	<cffunction name="getEscala" access="remote" returntype="void" output="false" hint="Obtiene los valores de un tipo de escala">
		<cfargument name="event" type="any">
		<cfscript>
		</cfscript>
	</cffunction>

	<!---
	* Fecha : 02 de mayo de 2016
	* Autor : Yareli Andrade
	--->
	<cffunction name="guardarEncuesta" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>
			var cn	= getModel("adminCSII.evaluacion.CN_Evaluacion");
			var pkEvaluacion = cn.guardarEvaluacion(rc.pkusuarioEval, rc.participante, rc.eval, rc.estado);
			respuestas = deserializeJSON(rc.data);
			var total = 0;
			
			for (var i = 1; i LTE arrayLen(respuestas); i++){
				respuesta = cn.guardarEscala(respuestas[i]["pk"],pkEvaluacion, respuestas[i]["aspecto"], respuestas[i]["obs"], respuestas[i]["escala"]);
	        	total += 1;
			}
			// event.renderData(type = "json", data = total);
			event.renderData(type = "text", data = pkEvaluacion);
		</cfscript>
	</cffunction>

	<!---
	* Fecha : 03 de mayo de 2016
	* Autor : Yareli Andrade
	--->
	<cffunction name="getEvaluacion" access="remote" returntype="void" output="false" hint="Obtiene evaluación">
		<cfargument name="event" type="any">
		<cfscript>
			var cn	= getModel("adminCSII.evaluacion.CN_Evaluacion");
			resultado = cn.obtenerEvaluacion(rc.eval, rc.curso);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

</cfcomponent>