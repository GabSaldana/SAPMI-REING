<cfcomponent> 

    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getVertiente" hint="Obtiene los usuarios del sistema">
        <cfquery name="qVert" datasource="DS_GRAL">
            SELECT VERT.TVE_PK_VERTIENTE     AS PK,
                   VERT.TVE_VERTIENTE_NOMBRE AS VERT
              FROM GRAL.USRTVERTIENTE VERT
             WHERE VERT.TVE_FK_ESTADO = 2
          ORDER BY VERT ASC
        </cfquery>
        <cfreturn qVert>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getRolesByVertiente" hint="Obtiene la lista de roles por vertiente">
        <cfargument name="pkVertiente" type="numeric" required="yes" hint="Pk de la vertiente">
        <cfquery name="qRoles"datasource="DS_GRAL">
            SELECT TROL.TRO_ROL_NOMBRE ROL, 
                   TROL.TRO_PK_ROL     PK 
              FROM GRAL.USRTROL       TROL,
                   GRAL.USRTVERTIENTE TVER
             WHERE TROL.TRO_FK_ESTADO    = 2
               AND TVER.TVE_PK_VERTIENTE = TROL.TRO_FK_VERTIENTE
	           AND TROL.TRO_FK_VERTIENTE = #pkVertiente#
            ORDER BY TVER.TVE_VERTIENTE_NOMBRE
        </cfquery>
        <cfreturn qRoles>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getAvisos" hint="Consulta el usuario seleccionado">
        <cfquery name="qUsuario" datasource="DS_GRAL">
            SELECT AVI.AVI_PK_AVISO    AS PK_AVISO,
                   AVI.AVI_NOMBRE      AS NOMBRE_AVISO,
                   AVI.AVI_DESCRIPCION AS NOMBRE_DESC,
                   AVI.AVI_REDIRECCION AS REDIRECCION,
                   TO_CHAR(AVI.AVI_FECHAINI, 'DD/MM/YYYY') AS FECHA_INICIO,
                   TO_CHAR(AVI.AVI_FECHAFIN, 'DD/MM/YYYY') AS FECHA_FIN,
                   LISTAGG(AVROL.RAV_FK_ROL, ', ') WITHIN GROUP (ORDER BY RAV_FK_ROL) AS ROLES
              FROM GRAL.AVISOS       AVI,
                   GRAL.AVIRROLAVISO AVROL,
                   GRAL.USRTROL      ROL
             WHERE AVROL.RAV_FK_AVISO = AVI.AVI_PK_AVISO
               AND AVROL.RAV_FK_ROL   = ROL.TRO_PK_ROL
               AND AVI.AVI_FK_ESTADO = 2
               AND AVROL.RAV_FK_ESTADO = 2
          GROUP BY AVI.AVI_PK_AVISO, AVI.AVI_NOMBRE, AVI.AVI_DESCRIPCION, AVI.AVI_REDIRECCION, AVI.AVI_FECHAINI, AVI.AVI_FECHAFIN
        </cfquery>
        <cfreturn qUsuario>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="guardaAviso" hint="Guarda nuevo registro de un aviso">
        <cfargument name="nombre"  type="string"  required="yes" hint="nombre del aviso">
        <cfargument name="mensaje" type="string"  required="yes" hint="contenido del aviso">
        <cfargument name="fecIni"  type="string"  required="yes" hint="fecha de inicio del aviso">
        <cfargument name="fecFin"  type="string"  required="yes" hint="fecha fin del aviso">
        <cfargument name="redir"   type="string"  required="yes" hint="modulo al que redirige">
        <cfargument name="vert"    type="numeric" required="yes" hint="pk de la vertiente">
        <cfstoredproc procedure="GRAL.P_ADMON_AVISOS.GUARDAR_AVISO" datasource="DS_GRAL">
            <cfprocparam value="#nombre#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#mensaje#" cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#fecIni#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#fecFin#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#redir#"   cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#vert#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="relacionaRolAviso" hint="Guarda nuevo registro de un aviso">
        <cfargument name="pkAviso" type="numeric" required="yes" hint="pk del aviso">
        <cfargument name="pkRol"   type="numeric" required="yes" hint="pk del rol">
        <cfstoredproc procedure="GRAL.P_ADMON_AVISOS.RELACIONA_ROL_AVISO" datasource="DS_GRAL">
            <cfprocparam value="#pkAviso#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkRol#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="cambiaEdoAviso" access="public" returntype="numeric" hint="Cambiar el estado de un aviso">
        <cfargument name="pkAviso" type="numeric" required="yes" hint="pk del aviso">
        <cfstoredproc procedure="GRAL.P_ADMON_AVISOS.CAMBIA_EDO_AVISO" datasource="DS_GRAL">
                <cfprocparam value="#pkAviso#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
        <cfreturn resultado>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getAvisoByPk" hint="Consulta un aviso por su pk">
        <cfargument name="pkAviso" type="numeric" required="yes" hint="pk del aviso">
        <cfquery name="qUsuario" datasource="DS_GRAL">
            SELECT AVI.AVI_PK_AVISO     AS PK_AVISO,
                   AVI.AVI_NOMBRE       AS NOMBRE_AVISO,
                   AVI.AVI_DESCRIPCION  AS NOMBRE_DESC,
                   AVI.AVI_REDIRECCION  AS REDIRECCION,
                   AVI.AVI_FK_VERTIENTE AS VERTIENTE,
                   TO_CHAR(AVI.AVI_FECHAINI, 'DD/MM/YYYY') AS FECHA_INICIO,
                   TO_CHAR(AVI.AVI_FECHAFIN, 'DD/MM/YYYY') AS FECHA_FIN,
                   LISTAGG(AVROL.RAV_FK_ROL, ', ') WITHIN GROUP (ORDER BY RAV_FK_ROL) AS ROLES
              FROM GRAL.AVISOS       AVI,
                   GRAL.AVIRROLAVISO AVROL,
                   GRAL.USRTROL      ROL
             WHERE AVROL.RAV_FK_AVISO = AVI.AVI_PK_AVISO
               AND AVROL.RAV_FK_ROL   = ROL.TRO_PK_ROL
               AND AVI.AVI_FK_ESTADO = 2
               AND AVI.AVI_PK_AVISO = #pkAviso#
          GROUP BY AVI.AVI_PK_AVISO, AVI.AVI_NOMBRE, AVI.AVI_DESCRIPCION, AVI.AVI_REDIRECCION, AVI.AVI_FECHAINI, AVI.AVI_FECHAFIN, AVI.AVI_FK_VERTIENTE
        </cfquery>
        <cfreturn qUsuario>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="editarAviso" hint="Guarda nuevo registro de un aviso">
        <cfargument name="pkAviso" type="string"  required="yes" hint="pk del aviso">
        <cfargument name="nombre"  type="string"  required="yes" hint="nombre del aviso">
        <cfargument name="mensaje" type="string"  required="yes" hint="contenido del aviso">
        <cfargument name="fecIni"  type="string"  required="yes" hint="fecha de inicio del aviso">
        <cfargument name="fecFin"  type="string"  required="yes" hint="fecha fin del aviso">
        <cfargument name="redir"   type="string"  required="yes" hint="modulo al que redirige">
        <cfargument name="vert"    type="numeric" required="yes" hint="pk de la vertiente">
        <cfstoredproc procedure="GRAL.P_ADMON_AVISOS.EDITAR_AVISO" datasource="DS_GRAL">
            <cfprocparam value="#pkAviso#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#nombre#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#mensaje#" cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#fecIni#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#fecFin#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#redir#"   cfsqltype="cf_sql_string"  type="in">
            <cfprocparam value="#vert#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha creación: enero, 2018
    * @author: Alejandro Tovar
    --->
    <cffunction name="getAvisoByRol" hint="Consulta un aviso por su pk">
        <cfargument name="pkRol" type="numeric" required="yes" hint="pk del rol">
        <cfquery name="qAviso" datasource="DS_GRAL">
            SELECT AVI.AVI_NOMBRE      AS NOMBRE_AVISO,
                   AVI.AVI_DESCRIPCION AS NOMBRE_DESC,
                   AVI.AVI_REDIRECCION AS RUTA
              FROM GRAL.AVISOS       AVI,
                   GRAL.AVIRROLAVISO AVROL
             WHERE TO_DATE(SYSDATE, 'DD/MM/YYYY') >= TO_DATE(AVI.AVI_FECHAINI, 'DD/MM/YYYY')
               AND TO_DATE(SYSDATE, 'DD/MM/YYYY') <= TO_DATE(AVI.AVI_FECHAFIN, 'DD/MM/YYYY')
               AND AVROL.RAV_FK_AVISO  = AVI.AVI_PK_AVISO
               AND AVROL.RAV_FK_ESTADO = 2
               AND AVI.AVI_FK_ESTADO   = 2
               AND AVROL.RAV_FK_ROL    = #pkRol#
        </cfquery>
        <cfreturn qAviso>
    </cffunction>


</cfcomponent>