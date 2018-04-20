<cfcomponent>
	<cfproperty name="CN" 	  inject="EDI.CN_EDI">
	<cfproperty name="CN_SOL"		inject="EDI.solicitud.CN_Solicitud">
	<cfproperty name='cnFT'		inject="formatosTrimestrales.CN_FormatosTrimestrales">
	
	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="index" hint="Funcion principal del modulo">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			prc.clasificaciones = CN.getClasificaciones();
			prc.ur = CN.getUR();
			prc.proceso_actual = CN_SOL.getProcesosEDI();
			prc.procesos = CN.getProcesos();
			event.setView("EDI/impresion/index");
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getURClasificacion" hint="obtiene las ur asociadas a una clasificacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			resultado = CN.getUR(rc.clasificacion);
			event.renderData(type="json", data = resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getTablaAspiranteProcesoUR" hint="obtiene las ur asociadas a una clasificacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			prc.consulta = CN.getTablaAspiranteProcesoUR(rc.pkproceso, rc.ur);
			event.setView('EDI/impresion/tablaConsultaInvestigadores').noLayout();
		</cfscript>
	</cffunction>
	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getDictamenConsulta" hint="obtiene las ur asociadas a una clasificacion">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event">
		<cfscript>
			prc.consulta = CN.getTablaAspiranteProcesoUR(rc.pkproceso, rc.ur);
			prc.proceso = CN_SOL.getProcesosEDISeleccion(rc.pkproceso);
			prc.productos = cnFT.getNodosTodosSeleccionadosUsuarioUR(prc.consulta, prc.proceso.getPKPROCESO());
			prc.resumen = CN.getResumenEvaluacionSeleccionados(prc.productos, prc.proceso, application.SIIIP_CTES.TIPOEVALUACION.FINAL);
			prc.clasificaciones = cnFT.getClasificacionesCVU();
			prc.folio	= CN_SOL.getaspiranteProcesoSeleccionado(prc.consulta);
			prc.Fecha	= CN_SOL.getFecha();
			prc.nombre	= CN_SOL.getNombrePersonaSeleccion(prc.consulta);
			prc.ur      = CN_SOL.getDatosURseleccion(prc.consulta);
			prc.observaciones = CN_SOL.getObservacionCAseleccion(prc.consulta);
			// writeDump(prc);
			
			// abort;
			//prc.consulta = CN.getTablaAspiranteProcesoUR(rc.pkproceso, rc.ur);
			event.setView('EDI/impresion/dictamenConsulta').noLayout();
		</cfscript>
	</cffunction>



</cfcomponent>