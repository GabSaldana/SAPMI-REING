<!---
============================================================================================
* IPN - CSII
* Sistema: EVALUACION
* Modulo: Administración de periodos
* Fecha: Enero de 2017
* Descripcion:
* Autor: SGS
============================================================================================
--->

<cfcomponent>
    <cfproperty name="DAO" inject="formatosTrimestrales.admonPeriodos.DAO_periodos">
    <cfproperty name="cnMEs" inject="utils.maquinaEstados.CN_maquinaEstados">

    <cffunction name="obtenerPeriodos" hint="Obtiene los periodos para llenar el formulario de busqueda inicial">
		<cfscript>
			return DAO.obtenerPeriodos();
		</cfscript>
	</cffunction>

	<cffunction name="obtenerAnios" hint="Obtiene los años que ya fueron usados para crear trimestres">
        <cfscript>
            return DAO.obtenerAnios();
        </cfscript>
    </cffunction>

    <cffunction name="agregarPeriodo" hint="Agrega un periodo nuevo">
        <cfargument name="anio" type="numeric" required="yes" hint="Año del nuevo periodo">
        <cfscript>
            trim1 = "PRIMER TRIMESTRE "&anio;
            trim2 = "SEGUNDO TRIMESTRE "&anio;
            trim3 = "TERCER TRIMESTRE "&anio;
            trim4 = "CUARTO TRIMESTRE "&anio;
            return DAO.agregarPeriodo(anio, trim1, trim2, trim3, trim4);
        </cfscript>
    </cffunction>

    <cffunction name="obtenerFormatos" hint="Obtiene los formatos de un periodo">
        <cfargument name="periodo" type="numeric" required="yes" hint="pk del periodo">
        <cfscript>
            var respuesta = structNew();
            
            var UR = '';
			var pkUsuario = '';
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'configFT.verTodos')){
				pkUsuario = session.cbstorage.usuario.PK;
			}
			/*EN CASO DE NO TENER EL PRIVILEGIO PARA VER TODOS LOS REPORTES SE ENVIA EL VALOR DE LA UR DE LA SESSION*/
			if(NOT arraycontains(session.cbstorage.grant,'CapturaFT.verTodasUR')){
				UR = session.cbstorage.usuario.UR;
			}
            
            var formatos = DAO.obtenerFormatos(periodo,UR,pkUsuario);
            var formatosNL = DAO.formatosNoLiberados(periodo,UR,pkUsuario);
            var formatosAcciones = cnMes.getQueryAcciones(#application.SIIIP_CTES.PROCEDIMIENTO.CAPTURA_FORMATOS#, formatos, #Session.cbstorage.usuario.rol#);
            respuesta.formatosNL = formatosNL;
            respuesta.formatosAcciones = formatosAcciones;
            return respuesta;
        </cfscript>
    </cffunction>

    <cffunction name="crearReporte" hint="Crea un repote para un periodo">
        <cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="periodoNuevo" type="numeric" required="yes" hint="pk del periodo nuevo">
        <cfscript>
            var procedimiento = #application.SIIIP_CTES.PROCEDIMIENTO.CAPTURA_FORMATOS#;
            var ruta = #application.SIIIP_CTES.RUTA.CAPTURA_FORMATOS.R_GRAL#;
            var estado = dao.primerEdoRuta(ruta).ESTADO[1];
            
            var periodoViejo = DAO.obtenerPeriodoAnterior(formato);
            if (periodoViejo.PKPERIODOANTERIOR == ''){
                periodoViejo.PKPERIODOANTERIOR = 0;
            }
            var pkReporte = DAO.crearReporte(formato, periodoNuevo, periodoViejo.PKPERIODOANTERIOR, estado, ruta);
            
            /*cuando el reporte ya  existe cambia el estado*/
            if (pkReporte eq -1){
            	pkreporte = DAO.actualizarEdoFormato(formato, periodoNuevo,estado);
            }
            return DAO.registrarCreacionReporte(procedimiento, estado, pkReporte, #Session.cbstorage.usuario.PK#);
        </cfscript>
    </cffunction>

    <!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
    * Descripcion : Particularizacion del cambio de estado a la captura de reportes
------------------------------------------------ 
    Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="cambiarEstadoPer" hint="Se cambia el estado del registro en cuestión a partir de la accion que se realiza.">
        <cfargument name="pkRegistro"     type="numeric" required="yes" hint="Pk del registro que se va a modificar">
        <cfargument name="accion"         type="string"  required="yes" hint="Pk de la acción">
        <cfargument name="nombreFormato"  type="string"  required="yes" hint="Nombre del formato">
        <cfargument name="periodoFormato" type="string"  required="yes" hint="Periodo del formato">
        <cfargument name="claveFormato"   type="string"  required="yes" hint="Clave del formato">
        <cfscript>

            respuesta = StructNew();
            resPreoperacion   = StructNew();
            postPreoperacion  = StructNew();
            respuesta.exito   = true;
            respuesta.mensaje = '';
            
            var PROCEDIMIENTO = #application.SIIIP_CTES.PROCEDIMIENTO.CAPTURA_FORMATOS#;
            var ROL = session.cbstorage.usuario.ROL;

            //OBTENER PK DEL REGISTRO DE LA TABLA CESRESTADOACCION
            estadoactual = cnMes.getEdoActual(PROCEDIMIENTO, pkRegistro);
            pkEdoAccion = cnMes.getEdoSigBypkAccion(accion, ROL,estadoactual.ESTADO[1]);

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
                /* if (respuesta.retroceso == true){
                    this.notificacionRechazo(pkRegistro, nombreFormato, periodoFormato, claveFormato);
                } else{
                    var pkRolSiguiente = cnUtils.queryToArray(cnMes.getRolSigByClaveAccion(accion, estadoactual.ESTADO[1]));
                    for (var i = 1; i <= ArrayLen(pkRolSiguiente); i++){
                        this.notificacionValidacion(pkRolSiguiente[i].PK_ROL, nombreFormato, periodoFormato, claveFormato);
                    }
                } */

                //ACTUALIZA LA BITÁCORA EN CASO DE ERROR AL EJECUTAR POS-OPERACIONES.
                if (respuesta.mensaje NEQ ''){
                    cnMes.mensajeBitacora(registroBitacora.pkBitacora, respuesta.mensaje);
                }

            }else {
                respuesta = resPreoperacion;
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

</cfcomponent>