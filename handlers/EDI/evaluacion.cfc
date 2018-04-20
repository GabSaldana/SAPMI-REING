<cfcomponent>	
	<cfproperty name="CN" 	  inject="EDI.CN_EDI">
	<cfproperty name="CN_CVU" inject="CVU.CN_CVU">
	<cfproperty name="CN_SOL"		inject="EDI.solicitud.CN_Solicitud">
	<cfproperty name="CN_FT"		inject="formatosTrimestrales.CN_FormatosTrimestrales">
		
	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="index" hint="Muestra la vista para la evaluacion al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("EDI/evaluacion/index");
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllInvestigadores" hint="Muestra todods los investigadores">
		<cfargument name="event" type="any">
		<cfscript>
			prc.procesos = CN.getProcesos();
			event.setView("EDI/evaluacion/busquedaInvestigadores").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getTablaInvestigadores" hint="Muestra todods los investigadores">
		<cfargument name="event" type="any">
		<cfscript>
			prc.inv = CN.getTablaAspiranteProceso(rc.pkProceso);
			event.setView("EDI/evaluacion/tablaInvestigadores").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- Modificacion:
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->	
	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEvaluacion" hint="Muestra todods los investigadores">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso 				= CN_SOL.getProcesosEDI();
			prc.pkPersona              	= rc.pkPersona;
			prc.pkUsuario              	= rc.pkUsuario;
			prc.pkMovimiento           	= rc.pkMovimiento;
			prc.pkVertiente            	= rc.pkVertiente;
			prc.clasifSel		   		= rc.clasifSel;
			prc.subClasifSel           	= rc.subClasifSel;
			prc.productos              	= CN.getArbolProductosNoEvaluados(rc.pkUsuario);	
			prc.productosEval          	= CN.getArbolProductosEvaluados(rc.pkUsuario);	
			prc.datosInvestigador      	= CN.getEvaluacionDatosInvestigador(rc.pkPersona, rc.pkMovimiento);
			prc.datosInvestigadorNivel 	= CN.getEvaluacionDatosInvestigadorNivel(rc.pkPersona);
			prc.datosInvestigadorRed   	= CN.getEvaluacionDatosInvestigadorRed(rc.pkPersona);	
			prc.nivelEDI			   	= CN.getNivelEDI();	
			prc.clasificaciones 		= CN.getAllProductosEDI();	
			prc.anioGracia 				= CN.solicitoAnioGracia(rc.pkPersona, proceso.getPKPROCESO());
			prc.dispensa 				= CN.solicitoDispensa(rc.pkPersona, proceso.getPKPROCESO());
			prc.nivelesEvaluados 		= CN.getNivelesSIPCE(rc.pkPersona, proceso.getPKPROCESO());
			prc.ultimoGradoEstudios = CN.getAllEscolaridadByPkPersona(prc.pkPersona);
			prc.nivelesForAdminEdi 		= CN.getNivelesSIPCECA(rc.pkPersona, proceso.getPKPROCESO());
			event.setView("EDI/evaluacion/evaluacionEDI").noLayout();
		</cfscript>
	</cffunction>

	<!--- Modificacion:
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->	
	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<!--- Reemplazada por la funcion de abajo --->
	<cffunction name="verProducto" hint="Muestra todods los productos">
		<cfargument name="event" type="any">		
		<cfscript>
			var rc = Event.getCollection();
			prc.pkUsuario = rc.pkUsuario;
			prc.pkProducto = rc.pkProducto;
			prc.productos = CN_FT.getNodosHojaEDI(rc.pkProducto,rc.pkUsuario);
			prc.tiposEvaluacion = CN.getTiposEvaluacion();	
			prc.clasificaciones = CN.getAllProductosEDI();			
			event.setView("EDI/evaluacion/selectProducto").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha: Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<!--- Carga todos los productos --->
	<cffunction name="verProductosTodos" hint="Muestra todods los productos">
		<cfargument name="event" type="any">		
		<cfscript>
			var rc = Event.getCollection();
			var proceso = CN_SOL.getProcesosEDI();
			prc.pkUsuario = rc.pkUsuario;						
			prc.productos = CN_FT.getNodosTodosSeleccionadosAndPkUsuario(rc.pkUsuario,proceso.getPKPROCESO());			
			prc.tiposEvaluacion = CN.getTiposEvaluacion();	
			prc.validaciones = CN.getValidacionesByAspitanteProceso(rc.pkUsuario,proceso.getPkProceso());
			prc.proceso = proceso;
			prc.motivo = CN.getMotivoCalificacion();
			event.setView("EDI/evaluacion/selectProducto").noLayout();
		</cfscript>
	</cffunction>	

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaPuntajeProducto" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.guardaPuntajeProducto(rc.puntajes);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaPuntajeProductoCero" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.guardaPuntajeProductoCero(rc.puntajes);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaComentarioEvaluacion" hint="Guarda el comentario a una evaluacion">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.guardaComentarioEvaluacion(rc.pkEvaluacion, rc.contenido);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="reclasificacionProducto" hint="Cambia la clasificacion de un producto">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.reclasificacionProducto(rc.pkProdRecla, rc.pkEvalEtapa);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAnioGracia" hint="Obtiene el año de gracia con base al pk de una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			resultado.pkPersona = rc.pkPersona;
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addSolicitudComite" hint="Agrega la solicitud del comité">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			resultado.pkPersona = rc.pkPersona;
			resultado.add = 1;
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getTablaSolicitudComite" hint="Mostrar la tabla de la solicitud del comité">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.pkPersona = rc.pkPersona;
			event.setView("EDI/evaluacion/tablaSolicitudComite").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	24 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getTablaPlazas" hint="Mostrar la tabla de las plazas del investigador">
		<cfargument name="event" type="any">
		<cfscript>
			var personaSiga = CN.getPersonaSiga(rc.pkPersona).PK_PERSONASIGA[1];
			prc.trayectoria = CN_CVU.getTrayectoria(personaSiga);
			event.setView("CVU/datosGenerales/trayectoriaIpn/trayectoriaIpn").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getTablaProyectos" hint="Mostrar la tabla de los proyectos del investigador">
		<cfargument name="event" type="any">
		<cfset CN_FT =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >		
		<cfscript>
			var rc = Event.getCollection();
			prc.tablaProyectos = CN.getEvaluacionDatosInvestigador(rc.pkPersona, rc.pkMovimiento);			
			prc.proyectos = CN_FT.getNodosHojaCVU(126,rc.pkUsuario); // 126 = Projectos de Investigacion			
			event.setView("EDI/evaluacion/T_Proyectos").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getTablaEscolaridad" hint="Mostrar la tabla de la formacion academica del investigador">
		<cfargument name="event" type="any">		
		<cfscript>		
			var rc = Event.getCollection();						
			var pkPersona = rc.pkPersona;
			var pkEvaluador = Session.cbstorage.usuario.PK;
			prc.proceso = CN_SOL.getProcesosEDI();
			prc.motivo = CN.getMotivoCalificacion();
			prc.escolaridad = CN.getEscolaridadByPkUsuarioANDPkEvaluadorANDPkProceso(pkPersona, pkEvaluador, CN_SOL.getProcesosEDI());						
			prc.validaciones = CN.getValidacionesByEvaluacionEscolaridad(pkPersona, CN_SOL.getProcesosEDI().getPKPROCESO());
			event.setView("EDI/evaluacion/T_FormacionAcademica").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getTablaEscolaridadConsulta" hint="Mostrar la tabla de la formacion academica del investigador">
		<cfargument name="event" type="any">		
		<cfscript>		
			var rc = Event.getCollection();						
			var pkPersona = rc.pkPersona;
			prc.escolaridad = CN.getAllEscolaridadByPkPersona(pkPersona);
			event.setView("EDI/evaluacion/T_FormacionAcademicaConsulta").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getResumenEvaluacion" hint="Muestra el resumen de evaluacion">
		<cfargument name="event" type="any">
		<cfset CN_FT =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >		
		<cfscript>
			prc.proceso = CN_SOL.getProcesosEDI();
			prc.productos = CN_FT.getNodosTodosSeleccionadosUsuario(rc.pkUsuario);
			prc.resumen = CN.getResumenEvaluacion(prc.productos,prc.proceso,rc.pkTipoEvaluacion);					
			prc.escolaridad = CN.getObtencionGradoEscolarByPkPersona(rc.pkUsuario);
			prc.resumen = CN.addEscolaridadAResumen(prc.escolaridad,prc.resumen,prc.proceso,rc.pkTipoEvaluacion);
			prc.tiposEvaluacion = CN.getTiposEvaluacion();	
			event.setView("EDI/evaluacion/resumenEvaluacion").noLayout();			
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="cambiaEstadoEvalAspiranteProceso">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.cambiaEstadoEvalAspiranteProceso(rc.pkRegistro, rc.accion, rc.pkEvaluado, rc.tipoEval, rc.pkNivel, rc.observacion, rc.anioGracia, rc.residencia, rc.dispensa, rc.artDispensa);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="cambiaEstadoEvaluacionEscolaridad">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.cambiaEstadoEvaluacionEscolaridad(deserializeJSON(rc.pkRegistro),rc.accion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="quitarReclasificacion" hint="Elimina la relcasificacion de un producto">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.quitarReclasificacion(rc.pkEtapa);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
    *Fecha: Febrero de 2018
	*Autor:	JLGC
    --->
    <cffunction name="guardarObservacion" hint="Realiza guardado de la observacion de la evaluacion del investigador">
    	<cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.guardarObservacion(rc.PkAspProc, rc.PkTipoEva, rc.observaciones);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
	*Fecha: Febrero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getObservacion" hint="Muestra observacion de la evaluacion del investigador">
		<cfargument name="event" type="any">
		<cfscript>
		    var rc = event.getCollection();
            var resultado = CN.getObservacion(rc.PkAspProc, rc.PkTipoEva);
            event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha: Febrero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getSolicitudResidenciaInv" hint="Muestra la solicitud de residencia del investigador">
		<cfargument name="event" type="any">
		<cfscript>
		    var rc = event.getCollection();
            var resultado = CN.getSolicitudResidenciaInv(rc.PkAspProc);
            event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="cambiarEstadoSolicitudSimple" hint="Mantiene la residencia del investigador">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.mantieneResidencia(rc.pkAspProc, rc.accion, SESSION.CBSTORAGE.PERSONA.PK, 3);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Febrero 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="evaluarResidencia" hint="Mantiene la residencia del investigador">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.mantieneResidencia(rc.pkAspProc, rc.accion, rc.pkPersona, rc.evaluacion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Marco Torres
	--->
	<cffunction name="enviarToEvaluacion" hint="envia un producto evaluado a la evaluacion actual">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CN_SOL.getProcesosEDI();
			resultado = CN.enviarToEvaluacion(rc.pkfila,proceso.getPKPROCESO());
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="guardaPuntajeEvaluacionEsc" hint="Muestra el resumen de evaluacion">
		<cfargument name="event" type="any">
		<cfscript>			
			resultado = CN.guardaPuntajeEvaluacionEsc(rc.pkEvaluacion, rc.puntaje);
			event.renderData(type="json", data=resultado);
		</cfscript>	
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="guardaPuntajeEvaluacionEscCero" hint="Guarda una puntuacion en cero">
		<cfargument name="event" type="any">
		<cfscript>			
			resultado = CN.guardaPuntajeEvaluacionEscCero(rc.pkEvaluacion, rc.puntaje, rc.motivo);
			event.renderData(type="json", data=resultado);
		</cfscript>	
	</cffunction>

</cfcomponent>
