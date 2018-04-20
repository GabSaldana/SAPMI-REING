<cfcomponent>
	
	<cfproperty name="CN"		inject="EDI.solicitud.CN_Solicitud">
	<cfproperty name="cnCVU"	inject="CVU.CN_CVU">
	<cfproperty name="cnEDI"	inject="EDI.CN_EDI">
	<cfproperty name='cnFT'		inject="formatosTrimestrales.CN_FormatosTrimestrales">
	<cfproperty name="cache"	inject="cachebox:default">
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="index" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CN.getProcesosEDI();
			prc.solicitudesDisponibles = CN.getSolcitudesDisponibles();
		   	prc.proceso = CN.getProcesosEDI();
		   	prc.pkPersona = Session.cbstorage.persona.PK[1];
			prc.estatus = CN.getEstadoPersona(prc.pkPersona);
			prc.recursoIn = CN.getRecursoIn();
			prc.edoAsporc = CN.getEdoAspiranteProceso(prc.pkPersona, proceso.getpkproceso());
			event.setView("EDI/solicitud/index");
		</cfscript>
	</cffunction>
	
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getFlujoSolicitud" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
		   	var proceso = CN.getProcesosEDI();
			prc.pestanias = CN.getPestaniasSolicitud(rc.pkMovimiento);
			prc.pkPersona = Session.cbstorage.persona.PK[1];
			prc.proceso = proceso;
			prc.solicitud = CN.getSolicitudAspirante(prc.pkPersona, proceso.getpkproceso(), rc.pkMovimiento);
			event.setView("EDI/solicitud/solicitud").noLayout();
		</cfscript>
	</cffunction>
	
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="cambiarEstado" hint="Cambia el estado del registro indicado al siguiente de la ruta">
		<cfargument name="Event" type="any">
		<cfscript>
			var destin = deserializeJSON(rc.destinatarios);
			var resultado = CN.cambiarEstadoSolicitud(rc.pkRegistro, rc.accion, rc.asunto, rc.comentario, rc.prioridad, destin, rc.tipoComent);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getResumen" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			CN.setAspiranteRequisitoProducto(rc.pkPersona, rc.pkMovimiento);
			prc.resumen = CN.getRequisitosPersona(rc.pkMovimiento,rc.pkPersona);	
			event.setView("EDI/solicitud/pestanias/resumen").noLayout();
		</cfscript>
	</cffunction>	
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionEDD" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.edd = CN.getEDD(rc.pkAspirante, Session.cbstorage.persona.PK[1]);
			event.setView("EDI/solicitud/pestanias/valEDD").noLayout();
		</cfscript>
	</cffunction>
		
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addAspiranteRequisito" hint="Actualiza requisitos">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.addAspiranteRequisito(rc.pkAspirante, rc.pkRequisito, rc.pkEstado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionPlazasNom" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);
			prc.nivelSNI = cnCVU.getNivelSNI();
			prc.areaSNI = cnCVU.getAreaSNI();
			prc.plazaNom = CN.getPlazaNom(rc.pkAspirante, Session.cbstorage.persona.PK[1]);
			event.setView("EDI/solicitud/pestanias/valPlazas").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addSNI" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = cnCVU.addSNI(Session.cbstorage.persona.PK[1], rc.inNivelSNI,rc.inInicioSNI, rc.inFinSNI, rc.inAreaSNI);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPlazaNom" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.getPlazaNom(rc.pkAspirante, Session.cbstorage.persona.PK[1]);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionNoRelLab" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);
			event.setView("EDI/solicitud/pestanias/valNoRelacionLaboral").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionInvest" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>			
			prc.productos = cnFT.getNodosTodosNoEvaluado();
			event.setView("EDI/solicitud/pestanias/valInvestigacion").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionFormAc" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.pkPersona = Session.cbstorage.persona.PK[1];
			prc.escolaridad = cnCVU.getEscolaridad(prc.pkPersona);
			prc.nivel = cnCVU.getNiveles();
			prc.pais = cnCVU.getPaises();
			prc.formAc = CN.getFormAc(Session.cbstorage.persona.PK[1], rc.pkAspirante);
			event.setView("EDI/solicitud/pestanias/valFormacionAcademica").noLayout();
		</cfscript>
	</cffunction>	

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionProyectoInvestigacion" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVII, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVII);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>	

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionInvestigacion" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVII, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVII);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionFAcademica" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.getFormAc(Session.cbstorage.persona.PK[1], rc.pkAspirante);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionRelacionLab" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVI, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVI);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionActDocentes" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionComites" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV4, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV4);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionSeminarios" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV3, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV3);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionAsesorias" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV2, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECIV2);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setValidacionsolResidencia" hint="valida la solicitud de residencia">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var addAspirante = CN.addAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART16, rc.estado);
			var resultado = CN.consultarAspiranteRequisito(rc.pkAspirante, application.SIIIP_CTES.TREQUISITO.ART16);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionResProd" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valProductosResidencia").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionActDocente" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>		
			prc.productos  = cnFT.getNodosHojaNoEvaluado(application.SIIIP_CTES.CPRODUCTO.ACTDOCENTE);
			event.setView("EDI/solicitud/pestanias/valActividadDocente").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionRes" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			//prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);
			prc.mensaje = CN.getaspiranteProceso(Session.cbstorage.persona.PK[1], rc.pkMovimiento);
			event.setView("EDI/solicitud/pestanias/valResidencia").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionInfoBi" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valInformeBianual").noLayout();
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionPatTransf" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valPatenteTransferencia").noLayout();
		</cfscript>
	</cffunction>

	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionProyInves" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);
			prc.productos  = cnFT.getNodosHojaNoEvaluado(application.SIIIP_CTES.CPRODUCTO.PROYINVES);
			event.setView("EDI/solicitud/pestanias/valProyectoInvestigacion").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionMantSNI" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valMantenerSNI").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionBajaRes" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valBajaResidente").noLayout();
		</cfscript>
	</cffunction>

	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionReceso" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valReceso").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionBajaTemp" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valBajaTemporal").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionBajaDef" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valBajaDefinitiva").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionHistInves" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valHistoralInvestigador").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cargaValidacionTitAlumn" hint="Muestra la vista para la solicitud al EDI">
		<cfargument name="event" type="any">
		<cfscript>
			prc.requisitos = CN.getRequisitosPestania(rc.pkMovimiento,rc.pkPestania);	
			event.setView("EDI/solicitud/pestanias/valTitulacionAlumnos").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEvaluacionProducto" hint="Agrega la evaluación del producto">
		<cfargument name="event" type="any">
		<cfscript>		
			var rc = Event.getCollection();
			resultado = CN.addEvaluacionProducto(pkFila, pkProducto, pkEstado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getCartaRelacionLaboral" hint="Generar Carta de no relacion laboral">
		<cfargument name="event" type="any">
		<cfscript>
			prc.datos 	= CN.getDatosPersona(rc.pkPersona);
			prc.ur 		= CN.getDatosUR(prc.datos.PKUR[1]);
			prc.proceso = CN.getProcesosEDI();
			prc.folio	= CN.getaspiranteProceso(rc.pkPersona, rc.pkMovimiento);
			prc.Fecha	= CN.getFecha();
	 		event.setView("EDI/solicitud/relacionLaboral");
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getReporteResultados" hint="Generar Carta de no relacion laboral">
		<cfargument name="event" type="any">
		<cfscript>
			prc.proceso = CN.getProcesosEDI();
			prc.productos = cnFT.getNodosTodosSeleccionadosUsuario(rc.pkUsuario,prc.proceso.getPKPROCESO());
			prc.resumen = cnEDI.getResumenEvaluacion(prc.productos,prc.proceso,application.SIIIP_CTES.TIPOEVALUACION.FINAL);			
			// prc.beca = CN.getBecaByAspiranteProcesoFinal(rc.pkPersona);			
			// prc.resumen = cnEDI.getAutoEvaluacion(prc.productos,prc.proceso);									
			prc.clasificaciones = cnFT.getClasificacionesCVU();
			prc.folio	= CN.getaspiranteProceso(rc.pkPersona, rc.pkMovimiento);
			prc.Fecha	= CN.getFecha();
			prc.nombre	= rc.nombrePersona;
			prc.ur 		= CN.getDatosUR(rc.pkUR).nombre[1];
			prc.observaciones = CN.getObservacionCA(rc.pkPersona);						
			// writeDump(var=prc.resumen);
			// abort;
	 		event.setView("EDI/solicitud/reporteResultados").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addMensajeAspiranteProceso" hint="Agrega un mesake a la tabla aspirante proceso">
		<cfargument name="event" type="any">
		<cfscript>		
			var rc = Event.getCollection();
			resultado = CN.addMensajeAspiranteProceso(rc.pkAspirante, rc.mensaje);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Descripcion:    Muestra la vista para la solicitud al EDI para edicion (copia de Index)
    * Fecha creacion: 04 de diciembre de 2017
    * @author:        JLGC
    --->
	<cffunction name="textosMovimientos" hint="Muestra la vista para la solicitud al EDI para edicion">
		<cfargument name="event" type="any">
		<cfscript>
			prc.solicitudesDisponibles = CN.getSolcitudesDisponiblesSinPersona();
		    var proceso = CN.getProcesosEDI();
			event.setView("CVU/adminEDI/textosMovimientos/index");
		</cfscript>
	</cffunction>

	<!--- 
    * Descripcion:    Edita el nombre del movimiento
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoNombre" hint="Edita el nombre del movimiento">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.editarMovimientoNombre(rc.pkMovimiento, rc.movimientoNombre);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita la observacion del movimiento
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoObservacion" hint="Edita la observacion del movimiento">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.editarMovimientoObservacion(rc.pkMovimiento, rc.movimientoObservacion);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita la descripcion del movimiento
    * Fecha creacion: 05 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoDescripcion" hint="Edita la descripcion del movimiento">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.editarMovimientoDescripcion(rc.pkMovimiento, rc.movimientoDescripcion);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Muestra la vista para la administracion de los estados de los invesrtigadores
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
	<cffunction name="investigadorEstado" hint="Muestra la vista para la administracion de los estados de los invesrtigadores">
		<cfargument name="event" type="any">
		<cfscript>
			Event.setView("CVU/adminEDI/investigadorEstado/V_Investigador");
		</cfscript>
	</cffunction>

	<!---
    * Descripcion: Carga listado de investigadores para la vista tabla Investigadores
    * Fecha:       11 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="cargarTablaInvestigadores" hint="Carga listado de investigadores para la vista tabla Investigadores">
        <cfargument name="Event" type="any">
        <cfscript>
            prc.tablaInvestigadores  = CN.getTablaInvestigadores();
            prc.Estados              = CN.getEstados();
            Event.setView("CVU/adminEDI/investigadorEstado/T_Investigador").noLayout();
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita la estado del investigador
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarEstadoInvestigador" hint="Edita la estado del investigador">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.editarEstadoInvestigador(rc.pkEstadoInvestigador, rc.estado);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion: Muestra la vista para la solicitud al comite
	* Fecha:	   Diciembre de 2017
	* Autor:	   JLGC
	--->
	<cffunction name="getFlujoComite" hint="Muestra la vista para la solicitud al comite">
		<cfargument name="event" type="any">
		<cfscript>
		    prc.proceso = CN.getProcesosEDI();
			prc.pkPersona = Session.cbstorage.persona.PK[1];
			prc.tipoSolicitud = CN.getTiposSolComite();
			event.setView("EDI/solicitud/comite/V_Comite").noLayout();
		</cfscript>
	</cffunction>

	<!---
    * Descripcion: Carga listado de solicitudes al comite
    * Fecha:       28 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="cargarTablaComite" hint="Carga listado de solicitudes al comite">
        <cfargument name="Event" type="any">
        <cfscript>
        	var rc = event.getCollection();
            prc.tablaComite   = CN.getTablaComite(rc.fkPersona);
            Event.setView("EDI/solicitud/comite/T_Comite").noLayout();
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nueva solicitud al comite
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarComite" hint="Guarda nueva solicitud al comite">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.agregarComite(rc.fkPersona, rc.fkProceso, rc.descripcion, rc.fkTipo, rc.fkEstado);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Editar solicitud al comite
    * Fecha creacion: 29 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarComite" hint="Editar solicitud al comite">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.editarComite(rc.PkSolicitud, rc.fkPersona, rc.fkProceso, rc.descripcion, rc.fkTipo);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Elimina solicitud al comite seleccionada
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="eliminarComite" hint="Elimina solicitud al comite seleccionada">
        <cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.eliminarComite(rc.PkSolicitud, rc.fkEstado);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>
    
    <!--- 
    *Fecha:	Enero de 2018
    *Autor:	Daniel Memije
    --->
    <cffunction name="autoevaluacion" hint="Muestra la vista para la autoevaluacion">
			<cfargument name="event" type="any">			
			<cfset CN_FT =  getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
    	<cfscript>    		
				prc.pkUsuario = Session.cbstorage.usuario.PK;				
				prc.proceso = CN.getProcesosEDI();
				prc.productos = cnFT.getNodosTodosSeleccionados();				
				prc.autoevaluacion = cnEDI.getAutoEvaluacion(prc.productos,prc.proceso);  	   								
  	   	event.setView("EDI/solicitud/autoevaluacion").noLayout();
    	</cfscript>
    </cffunction>
    
    <!--- 
    *Fecha: Marzo de 2018
	*Autor:	Alejandro Tovar
	*Modificacion: Obtiene las validaciones del registro
	--------------------------------
	*Fecha: Enero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="cargaProductosSeleccionados" hint="Muestra la vista de los productos solicitud EDI seleccionados">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CN.getProcesosEDI();
			prc.validaciones = CN.getEdoAspiranteProceso(rc.pkPersona, proceso.getpkproceso());
			prc.proceso = CN.getProcesosEDI();
			prc.productos = cnFT.getNodosTodosSeleccionadosUsuario(rc.pkUsuario);
			prc.resumen = cnEDI.getResumenEvaluacion(prc.productos,prc.proceso,3);		
			prc.tiposEvaluacion = cnEDI.getTiposEvaluacion();	
			event.setView("EDI/solicitud/inconformidad/seleccionProductos").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
    *Fecha: Enero de 2018
	*Autor:	JLGC
    --->
    <cffunction name="guardaRecursoInconformidad" hint="Realiza guardado y cambio de estado al recurso de inconformidad">
    	<cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.guardaRecursoInconformidad(rc.PkProducto, rc.descripcionInconformidad);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Enero de 2018
	*Autor:	JLGC
    --->
    <cffunction name="eliminaRecursoInconformidad" hint="Realiza el cambio de estado al recurso de inconformidad a cero">
    	<cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.eliminaRecursoInconformidad(rc.PkProducto);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>
    
    <!--- 
    *Fecha:	Enero de 2018
    *Autor:	Alejandro Rosales
    --->
    <cffunction name="autoevaluacionPDF" hint="Muestra la vista para la autoevaluacion version pdf">
			<cfargument name="event" type="any">			
			<cfset CN_FT =  getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
    	<cfscript>    		
				 prc.pkUsuario = Session.cbstorage.usuario.PK;				
				 prc.proceso = cache.get("proceso");				
				 prc.productos = cnFT.getNodosTodosSeleccionados();	
				 prc.autoevaluacion = cnEDI.getAutoEvaluacion(prc.productos,prc.proceso);
				 prc.Fecha	= CN.getFecha();
				 prc.nombre	= Session.cbstorage.usuario.nombre & ' ' & Session.cbstorage.usuario.ap_pat & ' ' & Session.cbstorage.usuario.ap_mat;
				 prc.ur 		= CN.getDatosUR(Session.cbstorage.usuario.ur).nombre[1];			 								
  	   			event.setView("EDI/solicitud/pdfProductosAutoevaluacion").noLayout();
    	</cfscript>
    </cffunction>
    
    <!--- 
    *Fecha: Enero de 2018
	*Autor:	JLGC
    --->
    <cffunction name="guardaNarracion" hint="Realiza guardado de la narración de los hechos de la Inconformidad">
    	<cfargument name="event" type="any">
        <cfscript>
            var rc = event.getCollection();
            var resultado = CN.guardaNarracion(rc.PkPersona, rc.PkProceso, rc.hechos);
            event.renderData(type="json", data=resultado);
        </cfscript>
    </cffunction>

    <!--- 
	*Fecha: Enero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getNarracion" hint="Muestra el contenido de la narración de los hechos de la Inconformidad">
		<cfargument name="event" type="any">
		<cfscript>
		    var rc = event.getCollection();
            var resultado = CN.getNarracion(rc.PkPersona, rc.PkProceso);
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
			resultado = cnEDI.mantieneResidencia(rc.pkAspProc, rc.accion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getNomina" hint="Muestra la vista para obtener nomina">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("EDI/solicitud/nomina/nomina");
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getTablaNomina" hint="Muestra la vista para obtener nomina">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CN.getProcesosEDI();
			prc.nomina  = CN.getTablaInvestigadoresNomina(rc.mayorCero, rc.clave, rc.cveGracia, rc.cveResidencia, rc.cveOficio, proceso.getpkproceso(), solAt, SolRI);	
			event.setView("EDI/solicitud/nomina/tablaNomina").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="generarDocumento" hint="Muestra la vista para obtener nomina">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso = CN.getProcesosEDI();
			prc.nomina 	= CN.getEnviadosNomina(proceso.getpkproceso(), oficioTxt);
			prc.tipoDoc = rc.tipoDocTxt;
			event.setView("EDI/solicitud/nomina/txtNomina").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaNomina" hint="Guarda aspirantes en la nomina">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.guardaNomina(rc.clave, rc.cveGracia, rc.cveResidencia, rc.cveOficio, rc.aspirantes);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getEnviadosNomina" hint="Muestra listado de investigadores enviados a nomina">
		<cfargument name="event" type="any">
		<cfscript>
			var proceso   = CN.getProcesosEDI();
			prc.oficio 	  = rc.oficio;
			prc.envNomina = CN.getEnviadosNomina(proceso.getpkproceso(), rc.oficio);
			prc.oficios   = CN.getOficios(proceso.getpkproceso());
			event.setView("EDI/solicitud/nomina/tablaEnviadosNomina").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="cambiaEstadoNomina" hint="Cambia el estado de la nomina por aspirante">
		<cfargument name="event" type="any">
		<cfscript>
			resultado = CN.cambiaEstadoNomina(rc.pkAspirante);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent>