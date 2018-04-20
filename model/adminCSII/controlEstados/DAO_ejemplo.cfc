<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: ejemplo de implementacion de control de estados
* Fecha: octubre/2016
* Autor: Alejandro Tovar
============================================================================================
--->

<cfcomponent>

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los procedimientos disponibles en el catálogo
    --->
    <cffunction name="obtenerProcedimiento" hint="Obtiene los procedimientos disponibles en la máquina de estados">
        <cfquery name="qResult" datasource="DS_GRAL">
            SELECT  CPR_PK_PROCEDIMIENTO CVE,
                    CPR_NOMBRE           NOMBRE,
                    CPR_DESCRIPCION      DES
            FROM    CESCPROCEDIMIENTO
            WHERE   CPR_FK_ESTADO = 2
        </cfquery>
        <cfreturn qResult>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los roles disponibles en el catálogo.
    ---> 
    <cffunction name="getRol" hint="Obtiene los roles disponibles">
        <cfquery name="qResult"datasource="DS_SIIE">
            SELECT  TROL.TRO_PK_ROL     PK,
                    TROL.TRO_ROL_NOMBRE NOMBRE
            FROM    GRAL.USRTROL TROL
            WHERE   TROL.TRO_FK_ESTADO = 2
        </cfquery>
        <cfreturn qResult>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene solamente los registros.
    ---> 
    <cffunction name="getTablaEjemplo" hint="Obtiene los registros de la tabla temporal">
        <cfargument name="registro" type="any" required="no" hint="Pk del registro">
        <cfquery name="qResult" datasource="DS_GRAL">
            SELECT  TMP.TMP_PK_PARTICIPANTE PK,
                    TMP.TMP_NOMBRE          NOMBRE,
                    TMP.TMP_PATERNO         PATERNO,
                    TMP.TMP_MATERNO         MATERNO,
                    TMP.TMP_EMAIL           MAIL,
                    TMP.TMP_RUTA            CESRUTA,
                    TMP.TMP_FK_ESTADO       CESESTADO
            FROM    GRAL.TMPTPRUEBACES TMP
            
                <cfif registro NEQ 'NA'>
                    WHERE TMP.TMP_PK_PARTICIPANTE = #registro#
                </cfif>
                
        </cfquery>
        <cfreturn qResult>
    </cffunction>


</cfcomponent> 
