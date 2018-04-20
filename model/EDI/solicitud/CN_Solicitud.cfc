<cfcomponent>

	<cfproperty name="dao"			inject="EDI/solicitud/DAO_Solicitud">
	<cfproperty name="populator"	inject="wirebox:populator">
	<cfproperty name="wirebox"		inject="wirebox">
	<cfproperty name="cache"		inject="cachebox:default">
	<cfproperty name="daoCVU"		inject="EDI/DAO_EDI">
	<cfproperty name="cnMes"      	inject="utils.maquinaEstados.CN_maquinaEstados">
	<cfproperty name="cnUtils"      inject="utils.CN_utilities">

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getSolcitudesDisponibles" hint="Obtiene todos los productos">
		<cfargument name="pkPersona" type="numeric" required="no" hint="pk de la persona" default="0">
		<cfscript>
			var rol = session.cbstorage.usuario.ROL;
			var procesoActivo = this.getProcesosEDI();
			
			if(!isdefined('pkPersona') OR pkPersona eq 0){
				pkPersona = Session.cbstorage.persona.PK[1];
			}
			var movimientos=[];
			/*obtiene los movimientos disponibles para la persona en el reglamento vigente y cruza con el control de estados*/
			var consultaSolicitudes = DAO.getSolcitudesDisponibles(pkPersona, procesoActivo.getPKREGLAMENTO());
			var solicitudesAcciones = cnMes.getQueryAcciones(86, consultaSolicitudes, rol,1);
			
			for(var x=1; x lte solicitudesAcciones.recordcount; x++){
				var movimiento=populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_Movimiento"),solicitudesAcciones,x);
				arrayAppend(movimientos, movimiento);
			}
			/*inserta los movimientos en en el objeto que almacena los movimientos*/
			var movReglamento = wirebox.getInstance("EDI/solicitud/B_MovimientoReglamento");
			
			movReglamento.setPROCESO(procesoActivo);
			movReglamento.setMOVIMIENTOS(movimientos);
			
			return movReglamento;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getPestaniasSolicitud" hint="Obtiene todos los productos">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
				var encabezado2 = cache.get("pestanias_"&pkMovimiento);
				if (!isNull(encabezado2)){
					return encabezado2;
				} else{
					var pestaniaConsulta = DAO.getPestaniasSolicitud(pkMovimiento);
					var pestanias = [];
					for(var x=1; x lte pestaniaConsulta.recordcount; x++){
						var pestania=populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_Pestania"),pestaniaConsulta,x);
						arrayAppend(pestanias, pestania);
					}
				}
				cache.set("pestanias_"&pkMovimiento, pestanias, 120, 20);
				return pestanias;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getRequisitosPestania" hint="Obtiene todos los productos">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkPestania" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
				
				var requisitosConsulta = DAO.getRequisitosPestania(pkMovimiento,pkPestania);
				/*var requisitos = [];
				
				for(var x=1; x lte requisitosConsulta.recordcount; x++){
					
					var requisito=populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_Requisito"),requisitosConsulta,x);
					
					arrayAppend(requisitos, requisito);
			

*/
				return requisitosConsulta;
		</cfscript>
	</cffunction>	
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getRequisitosPersona" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			if(!isdefined('pkPersona') OR pkPersona eq 0){
				pkPersona = Session.cbstorage.persona.PK[1];
			}
			var solicitud = wirebox.getInstance("EDI/solicitud/B_Solicitud");
			var requisitosConsulta = DAO.getRequisitosPersona(pkMovimiento,pkPersona);
			
			/*CREA TODOS LOS CREQUISITOS DE LA SOLICITUD*/	
			var CRequisitos = [];
			for(var x=1; x lte requisitosConsulta.recordcount; x++){
				if(x eq 1 OR (requisitosConsulta.PK_CREQUISITO[x] neq requisitosConsulta.PK_CREQUISITO[x-1])){
					var Crequisito=populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_CRequisito"),requisitosConsulta,x);
					arrayAppend(Crequisitos, Crequisito);
					requisitos = [];
				}
			}
			solicitud.setRequisitos(CRequisitos);
			/*INSERTA TODOS LOS TREQUISITOS DE LA SOLICITUD*/	
			for(var x=1; x lte requisitosConsulta.recordcount; x++){
					var requisito=populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_TRequisito"),requisitosConsulta,x);
					solicitud.setTrequisitos(requisito);
			}
			solicitud.validaRequisitos();
			return solicitud ;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setAspiranteRequisitoProducto" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			aspirante 	= this.getAspirante(pkPersona, this.getProcesosEDI().getPKPROCESO(), pkMovimiento);
			consulta 	= DAO.getAspiranteRequisitoProducto(pkMovimiento, pkPersona, this.getProcesosEDI().getPKPROCESO());
			consultamax = DAO.getAspiranteRequisitoProductoNumero(pkMovimiento, pkPersona, this.getProcesosEDI().getPKPROCESO());
			prodSelec 	= 0;
			for(var i=1; i lte consultamax.recordcount; i++){
				for(var j=1; j lte consulta.recordcount; j++)
					if(consulta.PKTREQUISITO[j] eq consultamax.PKTREQUISITO[i])
						prodSelec = prodSelec + 1;
				if(prodSelec lte consultamax.MAXIMOPROD[i])
					respuesta = this.addAspiranteRequisito(aspirante, consultamax.PKTREQUISITO[i], 2);
				prodSelec = 0;
			}
			return respuesta;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="cambiarEstadoSolicitud" hint="Obtiene las acciones disponibles de acuerdo al rol de usuario">
		<cfargument name="pkRegistro"    type="numeric" required="yes" hint="Pk del registro que se va a modificar">
		<cfargument name="accion"        type="string"  required="yes" hint="Pk de la accion">
		<cfargument name="asunto"        type="string"  required="no"  hint="asunto">
		<cfargument name="comentario"    type="string"  required="no"  hint="comentario">
		<cfargument name="prioridad"     type="numeric" required="yes" hint="prioridad del comentario">
		<cfargument name="destinatarios" type="array"   required="yes" hint="arreglo de destinatarios">
		<cfargument name="tipoComent"    type="numeric" required="yes" hint="prioridad del comentario">
		<cfscript>

			var pkProced = 86;//cambiar por una constante
            var pkRol 	 = session.cbstorage.usuario.ROL;

			respuesta = StructNew();
			resPreoperacion   = StructNew();
			postPreoperacion  = StructNew();
			respuesta.exito   = true;
			respuesta.mensaje = '';
			
			//OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
			estadoactual = cnMes.getEdoActual(pkProced, pkRegistro);
			pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, pkRol, estadoactual.ESTADO[1]);

			//OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
			//EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)
			resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1]);

			//SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
			if (resPreoperacion.exito){
				//CAMBIO DE ESTADO EN LA TABLA A MODIFICAR (TMPTPRUEBACES)
				registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, pkRol, pkProced, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

				//VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
				if (registroBitacora.fallo){
					//obtiene el estado actual del registro y lo muestra en el mensaje de salida.
					msjFallo = cnMes.getEdoActual(pkProced, pkRegistro);
					respuesta.exito = false;
					respuesta.fallo = true;
					respuesta.mensaje = msjFallo.NOM_EDO[1];
					return respuesta;
				}

				//OBTENER POS-OPERACIONES DE LA ACCION
				postPreoperacion  = this.ejecutaPostOperaciones(pkEdoAccion.EDOACC_PK[1]);
				respuesta.exito   = postPreoperacion.exito;
				respuesta.mensaje = postPreoperacion.mensaje;

				//INDICA SI EL CAMBIO DE ESTADO FUE UN RETROCESO
                respuesta.retroceso = registroBitacora.RETROCESO;
				// respuesta.edoDest = registroBitacora.edoOrigen;

                /*if (respuesta.retroceso == true){
					this.notificacionRechazo(pkRegistro, claveConvenio);
                } else{
                	var pkRolSiguiente = cnUtils.queryToArray(cnMes.getRolSigByClaveAccion(accion, estadoactual.ESTADO[1]));
                	for (var i = 1; i <= ArrayLen(pkRolSiguiente); i++){
                		this.notificacionValidacion(pkRolSiguiente[i].PK_ROL, claveConvenio);
                	}
                }*/

				//ACTUALIZA LA BITACORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
				if (respuesta.mensaje NEQ ''){
					cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
				}

				//REGISTRA EL COMENTARIO EN LA TABLA COMTCOMENTARIO
				if (comentario NEQ ''){
					cnCom.registraComentario(asunto, comentario, prioridad, registroBitacora.edoOrigen, pkRegistro, destinatarios, tipoComent);
				}

			}else {
				respuesta = resPreoperacion;
			}

			return respuesta;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="ejecutaPreOperaciones" hint="Ejecuta pre-operaciones">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfscript>
            respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';
            return respuesta;
        </cfscript>
    </cffunction>

    <!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="ejecutaPostOperaciones" hint="Ejecuta pos-operaciones">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfscript>
            respuesta = StructNew();
            respuesta.exito = true;
            respuesta.mensaje = '';
            return respuesta;
        </cfscript>
    </cffunction>	
	
	<cffunction name="getEDD" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkAspirante" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			var edd = structNew();
			edd.requisito = application.SIIIP_CTES.TREQUISITO.ART11SECIX;
			contarCVUSol = DAO.cuentaBeca(pkPersona, 1);
			edd.solicitud = DAO.consultarAspiranteRequisito(pkAspirante,application.SIIIP_CTES.TREQUISITO.ART11SECIX);
			edd.consuta = (contarCVUSol NEQ 0 ) ? 0 : 2;
			this.addAspiranteRequisito(pkAspirante, application.SIIIP_CTES.TREQUISITO.ART9, edd.consuta);
			return edd;
		</cfscript>
	</cffunction>

	<cffunction name="addAspiranteRequisito" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkAspirante" 	type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkRequisito" 	type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkEstado"		type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.addAspiranteRequisito(pkAspirante, pkRequisito, pkEstado);
		</cfscript>
	</cffunction>

	<cffunction name="getProcesosEDI" hint="Obtiene el proceso de evaluacion de EDI">
		<cfscript>
			var salida = cache.get("proceso");
			if(isNull(salida)){
			 	var listaprocesos = DAO.obtenerProcesoActual();
				var proceso = populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_ProcesoEDI"),listaprocesos,1);
			    cache.set("proceso", proceso, 120, 120);
			    return proceso;
			} else
				return salida;
		</cfscript>
	</cffunction>

	<cffunction name="getPlazaNom" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkAspirante" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			var plazaNom = structNew();
			contarCVUSNI = DAO.cuentaSNI(pkPersona, 1);
			plazaNom.prof =		DAO.consultarAspiranteRequisito(pkAspirante,application.SIIIP_CTES.TREQUISITO.ART11SECI);
			plazaNom.sni =		DAO.consultarAspiranteRequisito(pkAspirante, 76);
			plazaNom.horas =	DAO.consultarAspiranteRequisito(pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECII);
			plazaNom.sni = (contarCVUSNI EQ 0 ) ? 0 : 2;
			this.addAspiranteRequisito(pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECI2, plazaNom.sni);
			this.addAspiranteRequisito(pkAspirante, application.SIIIP_CTES.TREQUISITO.ART16SEC1, plazaNom.sni);
			return plazaNom;
		</cfscript>
	</cffunction>
	
	<cffunction name="getSolicitudAspirante" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkProceso" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			if(DAO.getAspirante(pkPersona, pkProceso, pkMovimiento) NEQ 0){
				return DAO.getAspirante(pkPersona, pkProceso, pkMovimiento);
			} else {
				datosMov = this.getEstadoCapturaMovimiento(pkMovimiento);//REGRESA PKRUTA Y PKESTADO
				return DAO.addAspiranteProceso(pkPersona, this.getProcesosEDI().getPKPROCESO(), pkMovimiento, datosMov.pkEstado[1], datosMov.pkRuta[1]);
				
			}
		</cfscript>
	</cffunction>

	<cffunction name="getEstadoCapturaMovimiento" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return dao.getEstadoCapturaMovimiento(pkMovimiento);
		</cfscript>
	</cffunction>
	
	<cffunction name="getAspirante" hint="Obtiene el pkAspirante con base al pkPersona y al pkProceso">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkProceso" type="numeric" required="yes" hint="pk del proceso">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return dao.getAspirante(pkPersona, pkProceso, pkMovimiento);				
		</cfscript>
	</cffunction>
	
		<cffunction name="getFormAc" hint="Obtiene el pkAspirante con base al pkPersona y al pkProceso">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkAspirante" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			var formAc = structNew();
			var contarCVUFormAc = DAO.cuentaformAc(pkPersona, application.SIIIP_CTES.CESCOLARIDAD.PKDOCTORADO , application.SIIIP_CTES.CESCOLARIDAD.PKMAESTRIA);
			formAc.consulta = (contarCVUFormAc EQ 0 ) ? 0 : 2;
			this.addAspiranteRequisito(pkAspirante, application.SIIIP_CTES.TREQUISITO.ART11SECVIII, formAc.consulta);
			return formAc;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarAspiranteRequisito" hint="agrega escolaridad a una persona">
		<cfargument name="pkAspirante"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkRequisito"	type="numeric"	required="yes" hint="pk del requisito">
		<cfscript>
			return dao.consultarAspiranteRequisito(pkAspirante, pkRequisito);				
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEvaluacionProducto" hint="agrega escolaridad a una persona">
		<cfargument name="pkFila"		type="numeric"	required="yes" hint="pk de las filas">
		<cfargument name="pkProducto"	type="numeric"	required="yes" hint="pk del los productos">
		<cfargument name="pkEstado"		type="numeric"	required="yes" hint="pk del los productos">
		<cfscript>			
			return dao.addEvaluacionProducto(pkFila, pkProducto, pkEstado, this.getProcesosEDI().getPKPROCESO(), cnMes.getPrimerEstado(application.SIIIP_CTES.RUTA.EVALUACIONEDI).ESTADO[1],  application.SIIIP_CTES.RUTA.EVALUACIONEDI);;
		</cfscript>
	</cffunction>

	<!--- 
    * Descripcion: Obtiene todos los estatos de movimientos sin el filtro de personas (copia de getSolcitudesDisponibles)
    * Fecha:       Diciembre de 2017
    * Autor:       JLGC
    --->
    <cffunction name="getSolcitudesDisponiblesSinPersona" hint="Obtiene todos los estatos de movimientos sin el filtro de personas">
        <cfscript>
            var rol = session.cbstorage.usuario.ROL;
            var procesoActivo = this.getProcesosEDI();
            
            var movimientos=[];
            /*obtiene los movimientos disponibles para la persona en el reglamento vigente y cruza con el control de estados*/
            var consultaSolicitudes = DAO.getSolcitudesDisponiblesSinPersona(procesoActivo.getPKREGLAMENTO());
            var solicitudesAcciones = cnMes.getQueryAcciones(86, consultaSolicitudes, rol,1);
            
            for(var x=1; x lte solicitudesAcciones.recordcount; x++){
                var movimiento=populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_Movimiento"),solicitudesAcciones,x);
                arrayAppend(movimientos, movimiento);
            }
            /*inserta los movimientos en en el objeto que almacena los movimientos*/
            var movReglamento = wirebox.getInstance("EDI/solicitud/B_MovimientoReglamento");
            
            movReglamento.setPROCESO(procesoActivo);
            movReglamento.setMOVIMIENTOS(movimientos);
            
            return movReglamento;
        </cfscript>
    </cffunction>

	<!---
    * Descripcion:    Edita el nombre del movimiento
    * Fecha creacion: 08 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoNombre" hint="Edita el nombre del movimiento">
        <cfargument name="pkMovimiento"     type="numeric" required="yes" hint="Pk del movimiento">
        <cfargument name="movimientoNombre" type="string"  required="yes" hint="Nombre del movimiento">
        <cfscript>
            return DAO.editarMovimientoNombre(pkMovimiento, movimientoNombre);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Edita la observacion del movimiento
    * Fecha creacion: 08 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoObservacion" hint="Edita la observacion del movimiento">
        <cfargument name="pkMovimiento"          type="numeric" required="yes" hint="Pk del movimiento">
        <cfargument name="movimientoObservacion" type="string"  required="yes" hint="Observacion del movimiento">
        <cfscript>
            return DAO.editarMovimientoObservacion(pkMovimiento, movimientoObservacion);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Edita la descripcion del movimiento
    * Fecha creacion: 08 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoDescripcion" hint="Edita la descripcion del movimiento">
        <cfargument name="pkMovimiento"          type="numeric" required="yes" hint="Pk del movimiento">
        <cfargument name="movimientoDescripcion" type="string"  required="yes" hint="Descripcion del movimiento">
        <cfscript>
            return DAO.editarMovimientoDescripcion(pkMovimiento, movimientoDescripcion);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getEstadoPersona" hint="Obtiene el estado de la persona">
        <cfargument name="pkPersona" type="numeric"  required="yes" hint="Pk de la persona">
        <cfscript>
            return DAO.getEstadoPersona(pkPersona);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getDatosPersona" hint="Obtiene el estado de la persona">
        <cfargument name="pkPersona" type="numeric"  required="yes" hint="Pk de la persona">
        <cfscript>
            return DAO.getDatosPersona(pkPersona);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getDatosUR" hint="Obtiene los datos de UR">
        <cfargument name="pkUR" type="string"  required="yes" hint="Pk de la UR">
        <cfscript>
            return DAO.getDatosUR(pkUR);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion: Obtiene los investigadores y llena la tabla de la vista
    * Fecha:       11 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaInvestigadores" hint="Obtiene los investigadores y llena la tabla de la vista">
        <cfscript>
            return DAO.getTablaInvestigadores();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene los estados para llenar el combo estados de los investigadores
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getEstados" hint="Obtiene los estados para llenar el combo estados de los investigadores">
        <cfscript>
            return DAO.getEstados();
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Edita la estado del investigador
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarEstadoInvestigador" hint="Edita la estado del investigador">
        <cfargument name="pkEstadoInvestigador" type="numeric" required="yes" hint="Pk del investigador">
        <cfargument name="estado"               type="numeric" required="yes" hint="Nuevo estado">
        <cfscript>
            return DAO.editarEstadoInvestigador(pkEstadoInvestigador, estado);
        </cfscript>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getFecha" hint="Obtiene la fecha actual">
        <cfscript>
            return DAO.getFecha();
        </cfscript>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getaspiranteProceso" hint="Obtiene el aspirante proceso con base a un movimiento y una persona">
        <cfargument name="pkPersona" 	type="numeric" required="yes" hint="Pk del investigador">
        <cfargument name="pkMovimiento"	type="numeric" required="yes" hint="pk del movimiento">
        <cfscript>
            return DAO.getaspiranteProceso(pkPersona, pkMovimiento, this.getProcesosEDI().getPKPROCESO());
        </cfscript>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="addMensajeAspiranteProceso" hint="Agrega un mesake a la tabla aspirante proceso">
        <cfargument name="pkAspirante" 	type="numeric"	required="yes" hint="Pk del aspirante">
        <cfargument name="mensaje" 		type="string"	required="yes" hint="Pk del aspirante">
        <cfscript>
            return DAO.addMensajeAspiranteProceso(pkAspirante, mensaje);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Obtiene los tipos de solicitud para llenar el combo en solicitudes al comite
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getTiposSolComite" hint="Obtiene los tipos de solicitud para llenar el combo en solicitudes al comite">
        <cfscript>
            return DAO.getTiposSolComite();
        </cfscript>
    </cffunction>

    <!---
    * Descripcion: Obtiene las solicitudes al comite y llena la tabla de la vista
    * Fecha:       28 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaComite" hint="Obtiene las solicitudes al comite y llena la tabla de la vista">
        <cfargument name="fkPersona"   type="numeric" required="yes" hint="FK de la persona">
        <cfscript>
            return DAO.getTablaComite(fkPersona);
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Guarda nueva solicitud al comite
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarComite" hint="Guarda nueva solicitud al comite">
        <cfargument name="fkPersona"   type="numeric" required="yes" hint="FK de la persona">
        <cfargument name="fkProceso"   type="numeric" required="yes" hint="FK del proceso">
        <cfargument name="descripcion" type="string"  required="yes" hint="Descripcion de la solicitud">
        <cfargument name="fkTipo"      type="numeric" required="yes" hint="FK del tipo">
        <cfargument name="fkEstado"    type="numeric" required="yes" hint="FK del estado inicial">
        <cfscript>
            var revista = DAO.agregarComite(fkPersona, fkProceso, descripcion, fkTipo, fkEstado);
            return revista;
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Editar solicitud al comite
    * Fecha creacion: 29 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarComite" hint="Editar solicitud al comite">
    	<cfargument name="PkSolicitud" type="numeric" required="yes" hint="PK de la solicitud al comite">
        <cfargument name="fkPersona"   type="numeric" required="yes" hint="FK de la persona">
        <cfargument name="fkProceso"   type="numeric" required="yes" hint="FK del proceso">
        <cfargument name="descripcion" type="string"  required="yes" hint="Descripcion de la solicitud">
        <cfargument name="fkTipo"      type="numeric" required="yes" hint="FK del tipo">
        <cfscript>
            var revista = DAO.editarComite(PkSolicitud, fkPersona, fkProceso, descripcion, fkTipo);
            return revista;
        </cfscript>
    </cffunction>

    <!--- 
    * Descripcion:    Elimina solicitud al comite seleccionada
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="eliminarComite" hint="Elimina solicitud al comite seleccionada">
        <cfargument name="PkSolicitud" type="numeric" required="yes" hint="PK de la solicitud al comite">
        <cfargument name="fkEstado"    type="numeric" required="yes" hint="FK del estado inicial">
        <cfscript>
            return DAO.eliminarComite(PkSolicitud, fkEstado);
        </cfscript>
    </cffunction>

    <!---
    * Descripcion:    Calcula si es tiempo de aplicar al Recurso de inconformidad.
    * Fecha creacion: 17/Enero/2018
    * @author:        Alejandro Tovar
    --->
    <cffunction name="getRecursoIn" hint="Calcula si es tiempo de aplicar al Recurso de inconformidad">
		<cfscript>
			var fecha  = 0;
			var aplica = DAO.comparaFechasRI().FECHAFIN[1];
			
			if (Len(aplica)){
				fecha = aplica;
			}

			return fecha;
		</cfscript>
    </cffunction>

    <!--- 
    *Fecha: Enero de 2018
    *Autor: JLGC
    --->
    <cffunction name="guardaRecursoInconformidad" hint="Realiza guardado y cambio de estado al recurso de inconformidad">
        <cfargument name="PkProducto"               type="numeric" required="yes" hint="PK del Producto">
        <cfargument name="descripcionInconformidad" type="string"  required="yes" hint="Descripcion de la inconformidad">
        <cfscript>
            var inconformidad = DAO.getRegistroInconformidad(PkProducto);
            
            if ( inconformidad.EXISTE == 1 ){
                return DAO.editaRecursoInconformidad(PkProducto, descripcionInconformidad);
            }else {
                return DAO.guardaRecursoInconformidad(PkProducto, application.SIIIP_CTES.TIPOEVALUACION.RI, descripcionInconformidad);
            }
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Enero de 2018
    *Autor: JLGC
    --->
    <cffunction name="eliminaRecursoInconformidad" hint="Realiza el cambio de estado al recurso de inconformidad a cero">
        <cfargument name="PkProducto" type="numeric" required="yes" hint="PK del Producto">
        <cfscript>
            return DAO.eliminaRecursoInconformidad(PkProducto, 0);
        </cfscript>
    </cffunction>

    
	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getClasificacion123" hint="Muestra todos las evaluaciones que se le pueden hacer a un investigador con base en un evaluador">
		<cfargument name="pkPersona"	type="numeric"	hint ="pk del usuario">
		<cfscript>
			var tabla123 = structNew();

			tabla123.tabla1 = DAO.getPlatillaReporte(1, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			tabla123.tabla2 = DAO.getPlatillaReporte(2, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			tabla123.tabla3 = DAO.getPlatillaReporte(3, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			tabla123.tabla4 = DAO.getPlatillaReporte(4, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			tabla123.tabla5 = DAO.getPlatillaReporte(5, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			tabla123.tabla6 = DAO.getPlatillaReporte(6, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			tabla123.tabla7 = DAO.getPlatillaReporte(7, this.getProcesosEDI().getFECHAINIPROC(), this.getProcesosEDI().getFECHAFINPROC());
			
			var tempProductos1 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 1);
			var tempProductos2 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 2);
			var tempProductos3 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 3);
			var tempProductos4 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 4);
			var tempProductos5 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 5);
			var tempProductos6 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 6);
			var tempProductos7 = DAO.getAllProductosEvaluados(pkPersona, this.getProcesosEDI().getPKPROCESO(), 7);

			var tempTabla1 = this.getTabla(tempProductos1, tabla123.tabla1);
			var tempTabla2 = this.getTabla(tempProductos2, tabla123.tabla2);
			var tempTabla3 = this.getTabla(tempProductos3, tabla123.tabla3);
			var tempTabla4 = this.getTabla(tempProductos4, tabla123.tabla4);
			var tempTabla5 = this.getTabla(tempProductos5, tabla123.tabla5);
			var tempTabla6 = this.getTabla(tempProductos6, tabla123.tabla6);
			var tempTabla7 = this.getTabla(tempProductos7, tabla123.tabla7);

			tabla123.tabla1 = tempTabla1.tabla;
			tabla123.tabla2 = tempTabla2.tabla;
			tabla123.tabla3 = tempTabla3.tabla;
			tabla123.tabla4 = tempTabla4.tabla;
			tabla123.tabla5 = tempTabla5.tabla;
			tabla123.tabla6 = tempTabla6.tabla;
			tabla123.tabla7 = tempTabla7.tabla;

			tabla123.totalTabla1 = tempTabla1.total;
			tabla123.totalTabla2 = tempTabla2.total;
			tabla123.totalTabla3 = tempTabla3.total;
			tabla123.totalTabla4 = tempTabla4.total;
			tabla123.totalTabla5 = tempTabla5.total;
			tabla123.totalTabla6 = tempTabla6.total;
			tabla123.totalTabla7 = tempTabla7.total;

			tabla123.totalTabla20por = (tabla123.totalTabla1 + tabla123.totalTabla2 + tabla123.totalTabla3)* .20;
			tabla123.puntajeEfectivo = tabla123.totalTabla20por > tabla123.totalTabla4 ? tempTabla4.total : tabla123.totalTabla20por;
			tabla123.puntajeTotal = tabla123.totalTabla1 + tabla123.totalTabla2 + tabla123.totalTabla3 + tabla123.puntajeEfectivo + tabla123.totalTabla5 + tabla123.totalTabla6 + tabla123.totalTabla7;
			// writeDump(tabla123);abort;
			return tabla123;
		</cfscript>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getTabla" hint="Muestra todos las evaluaciones que se le pueden hacer a un investigador con base en un evaluador">
		<cfargument name="tempProductos"	type="query"	hint ="pk del usuario">
		<cfargument name="tabla"			type="query"	hint ="pk del usuario">
		<cfscript>
			var resultado	= structNew();
			var total 		= 0;
			var allProductos	= [];
			for (var i in tempProductos){
				var tempAllProductos	= DAO.getpuntajeUltimosProductos(i.PRODUCTOEVALUADO);
				tempAllProductos.anio	= daoCVU.getFechaByTipo(tempAllProductos.fila).anio[1];
				arrayAppend(allProductos, tempAllProductos);
			}

			for(var x=1; x lte tabla.recordcount; x++)
				for(var y=1; y lte arrayLen(allProductos); y++)
					if(tabla.ACTIVIDAD[x] EQ allProductos[y].CLASIFICACION)
						for(var z=2; z lte arrayLen(tabla.getColumnNames())-1; z++)
							if(replace(tabla.getColumnNames()[z], 'ANIO', '') EQ allProductos[y].ANIO){
								tabla[tabla.getColumnNames()[z]][x] = tabla[tabla.getColumnNames()[z]][x] + allProductos[y].PUNTAJE;
								tabla.PUNTOS[x] = tabla.PUNTOS[x] + tabla[tabla.getColumnNames()[z]][x];
								total = total + tabla.PUNTOS[x];
							}
			resultado.tabla = tabla;
			resultado.total	= total;
			return resultado;
		</cfscript>
	</cffunction>

	<!--- 
    *Fecha: Enero de 2018
    *Autor: JLGC
    --->
    <cffunction name="guardaNarracion" hint="Realiza guardado de la narración de los hechos de la Inconformidad">
        <cfargument name="PkPersona" type="numeric" required="yes" hint="PK de la Persona">
        <cfargument name="PkProceso" type="numeric" required="yes" hint="PK del proceso">
        <cfargument name="hechos"    type="string"  required="yes" hint="Descripcion de los hechos">
        <cfscript>
            return DAO.guardaNarracion(PkPersona, PkProceso, hechos);
        </cfscript>
    </cffunction>

    <!--- 
    *Fecha: Enero de 2018
    *Autor: JLGC
    --->
    <cffunction name="getNarracion" hint="Muestra el contenido de la narración de los hechos de la Inconformidad">
        <cfargument name="PkPersona" type="numeric" required="yes" hint="PK de la Persona">
        <cfargument name="PkProceso" type="numeric" required="yes" hint="PK del proceso">
        <cfscript>
            return DAO.getNarracion(PkPersona, PkProceso);
        </cfscript>
    </cffunction>

    <!---
	*Fecha:	Febrero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getObservacionCA" hint="Obtiene la observacion del CA sobre la solicitud">
		<cfargument name="pkPersona" hint="Pk de la persona">		
		<cfscript>
			var pkProceso = this.getProcesosEDI().getPKPROCESO();			
			return DAO.getObservacionCA(pkPersona,pkProceso);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getEdoAspiranteProceso" hint="obtiene el estado y ruta del aspiranteproceso">
		<cfargument name="pkPersona" type="numeric"	hint ="pk de la persona">
		<cfargument name="pkProceso" type="numeric"	hint ="pk del proceso">
		<cfscript>
			var rol = session.cbstorage.usuario.ROL;
			var aspirante = DAO.getEdoAspiranteProceso(pkPersona, pkProceso);
			return cnMes.getQueryAcciones(application.SIIIP_CTES.PROCEDIMIENTO.SOLI_EDI, aspirante, rol);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getBecaByAspiranteProceso" hint="obtiene la beca que se asigno a la pesona">
		<cfargument name="pkPersona" type="numeric"	hint ="pk del aspirante">
		<cfargument name="pkProceso" type="numeric"	hint ="pk del proceso">
		<cfargument name="tipoEval"  type="numeric"	hint ="pk del tipo de evaluacion">
		<cfscript>
			return DAO.getBecaByAspiranteProceso(pkPersona, pkProceso, tipoEval);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getTablaInvestigadoresNomina" hint="obtiene la nomina">
		<cfargument name="mayorCero" 	 type="numeric" hint="Nivel mayor a cero">
		<cfargument name="clave" 		 type="any" 	hint="clave">
		<cfargument name="cveGracia" 	 type="any" 	hint="clave del año de gracia">
		<cfargument name="cveResidencia" type="any" 	hint="clave de la residencia">
		<cfargument name="cveOficio"  	 type="any" 	hint="clave del oficio">
		<cfargument name="pkProceso" 	 type="numeric" hint="pk del proceso">
		<cfargument name="solAt" 		 type="boolean" hint="solicitud atendida">
		<cfargument name="solRI" 		 type="boolean" hint="solicito RI">
		<cfscript>
			var cero = mayorCero EQ 1 ? true : false;
			var arrayNomCA = [];
			var arrayNomRI = [];

			var listadoNomina = ToString(arrayToList(cnUtils.queryToArraySinStruct(DAO.getInvestigadoresNomina(pkProceso)), ','));

			if (listadoNomina EQ ''){
				listadoNomina = '0';
			}

			var qryNomCA = DAO.getTablaInvestigadoresNomina(cero, application.SIIIP_CTES.TIPOEVALUACION.CA, cveOficio, pkProceso, listadoNomina, solAT, solRI);
			for (var i = 1; i lte qryNomCA.recordcount; i++){
				nominaCA = populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_Nomina"),qryNomCA,i);
				arrayAppend(arrayNomCA, nominaCA);
			}

			var qryNomRI = DAO.getTablaInvestigadoresNomina(cero, application.SIIIP_CTES.TIPOEVALUACION.RI, cveOficio, pkProceso, listadoNomina, solAT, solRI);
			for (var x = 1; x lte qryNomRI.recordcount; x++){
				var nominaRI = populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_Nomina"),qryNomRI,x);
				arrayAppend(arrayNomRI, nominaRI);
			}

            /*********************************************************************************************************/

			if (ArrayLen(arrayNomRI) GT 0){
				for (objetoRI in arrayNomRI){
					for (objetoCA in arrayNomCA){
						if (IsNumeric(objetoRI.getRESIDENCIA()) OR IsNumeric(objetoRI.getANIOGRACIA())){
							pkPersona  = objetoRI.getPK_PERSONA();
							residencia = objetoRI.getRESIDENCIA();
							gracia 	   = objetoRI.getANIOGRACIA();

							if (objetoCA.getPK_PERSONA() EQ objetoRI.getPK_PERSONA()){
								objetoCA.setRESIDENCIA(residencia);
								objetoCA.setANIOGRACIA(gracia);
								objetoCA.setClaveNormal(cveGracia, cveResidencia, clave, objetoRI.getNIVEL());
								objetoCA.setRfcCorto(objetoRI.getRFC());
							}
						}else {
							objetoCA.setClaveNormal(cveGracia, cveResidencia, clave, objetoCA.getNIVEL());
							objetoCA.setRfcCorto(objetoCA.getRFC());
						}
					}
				}
			}else {
				for (objetoCA in arrayNomCA){
					objetoCA.setClaveNormal(cveGracia, cveResidencia, clave, objetoCA.getNIVEL());
					objetoCA.setRfcCorto(objetoCA.getRFC());
				}
			}

			return arrayNomCA;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaNomina" hint="Guarda aspirantes en la nomina">
		<cfargument name="clave" 		 type="any"    hint="clave">
		<cfargument name="cveGracia" 	 type="any"    hint="clave del año de gracia">
		<cfargument name="cveResidencia" type="any"    hint="clave de la residencia">
		<cfargument name="cveOficio"  	 type="any"    hint="clave del oficio">
		<cfargument name="aspirantes"  	 type="string" hint="pk aspirante proceso">
		<cfscript>
			var arrayAspirantes = deserializeJSON(aspirantes);
			var pkClaves 		= DAO.guardaClaves(clave, cveGracia ,cveResidencia , cveOficio);

			for (aspirante in arrayAspirantes){
				aspNomina = DAO.guardaNomina(aspirante.pkAsp, aspirante.nivel, aspirante.clave, aspirante.pago, aspirante.oficio, aspirante.rfc, pkClaves);
			}

			return aspNomina;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getEnviadosNomina" hint="Muestra listado de investigadores enviados a nomina">
		<cfargument name="pkProceso" type="numeric"	hint="pk del proceso">
		<cfargument name="oficio"    type="any"		hint="oficio">
		<cfscript>
			return DAO.getEnviadosNomina(pkProceso, oficio);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="cambiaEstadoNomina" hint="Cambia el estado de la nomina por aspirante">
		<cfargument name="pkAspirante" type="numeric" hint="pk del asprante proceso">
		<cfscript>
			return DAO.cambiaEstadoNomina(pkAspirante);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getOficios" hint="Obtiene los oficios capturados en el proceso actual">
		<cfargument name="pkProceso" type="numeric"	hint="pk del proceso">
		<cfscript>
			return DAO.getOficios(pkProceso);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getProcesosEDISeleccion" hint="Obtiene el proceso de evaluacion de EDI">
		<cfargument name="pkProceso" hint="pk del proceso seleccionado">
		<cfscript>
			var salida = cache.get("proceso_sel");
			if(isNull(salida)){
			 	var listaprocesos = DAO.obtenerProcesoSeleccionado(pkProceso);
				var proceso = populator.populateFromQuery(wirebox.getInstance("EDI/solicitud/B_ProcesoEDI"),listaprocesos,1);
			    cache.set("proceso_sel", proceso, 120, 120);
			    return proceso;
			} else
				return salida;
		</cfscript>
	</cffunction>
	
	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="getaspiranteProcesoSeleccionado" hint="Obtiene los folios de los aspirantes seleccionados">
		<cfargument name="consulta" hint="investigadores seleccionado">
		<cfscript>
			var dato = [];
			for(invt in consulta){
				folio = getaspiranteProceso(invt.PK_PERSONA, invt.PK_MOVIMIENTO);
				arrayAppend(dato, folio);
			}
			return dato;
		</cfscript>
	</cffunction>

	<!---
	*Fecha: Marzo 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getNombrePersonaSeleccion" hint="obtiene los nombres de los investigadores seleccionados">
		<cfargument name="consulta" hint="consulta seleccionada">
		<cfscript>
			dato = [];
			for(invt in consulta){
				arrayAppend(dato, invt.NOMBRE);
			}
			return dato;
		</cfscript>
	</cffunction>
	
	<!---
	*Fecha: Marzo 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getDatosURseleccion" hint="obtiene las ur relacionadas">
		<cfargument name="consulta" hint="consulta seleccionada">
		<cfscript>
			dato = [];
			for(invt in consulta){
				ur = getDatosUR(invt.PK_UR).nombre[1];
				arrayAppend(dato, ur);
			}
			return dato;
		</cfscript>
	</cffunction>
	
	<!---
	*Fecha: Marzo 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getObservacionCAseleccion" hint="obtencion de las observaciones">
		<cfargument name="consulta" hint="consulta seleccionada">
		<cfscript>
			dato = [];
			for(invt in consulta){
				observacion = getObservacionCA(invt.PK_PERSONA);
				arrayAppend(dato, observacion);
			}
			return dato;
		</cfscript>
	</cffunction>


</cfcomponent>
