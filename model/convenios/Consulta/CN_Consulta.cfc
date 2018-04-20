<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Componente de Negocio para el modulo de convenios/consulta
* ================================
---->
<cfcomponent>
	<cfproperty name="dao"          inject="convenios.Consulta.DAO_Consulta">
	<cfproperty name="cnMes"        inject="utils.maquinaEstados.CN_maquinaEstados">
	<cfproperty name="cnCom"        inject="adminCSII.comentarios.CN_comentarios">
	<cfproperty name="cnArchivos"   inject="adminCSII.ftp.CN_Archivo">

	<!---
	* Descripcion:    Obtiene los convenios y llena la tabla de la vista
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkEstado, PK del Estado 
	*                 pkClasif, PK de la clasificacion
	*                 pkUR, PK de la UR  
	--->
	<cffunction name="getTablaConvenios" access="public" returntype="query" hint="Obtiene los convenios y llena la tabla de la vista">
		<cfargument name="tipo"      type="numeric" required="true" hint="Tipo de convenio"> 
		<cfargument name="numEstado" type="numeric" required="true" hint="Numero del Estado"> 
		<cfargument name="pkClasif"  type="string"  required="true" hint="PK de la clasificacion"> 
		<cfargument name="pkUR"      type="string"  required="true" hint="PK de la UR"> 
		<cfscript>
			var convenios = dao.getTablaConvenios(tipo, numEstado, pkClasif, pkUR);
			return cnMes.getQueryAcciones(application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS, convenios, Session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene los usuarios para enviar comentario.
	--->
	<cffunction name="getUsuComentario" hint="Usuarios que pueden recibir un comentario">
		<cfscript>
			return cnCom.getUsuComentario();
		</cfscript>
	</cffunction>


	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene asuntos de tipo de comentario.
	--->
	<cffunction name="asuntoComentario" hint="obtiene el asunto del comentario">
		<cfargument name="pkTipoComent" type="numeric" required="yes" hint="pk tipo de comentario">
		<cfscript>
			return cnCom.asuntoComentario(pkTipoComent);
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene y ejcuta las pos-operaciones.
	--->
	<cffunction name="cambiarEstadoConvenio" hint="Cambia el estado de un convenio">
		<cfargument name="pkRegistro"    type="numeric" required="yes" hint="Pk del registro que se va a modificar">
		<cfargument name="accion"        type="string"  required="yes" hint="Pk de la acción">
		<cfargument name="asunto"        type="string"  required="no"  hint="asunto">
		<cfargument name="comentario"    type="string"  required="no"  hint="comentario">
		<cfargument name="prioridad"     type="numeric" required="yes" hint="prioridad del comentario">
		<cfargument name="destinatarios" type="string"  required="yes" hint="arreglo de destinatarios">
		<cfargument name="tipoComent"    type="numeric" required="yes" hint="Tipo de comentario">
		<cfscript>

			respuesta = StructNew();
			resPreoperacion   = StructNew();
			postPreoperacion  = StructNew();
			respuesta.exito   = true;
			respuesta.mensaje = '';
			respuesta.comentario = false;
			
			var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS#;
			var ROL = session.cbstorage.usuario.ROL;

			//OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
			estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
			pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, ROL,estadoactual.ESTADO[1]);

			//GENERA EL NUMERO DE REGISTRO DE LA SIP CUANDO VALIDA EL SECRETARIO DE LA SIP
			if(ROL EQ application.SIIIP_CTES.ROLES.SECRETARIOIP AND accion EQ "busqueda.validar"){
				var registroSIP = this.generaRegistroSIP(arguments.pkRegistro);
			}

			//OBTENER PRE-OPERACIONES CORRESPONDIENTES A UN EDOACCION DE LA TABLA CESROPERACIONACCION
			//EJECUTAR LAS PRE-OPERACIONES (SOLO VALIDACIONES Y CONSULTAS; SE RECOMIENDAN MODIFICACIONES EN POS-OPERACIONES)
			resPreoperacion = this.ejecutaPreOperaciones(pkEdoAccion.EDOACC_PK[1]);

			//SI SE EJECUTARON CORRECTAMENTE LAS PRE-OPERACIONES, SE CAMBIA EL ESTADO DEL REGISTRO Y SE EJECUTAN LAS POS-OPERACIONES
			if (resPreoperacion.exito){
				//CAMBIO DE ESTADO EN LA TABLA A MODIFICAR
				registroBitacora = cnMes.cambiarEstado(pkRegistro, accion, ROL, PROCEDIMIENTO, pkEdoAccion.NOMBRE_ACCION[1], pkEdoAccion.ICONO_ACCION[1]);

				//VERIFICAR SI SE REGISTRO EL CAMBIO (PUDO NO COINCIDIR EL ESTADO ACTUAL CON LA ACCION EJECUTADA)
				if (registroBitacora.fallo){
					//obtiene el estado actual del registro y lo muestra en el mensaje de salida.
					respuesta.exito = false;
					respuesta.fallo = true;
					respuesta.mensaje = estadoactual.NOM_EDO[1];
					return respuesta;
				}

				//OBTENER POS-OPERACIONES DE LA ACCION
				postPreoperacion  = this.ejecutaPostOperaciones(pkEdoAccion.EDOACC_PK[1]);
				respuesta.exito   = postPreoperacion.exito;
				respuesta.mensaje = postPreoperacion.mensaje;

				//INDICA SI EL CAMBIO DE ESTADO FUE UN RETROCESO
				respuesta.retroceso = registroBitacora.RETROCESO;
				respuesta.edoDest = registroBitacora.edoOrigen;

				//ACTUALIZA LA BITÁCORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
				if (respuesta.mensaje NEQ ''){
					cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
				}

				//REGISTRA EL COMENTARIO EN LA TABLA COMTCOMENTARIO
				if (comentario NEQ ''){
					var destin = deserializeJSON(destinatarios);
					cnCom.registraComentario(asunto, comentario, prioridad, registroBitacora.edoOrigen, pkRegistro, destin, tipoComent);
					respuesta.comentario = true;
				}

			} else {
				respuesta = resPreoperacion;
			}

			return respuesta;
		</cfscript>
	</cffunction>


	<!---
	* Descripcion:    Consulta el numero de archivos requeridos ya cargados
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	<cffunction name="archivosRequeridosCargados" hint="Consulta el numero de archivos requeridos ya cargados">
		<cfargument name="pkRegistro"   type="numeric" required="true" hint="PK del convenio">
		<cfargument name="tipoConvenio" type="numeric" required="true" hint="tipo del convenio">
		<cfscript>
			var requeridos = 0;
			respuesta = StructNew();

			if (tipoConvenio == 1){          //FE
				requeridos  = cnArchivos.archivosRequeridosCargados(pkRegistro, tipoConvenio);
				respuesta.exito = requeridos.ARCHIVOSCARGADOS == 3 ? true : false;

			} else if (tipoConvenio == 2){   //FA
				requeridos  = cnArchivos.archivosRequeridosCargados(pkRegistro, tipoConvenio);
				respuesta.exito = requeridos.ARCHIVOSCARGADOS == 9 ? true : false;

			} else if (tipoConvenio == 3){   //UC
				requeridos  = cnArchivos.archivosRequeridosCargados(pkRegistro, tipoConvenio);
				respuesta.exito = requeridos.ARCHIVOSCARGADOS == 3 ? true : false;
			}

			return respuesta;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Consulta si tiene un responsable asignado
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	 <cffunction name="responsableAsignado" hint="Consulta si tiene un responsable asignado">
		<cfargument name="pkRegistro"   type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			var responsable = dao.responsableAsignado(pkRegistro);
			respuesta = StructNew();
			if (responsable.RESPONSABLE > 0){
				respuesta.exito = true; 
			} else {
				respuesta.exito = false; 
			}
			return respuesta;
		</cfscript>
	</cffunction>


	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene y ejcuta las pos-operaciones.
	--->
	<cffunction name="ejecutaPostOperaciones" hint="Ejecuta pos-operaciones">
		<cfargument name="pkEdoAccion" type="any" required="yes" hint="Pk de la tabla CESRESTADOACCION">
		<cfscript>
			respuesta = StructNew();
			respuesta.exito = true;
			respuesta.mensaje = '';
			return respuesta;
		</cfscript>
	</cffunction>


	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene y ejcuta las pre-operaciones.
	--->
	<cffunction name="ejecutaPreOperaciones" hint="Ejecuta pre-operaciones">
		<cfargument name="pkEdoAccion" type="any" required="yes" hint="Pk de la tabla CESRESTADOACCION">
		<cfscript>
			respuesta = StructNew();
			respuesta.exito = true;
			respuesta.mensaje = '';
			return respuesta;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	--->
	<cffunction name="getVistaFEbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			var convenios = dao.getVistaFEbyPKConvenio(pkConvenio);
			return cnMes.getQueryAcciones(application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS, convenios, Session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	--->
	<cffunction name="getVistaFAbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			var convenios = dao.getVistaFAbyPKConvenio(pkConvenio);
			return cnMes.getQueryAcciones(application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS, convenios, Session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	--->
	<cffunction name="getVistaUCbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			var convenios = dao.getVistaUCbyPKConvenio(pkConvenio);
			return cnMes.getQueryAcciones(application.SIIIP_CTES.PROCEDIMIENTO.CONVENIOS, convenios, Session.cbstorage.usuario.ROL);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene el empleado por el numero de empleado
	* Fecha creacion: 06 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         numEmpleado, Numero de empleado
	--->
	<cffunction name="obtenerEmpleadoByNumEmpleado" access="public" returntype="query" hint="Obtiene el empleado por el numero de empleado">
		<cfargument name="numEmpleado" type="string" required="yes" hint="Numero de empleado">
		<cfscript>
			var empleado = dao.obtenerEmpleadoRegistrado(numEmpleado);
			if (empleado.RecordCount > 0){
				return empleado;
			}else{
				return dao.obtenerEmpleadoByNumEmpleado(numEmpleado);
			}			
		</cfscript>
	</cffunction>
		
	<!---
	* Descripcion:    Obtiene clasificacion UR
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerURClasificacion" access="remote" returntype="query" hint="Obtiene clasificacion UR">
		<cfscript>
			return dao.obtenerURClasificacion();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene UR's por clasificacion
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkURClasificacion, PK de clasificacion UR  
	--->
	<cffunction name="obtenerURbyClasificacion" access="remote" returntype="query" hint="Obtiene UR's por clasificacion">
		<cfargument name="pkURClasificacion" type="string" required="yes" hint="PK de clasificacion UR">
		<cfscript>
			return dao.obtenerURbyClasificacion(pkURClasificacion);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene lista de estados
	* Fecha creacion: 12 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerEstados" access="remote" returntype="query" hint="Obtiene lista de estados">
		<cfargument name="tipoConvenio" type="numeric" required="yes" hint="Tipo del convenio"> 
		<cfscript>
			if (tipoConvenio == 3) { rutaConvenio = 6; }   // Firma electronica y Firma autografa
			else { rutaConvenio = 5; }                     // UC-Mexus
			return dao.obtenerEstados(rutaConvenio);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Edita un convenio existente de la tabla CONINV.CINVTCONVENIO
	* Fecha creacion: 25 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarConvenio" access="public" returntype="numeric" hint="Edita un convenio existente de la tabla CONINV.CINVTCONVENIO">
		<cfargument name="PK"            type="numeric" required="yes" hint="Campo: TCON_PK_CONVENIO">
		<cfargument name="FKTIPO"        type="numeric" required="yes" hint="Campo: BTIP_FK1_TIPO">
		<cfargument name="FKINSTITUCION" type="numeric" required="yes" hint="Campo: TINS_FK3_INSTITUCION">
		<cfargument name="NOMBRE"        type="string"  required="yes" hint="Campo: TCON_NOMBRE">
		<cfargument name="DESCRIPCION"   type="string"  required="yes" hint="Campo: TCON_DESCRIPCION">
		<cfargument name="FECHAVIGINI"   type="string"  required="yes" hint="Campo: TCON_FECHA_INICIO">
		<cfargument name="FECHAVIGFIN"   type="string"  required="yes" hint="Campo: TCON_FECHA_FIN">
		<cfargument name="MONTOLIQUIDO"  type="numeric" required="yes" hint="Campo: TCON_MONTO_EFECTIVO">
		<cfargument name="MONTOESPECIE"  type="numeric" required="yes" hint="Campo: TCON_MONTO_ESPECIE">
		<cfargument name="MONTOCONACYT"  type="numeric" required="yes" hint="Campo: TCON_MONTO_CONACYT">
		<cfargument name="MONTOTOTAL"    type="numeric" required="yes" hint="Campo: TCON_MONTO_TOTAL">
		<cfscript>
			return dao.editarConvenio(PK, FKTIPO, FKINSTITUCION, UCase(NOMBRE), UCase(DESCRIPCION), FECHAVIGINI, FECHAVIGFIN, MONTOLIQUIDO, MONTOESPECIE, MONTOCONACYT, MONTOTOTAL);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:       Edita un responsable existente de la table CONINV.CINVTRESPONSABLE
	* Fecha creacion:     30 de mayo de 2017
	* Fecha modificacion: 06 de junio de 2017
	*                     Se incluye a la edicion el NOMBRE, PATERNO y MATERNO   
	* @author:            Jose Luis Granados Chavez
	--->
	<cffunction name="editarResponsable" access="public" returntype="numeric" hint="Edita un responsable existente de la table CONINV.CINVTRESPONSABLE">
		<cfargument name="PK"        type="numeric" required="yes" hint="Campo: TRES_PK_RESPONSABLE">
		<cfargument name="NOMBRE"    type="string"  required="yes" hint="Campo: TRESP_NOMBRE">
		<cfargument name="PATERNO"   type="string"  required="yes" hint="Campo: TRES_AP_PATERNO">
		<cfargument name="MATERNO"   type="string"  required="yes" hint="Campo: TRES_AP_MATERNO">
		<cfargument name="EXTENSION" type="numeric" required="yes" hint="Campo: TRES_EXTENSION">
		<cfscript>
			return dao.editarResponsable(PK, NOMBRE, PATERNO, MATERNO, EXTENSION);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Edita el responsable existente en el convenio de la tabla CONINV.CINVTCONVENIO
	* Fecha creacion: 30 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarConvenioConResponsable" access="public" returntype="numeric" hint="Edita el responsable existente en el convenio de la tabla CONINV.CINVTCONVENIO">
		<cfargument name="PK"            type="numeric" required="yes" hint="Campo: TRES_PK_RESPONSABLE">
		<cfargument name="FKRESPONSABLE" type="numeric" required="yes" hint="Campo: TEMP_FK5_NUM_EMPLEADO">
		<cfscript>
			return dao.editarConvenioConResponsable(PK, FKRESPONSABLE);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	<cffunction name="getEditarFEbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 1: firma electronica por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			return dao.getEditarFEbyPKConvenio(pkConvenio);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	<cffunction name="getEditarFAbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 2: firma autografa por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			return dao.getEditarFAbyPKConvenio(pkConvenio);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio
	* Fecha creacion: Junio 2017
	* @author:        SGS
	--->
	<cffunction name="getEditarUCbyPKConvenio" access="public" returntype="query" hint="Obtiene la informacion del convenio tipo 3: UC-Mexus por PK de convenio">
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			return dao.getEditarUCbyPKConvenio(pkConvenio);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene los registros de Carreras
	* Fecha creacion: Enero 18,2018
	* @author:        Edgar Allan Soriano Najera
	--->
	 <cffunction name="getCarreras" hint="Obtiene los registros de carreras">
		<cfscript>
			return dao.getCarreras();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene las dependencias del Instituto
	* Fecha creacion: Enero 22,2018
	* @author:        Edgar Allan Soriano Najera
	--->
	 <cffunction name="getDependencias" hint="Obtiene las dependencias del Instituto">
		<cfscript>
			return dao.getDependencias();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Genera el folio de registro SIP
	* Fecha creacion: Febrero 08,2018
	* @author:        Edgar Allan Soriano Najera
	--->
	 <cffunction name="generaRegistroSIP" hint="Genera el folio de registro SIP">	 	
		<cfargument name="pkConvenio" type="numeric" required="true" hint="PK del convenio">
		<cfscript>
			return dao.generaRegistroSIP(pkConvenio);
		</cfscript>
	</cffunction>

</cfcomponent>