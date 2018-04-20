<cfcomponent>
	<cfproperty name="cnEval" inject="adminCSII.admonEvaluacion.CN_Evaluacion">

	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>
			prc.esca = cnEval.obtenerEscala();
			prc.eval = cnEval.obtenerEvaluaciones();
		</cfscript>
		<cfset event.setView("adminCSII/admonEvaluacion/Evaluaciones")>
	</cffunction>

	<cffunction name="obtenSecciones" hint="Obtiene la tabla de evaluaciones">
		<cfargument name="event" type="any">
		<cfscript>
			prc.secEval = cnEval.obtenerAspectoSeccion(rc.pkEvaluacion);
			event.setView("adminCSII/admonEvaluacion/tablaEval").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="guardaEvaluacion" hint="guarda una evaluacion">
		<cfargument name="event" type="any">
		<cfscript>
			var evalGuar = cnEval.guardarEvaluacion(rc.nombre, rc.fechaIni, rc.fechaFin);
		</cfscript>
		<cfreturn evalGuar>
	</cffunction>

	<cffunction name="guardarSeccion" hint="Obtiene la tabla de evaluaciones">
		<cfargument name="event" type="any">
		<cfscript>
			var guardSeccion = cnEval.guardarSeccion(rc.nombreSecc, rc.ordenSecc, rc.fkEvaluacion);
		</cfscript>
		<cfreturn guardSeccion>
	</cffunction>

	<cffunction name="guardarAspecto" hint="Obtiene la tabla de evaluaciones">
		<cfargument name="event" type="any">
		<cfscript>
			var guardAspecto = cnEval.guardarAspecto(rc.nombreAsp, rc.ordenAsp, rc.seccion, rc.escala, rc.evaluacion);
		</cfscript>
		<cfreturn guardAspecto>
	</cffunction>

	<cffunction name="actualizarOrdenElemento" hint="Trae los aspectos seleccionados">
		<cfargument name="event" type="any">
		<cfscript>
			var secciones = cnEval.actualizarOrdenElemento(lista, tipoTabla);
		</cfscript>
		<cfreturn secciones>
	</cffunction>

	<cffunction name="eliminarAsp" hint="Trae los aspectos seleccionados">
		<cfargument name="event" type="any">
		<cfscript>
			var aspectos= cnEval.eliminarAspecto(rc.Asp);		
		</cfscript>
	</cffunction>

	<cffunction name="eliminarSeccion" hint="Trae los aspectos seleccionados">
		<cfargument name="event" type="any">
		<cfscript>
			var secciones = cnEval.eliminarSeccion(rc.Seccion);
		</cfscript>
	</cffunction>

	<cffunction name="cargaAspectos" hint="Trae los aspectos seleccionados">
		<cfargument name="event" type="any">
		<cfscript>
			var aspectos = cnEval.obtenerAspecto(rc.pkSecc);
			Event.renderData(type="json", data=aspectos);
		</cfscript>
	</cffunction>

</cfcomponent>