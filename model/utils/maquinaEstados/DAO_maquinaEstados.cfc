<!---
* =============================================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: máquina de estados
* Fecha: octubre de 2016
* Descripcion: acceso a datos de la máquina de estados
* =============================================================================================================
--->

<cfcomponent>

    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los datos de la tabla a modificar.
    --->
    <cffunction name="obtenerTablaModificacion" hint="Obtiene los datos de la tabla a modificar.">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="Clave del procedimiento que sigue el registro a modificar.">
        <cfquery name="qTablaModificacion" datasource="DS_GRAL">
            SELECT PROC.CPR_TABLA_MODIFICACION       TABLA,
                   PROC.CPR_CAMPO_MODIFICACION       CAMPO_ESTADO,
                   PROC.CPR_PK_REGISTRO_MODIFICACION CAMPO_PK,
				   PROC.CPR_ESQUEMA					 ESQUEMA
            FROM   CESCPROCEDIMIENTO PROC
            WHERE  PROC.CPR_PK_PROCEDIMIENTO = <cfqueryparam value="#arguments.pkProcedimiento#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qTablaModificacion>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el estado actual del registro, apartir de una consulta dinamica.
    --->
    <cffunction name="obtenerEstadoActual" hint="Obtiene el estado actual del registro.">
        <cfargument name="pkProcedimiento" type="numeric" required="yes" hint="Clave del procedimiento que sigue el registro a modificar.">     
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="Clave del registro que se va a modificar.">

        <cfset qTablaModificacion = this.obtenerTablaModificacion(pkProcedimiento)>
        <cfset tabla       = qTablaModificacion.TABLA[1]>
        <cfset campoEstado = qTablaModificacion.CAMPO_ESTADO[1]>
        <cfset campoPK     = qTablaModificacion.CAMPO_PK[1]>
        <cfset esquema     = qTablaModificacion.ESQUEMA[1]>
        <cfquery name="qEstadoActual" datasource="DS_#esquema#">
            SELECT  #campoEstado# ESTADO,
	                EDO.CER_NUMERO_ESTADO NUM_EDO,
	                EDO.CER_FK_RUTA AS RUTA
              FROM  #tabla# TEMP,
                    GRAL.CESCESTADO EDO
             WHERE  TEMP.#campoEstado# = EDO.CER_PK_ESTADO
                  	AND #campoPK# = #pkRegistro#
        </cfquery>
        <cfreturn qEstadoActual>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene las acciones disponibles en dicho procedimiento.
    --->
    <cffunction name="getAllAcciones" hint="Obtiene los datos de la tabla a modificar.Trae lod datos de las acciones en su estado actual
    del rol X para una ruta perteneciente a un procedimiento X.">
        <cfargument name="procedimiento" type="numeric" required="yes" hint="pk del procedimiento">
        <cfargument name="rol"           type="numeric" required="yes" hint="pk del rol">
        <cfargument name="getEliminados" type="boolean" required="false" default="false" hint="pk del rol">
        <cfquery name="qResult" datasource="DS_GRAL">
            SELECT  TABACCIONES.PKACCIONES,
                    TABACCIONES.ACCIONES,
                    TABACCIONES.ICONOS,
                    TABACCIONES.ACCIONESCVE,
                    CER2.CER_NOMBRE         NOMEDO,
                    CER2.CER_NUMERO_ESTADO  NUMEDO,
                    CER2.CER_DESCRIPCION,
                    CER2.CER_PK_ESTADO      EDOACT,
                    RPR.RPR_DESCRIPCION     RUTA_DESC,
                    RPR.RPR_PK_RUTA         RUTA_PK
            FROM (
                    SELECT 
                        LISTAGG(TAC.TAC_PK_ACCION,'$')  WITHIN GROUP (ORDER BY TAC_ACCION_NOMBRE) PKACCIONES,
                        LISTAGG(TAC.TAC_ACCION_NOMBRE,'$')  WITHIN GROUP (ORDER BY TAC_ACCION_NOMBRE) ACCIONES,
                        LISTAGG(TAC.TAC_ICONO,'$')  WITHIN GROUP (ORDER BY TAC_ACCION_NOMBRE) ICONOS,
                        LISTAGG(TAC.TAC_ACCION_CLAVE,'$')  WITHIN GROUP (ORDER BY TAC_ACCION_NOMBRE) ACCIONESCVE,
                        REA.REA_FK_ESTADO_RUTA EDOACT
                        
                        FROM GRAL.CESRESTADOACCION  REA,
                             GRAL.USRRACCIONROL     RAR,
                             GRAL.USRTACCION        TAC
                        WHERE
                            REA.REA_FK_ACCION_ROL = RAR.RAR_PK_ACCIONROL
                            <cfif rol>
                                AND RAR.RAR_FK_ROL = #rol#
                            </cfif>
                            AND RAR.RAR_FK_ACCION = TAC.TAC_PK_ACCION
							AND RAR.RAR_FK_ESTADO > 0
                   			AND REA.REA_FK_ESTADO > 0
                    GROUP BY REA.REA_FK_ESTADO_RUTA
                 )                TABACCIONES,
                 GRAL.CESCESTADO  CER2,
                 GRAL.CESRRUTA    RPR
            WHERE TABACCIONES.EDOACT(+) = CER2.CER_PK_ESTADO
                  AND RPR.RPR_PK_RUTA = CER2.CER_FK_RUTA
                  AND RPR.RPR_FK_PROCEDIMIENTO = #procedimiento#
					<cfif not getEliminados>
					AND	CER2.CER_NUMERO_ESTADO > 0
					</cfif>
                 AND TABACCIONES.PKACCIONES IS NOT NULL
            ORDER BY PKACCIONES
        </cfquery>
		<cfreturn qResult>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene el estado siguiente de acuerdo a la acción realizada y el rol.
    --->
    <cffunction name="getEdoSigBypkAccion" hint="Obtiene los datos de la tabla a modificar.">
        <cfargument name="Accion" type="string" required="yes" hint="pk de la tabla USRTACCION">
        <cfargument name="pkRol"    type="numeric" required="yes" hint="pk del rol">
        <cfargument name="estadoActual"    type="numeric" required="yes" hint="pk del estado actual del registro">
        <cfquery name="qResult" datasource="DS_GRAL">
            SELECT REA.REA_PK_ESTADOACCION  EDOACC_PK,
                   REA.REA_FK_ESTADO_RUTA   EDOACTUAL,
                   REA.REA_FK_CAMBIO_ESTADO CAMBIOEDO,
                   TAC.TAC_ICONO            ICONO_ACCION,
                   TAC.TAC_ACCION_NOMBRE    NOMBRE_ACCION,
                   EDO.CER_NUMERO_ESTADO    NOM_EDO_SIG
            FROM   GRAL.USRTACCION       TAC,
                   GRAL.USRRACCIONROL    RAR,
                   GRAL.CESRESTADOACCION REA, 
                   GRAL.CESCESTADO       EDO
            WHERE  TAC.TAC_PK_ACCION = RAR.RAR_FK_ACCION
                   AND REA.REA_FK_CAMBIO_ESTADO = EDO.CER_PK_ESTADO
                   AND RAR.RAR_PK_ACCIONROL = REA.REA_FK_ACCION_ROL
                   AND RAR.RAR_FK_ROL = #pkRol#
                   AND TAC.TAC_ACCION_CLAVE = '#Accion#'
       		  	   AND REA.REA_FK_ESTADO > 0
				   AND REA.REA_FK_ESTADO_RUTA = #estadoActual#
        </cfquery>
        <cfreturn qResult>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que cambia el estado del registro en cuestión a partir de la accion que se realiza.
    --->
    <cffunction name="cambiarEstado" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkRegistro" 		hint="pk del registro afectado">
        <cfargument name="pkEstado"   		hint="pk del estado siguiente">
    	<cfargument name="pkProcedimiento"  hint="pk del procedimiento">
    	
		<cfset qTablaModificacion = this.obtenerTablaModificacion(pkProcedimiento)>
        <cfset tabla       = qTablaModificacion.TABLA[1]>
        <cfset campoEstado = qTablaModificacion.CAMPO_ESTADO[1]>
        <cfset campoPK     = qTablaModificacion.CAMPO_PK[1]>
        <cfset esquema     = qTablaModificacion.ESQUEMA[1]>
        <cfquery name="qEstadoActual" datasource="DS_#esquema#">
            UPDATE #tabla# TEMP
               SET TEMP.#campoEstado#  = #pkEstado#
			 WHERE #campoPK# = #pkRegistro#
        </cfquery>
        <cfreturn 1>
	</cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que registra el cambio de estado en algún registro.
    --->
    <cffunction name="registrarCambioEstado" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkProced"     required="yes" hint="pk del procedimiento">
        <cfargument name="edoActual"    required="yes" hint="pk del estado actual">
        <cfargument name="cambioEdo"    required="yes" hint="pk del estado siguiente">
        <cfargument name="pkRegistro"   required="yes" hint="pk del registro afectado">
        <cfargument name="usuario"      required="yes" hint="pk del usuario que ejecuta la funcion">
        <cfargument name="nombreAccion" required="yes" hint="pk del rol" type="string">
        <cfargument name="iconoAccion"  required="yes" hint="pk del rol" type="string">
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.CES_REGISTRA_CAMBIO" datasource="DS_GRAL">
                <cfprocparam value="#pkProced#"     cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#edoActual#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#cambioEdo#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkRegistro#"   cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#usuario#"      cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombreAccion#" cfsqltype="cf_sql_string"  type="in">
                <cfprocparam value="#iconoAccion#"  cfsqltype="cf_sql_string"  type="in">
                <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que actualiza el registro de la bitácora en caso de error.
    --->
    <cffunction name="mensajeBitacora" returntype="numeric" hint="Establece mensaje de error en la bitacora">
        <cfargument name="pkBitacora" required="yes" hint="pk de la tabla CESBHISTORIAL"> 
        <cfargument name="mensaje"    required="yes" hint="mensaje de error">
            <cfstoredproc procedure="GRAL.P_ADMON_ESTADOS.CES_MENSAJE_BITACORA" datasource="DS_GRAL">
                <cfprocparam value="#pkBitacora#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#mensaje#"    cfsqltype="cf_sql_string"  type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>    


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene las operaciones a realizar al ejecutar una acción.
    --->
    <cffunction name="getOperaciones" hint="Obtiene las operaciones que se realizan al ejecutar una accion.">
        <cfargument name="pkEdoAccion" type="numeric" required="yes" hint="Pk de la tabla CESRESTADOACCION">
        <cfargument name="tipoOper"    type="numeric" required="yes" hint="pk del tipo de operacion">
        <cfquery name="qResult" datasource="DS_GRAL">
            SELECT  COA.OAC_FK_OPERACION  OPER_PK,
                    CTO.OPR_NOMBRE        OPER_NOMBRE
            FROM    GRAL.CESROPERACIONACCION COA,
                    GRAL.CESTOPERACION       CTO
            WHERE   COA.OAC_FK_OPERACION = CTO.OPR_PK_OPERACION
                    AND COA.OAC_FK_ESTADO > 0
                    AND COA.OAC_FK_TIPOOPERACION = <cfqueryparam value="#arguments.tipoOper#" cfsqltype="cf_sql_numeric"> 
                    AND COA.OAC_FK_ESTADOACCION  = <cfqueryparam value="#arguments.pkEdoAccion#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qResult>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: 
	* -------------------------------
    * Descripcion de la modificacion: Agregar un nuevo argumento. Este argumento es el pk del procedimiento.
    * Fecha de la modificacion: 22/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: 
    ---> 
    <cffunction name="getEstadosObjeto" hint="Obtiene los estados por los que puede pasar el registro.">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del usuario">
		<cfargument name="PKRUTA" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT DISTINCT CED.CER_NUMERO_ESTADO NUM_EDO,
                   EDOS.REA_FK_ESTADO_RUTA        PK_ESTADO,
                   CED.CER_NOMBRE                 NOMB_EDO
            FROM   CESRESTADOACCION EDOS,
                   CESCESTADO       CED
            WHERE  EDOS.REA_FK_ESTADO_RUTA = CED.CER_PK_ESTADO
                   AND CED.CER_NUMERO_ESTADO <> 0
				   AND CED.CER_FK_RUTA = <cfqueryparam value="#arguments.PKRUTA#" cfsqltype="cf_sql_numeric">
                      
            UNION

            SELECT DISTINCT CED.CER_NUMERO_ESTADO NUM_EDO,
                   EDOS.REA_FK_CAMBIO_ESTADO      PK_ESTADO,
                   CED.CER_NOMBRE                 NOMB_EDO
            FROM   CESRESTADOACCION EDOS,
                   CESCESTADO       CED
            WHERE  EDOS.REA_FK_CAMBIO_ESTADO = CED.CER_PK_ESTADO
                   AND CED.CER_NUMERO_ESTADO <> 0
                   AND CED.CER_FK_RUTA = <cfqueryparam value="#arguments.PKRUTA#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>


    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene el historial de cambios del objeto.
	* -------------------------------
    * Descripcion de la modificacion: Agregar un nuevo argumento. Este argumento es el pk del procedimiento.
    * Fecha de la modificacion: 22/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    ---> 
    <cffunction name="getHistorialCambios" hint="Obtiene el historial de cambios del objeto.">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del registro">
		<cfargument name="PKRUTA" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT
                USU.TUS_USUARIO_NOMBRE|| ' '|| USU.TUS_USUARIO_PATERNO|| ' '|| USU.TUS_USUARIO_MATERNO USUARIO,
                TO_CHAR(HIST.BHI_FECHA_MODIFICACION,'YYYY-MM-DD HH24:MI:SS') FECHA,
                HIST.BHI_NUMERO_ESTADO_ANTERIOR                  PK_EDO_ANTERIOR,
                HIST.BHI_NUMERO_ESTADO_ACTUAL                    PK_EDO_ACTUAL,
                CES.CER_NUMERO_ESTADO                            NOM_EDO_ANTERIOR,
                CES2.CER_NUMERO_ESTADO                           NOM_EDO_ACTUAL,
                CES2.CER_NOMBRE                                  NOMBRE_EDO_ACTUAL,
                HIST.BHI_NOMBREACCION                            ACCION_NOMBRE,
                HIST.BHI_ICONOACCION                             ACCION_ICONO
             FROM    GRAL.CESBHISTORIAL HIST,
                     GRAL.CESCESTADO    CES,
                     GRAL.CESCESTADO    CES2,
                     GRAL.USRTUSUARIO   USU
            WHERE   BHI_NUMERO_ESTADO_ANTERIOR    = CES.CER_PK_ESTADO
                    AND BHI_NUMERO_ESTADO_ACTUAL  = CES2.CER_PK_ESTADO
                    AND BHI_USUARIO_MODIFICACION  = TUS_PK_USUARIO
                    AND BHI_REGISTRO_MODIFICACION = <cfqueryparam value="#arguments.pkRegistro#" cfsqltype="cf_sql_numeric">
                    AND CES.CER_FK_RUTA = <cfqueryparam value="#arguments.PKRUTA#" cfsqltype="cf_sql_numeric">
            ORDER BY FECHA ASC
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

    <cffunction name="getHistorialCambiosObjeto" hint="Obtiene el historial de validaciones del objeto.">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del registro">
        <cfargument name="PKRUTA" type="numeric" required="yes" hint="pk del procedimiento">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT
                USU.TUS_USUARIO_NOMBRE|| ' '|| USU.TUS_USUARIO_PATERNO|| ' '|| USU.TUS_USUARIO_MATERNO USUARIO,
                TO_CHAR(HIST.BHI_FECHA_MODIFICACION,'YYYY-MM-DD HH24:MI:SS') FECHA,
                HIST.BHI_NUMERO_ESTADO_ANTERIOR                  PK_EDO_ANTERIOR,
                HIST.BHI_NUMERO_ESTADO_ACTUAL                    PK_EDO_ACTUAL,
                CES.CER_NUMERO_ESTADO                            NOM_EDO_ANTERIOR,
                CES2.CER_NUMERO_ESTADO                           NOM_EDO_ACTUAL,
                CES2.CER_NOMBRE                                  NOMBRE_EDO_ACTUAL,
                HIST.BHI_NOMBREACCION                            ACCION_NOMBRE,
                HIST.BHI_ICONOACCION                             ACCION_ICONO
             FROM    GRAL.CESBHISTORIAL HIST,
                     GRAL.CESCESTADO    CES,
                     GRAL.CESCESTADO    CES2,
                     GRAL.USRTUSUARIO   USU
            WHERE   BHI_NUMERO_ESTADO_ANTERIOR    = CES.CER_PK_ESTADO
                    AND BHI_NUMERO_ESTADO_ACTUAL  = CES2.CER_PK_ESTADO
                    AND BHI_USUARIO_MODIFICACION  = TUS_PK_USUARIO
                    AND BHI_REGISTRO_MODIFICACION = <cfqueryparam value="#arguments.pkRegistro#" cfsqltype="cf_sql_numeric">
                    AND CES.CER_FK_RUTA = <cfqueryparam value="#arguments.PKRUTA#" cfsqltype="cf_sql_numeric">
            ORDER BY FECHA DESC
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

    <!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los ultimos tres estados.
    ---> 
    <cffunction name="ultimosEstados" hint="Obtiene los ultimos tres estados">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="pk del registro">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  HIST.BHI_NUMERO_ESTADO_ANTERIOR PKANT,
                    HIST.BHI_NUMERO_ESTADO_ACTUAL   PKACTU,
                    CES.CER_NUMERO_ESTADO           ESTADO
            FROM    CESBHISTORIAL HIST,
                    CESCESTADO    CES
            WHERE   HIST.BHI_NUMERO_ESTADO_ACTUAL = CES.CER_PK_ESTADO
                    AND HIST.BHI_REGISTRO_MODIFICACION = <cfqueryparam value="#arguments.pkRegistro#" cfsqltype="cf_sql_numeric">
                    ORDER BY HIST.BHI_PK_HISTORIAL ASC
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>


    <!---
    * Fecha: Febrero de 2017
    * @author SGS
    * Descripcion: Función que obtiene el rol siguiente mediante la calve de la accion.
    --->
    <cffunction name="getRolSigByClaveAccion" hint="Obtiene el estado siguiente de una accion">
        <cfargument name="accion" type="string"  required="yes" hint="clave de la accion de la tabla USRTACCION">
        <cfargument name="estado" type="numeric" required="yes" hint="estado de la accion">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT RAR.RAR_FK_ROL          AS PK_ROL
            FROM   GRAL.CESCESTADO         CES,
                   GRAL.CESRESTADOACCION   CEA,
                   GRAL.USRRACCIONROL      RAR,
                   GRAL.USRTACCION         TAC
            WHERE  CES.CER_PK_ESTADO     = CEA.REA_FK_ESTADO_RUTA   
            AND    CEA.REA_FK_ACCION_ROL = RAR.RAR_PK_ACCIONROL
            AND    RAR.RAR_FK_ACCION     = TAC.TAC_PK_ACCION
            AND    CES.CER_PK_ESTADO IN (   SELECT CEA.REA_FK_CAMBIO_ESTADO
                                            FROM   GRAL.CESCESTADO         CES,
                                                   GRAL.CESRESTADOACCION   CEA,
                                                   GRAL.USRRACCIONROL      RAR,
                                                   GRAL.USRTACCION         TAC
                                            WHERE  CES.CER_PK_ESTADO     = CEA.REA_FK_ESTADO_RUTA   
                                            AND    CEA.REA_FK_ACCION_ROL = RAR.RAR_PK_ACCIONROL
                                            AND    RAR.RAR_FK_ACCION     = TAC.TAC_PK_ACCION
                                            AND    TAC.TAC_ACCION_CLAVE  = '#accion#'
                                            AND    CES.CER_PK_ESTADO     = #estado# )
            GROUP BY RAR.RAR_FK_ROL
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

    <!---
    * Fecha:    Diciembre de 2017
    * Autor:    Roberto Cadena
    --->
    <cffunction name="getPrimerEstado" hint="Obtiene el primer estado de una ruta">
        <cfargument name="ruta" type="numeric"  required="yes" hint="pk de la ruta">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  CER.CER_PK_ESTADO    AS ESTADO
             FROM   GRAL.CESCESTADO     CER
            WHERE   CER.CER_FK_RUTA = <cfqueryparam value="#arguments.ruta#" cfsqltype="cf_sql_numeric">
             AND    CER.CER_NUMERO_ESTADO = 1
             AND    CER.CER_FK_ESTADO = 2
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

</cfcomponent>

