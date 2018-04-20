<cfcomponent>

    <cffunction name="guardarEvaluacion" access="remote" hint="">
        <cfargument name="nombre" type="string" required="yes" hint="Clave de la acción formativa">
        <cfargument name="fechaIni" type="string" required="yes" hint="Nombre del programa">
        <cfargument name="fechaFin" type="string" required="yes" hint="Costo al público general">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GUARDAR_FORMATOEVALUACION" datasource="DS_GRAL">
            <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#fechaIni#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#fechaFin#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="guardarSeccion" access="remote" hint="">
        <cfargument name="nombreSecc" type="string" required="yes" hint="Clave de la acción formativa">
        <cfargument name="ordenSecc" type="numeric" required="yes" hint="Nombre del programa">
        <cfargument name="fkEvaluacion" type="numeric" required="yes" hint="Nombre del programa">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GUARDAR_SECCIONEVALUACION" datasource="DS_GRAL">
            <cfprocparam value="#nombreSecc#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#ordenSecc#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="guardarAspecto" access="remote" hint="">
        <cfargument name="nombreAsp" type="string" required="yes" hint="Clave de la acción formativa">
        <cfargument name="ordenAsp" type="numeric" required="yes" hint="Nombre del programa">
        <cfargument name="seccion" type="numeric" required="yes" hint="Nombre del programa">
        <cfargument name="escala" type="numeric" required="yes" hint="Nombre del programa">
        <cfargument name="evaluacion" type="numeric" required="yes" hint="Nombre del programa">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GUARDAR_ASPECTOEVALUACION" datasource="DS_GRAL">
            <cfprocparam value="#nombreAsp#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#ordenAsp#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#seccion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#escala#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#evaluacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="actualizarOrdenAspectos" access="remote" hint="">
        <cfargument name="ordenAspecto" type="string" required="yes" hint="Clave de la acción formativa">
        <cfargument name="pkAspecto" type="numeric" required="yes" hint="Nombre del programa">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDITAR_ORDEN_ASPECTO" datasource="DS_GRAL">
            <cfprocparam value="#ordenAspecto#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#pkAspecto#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="actualizarOrdenSeccion" access="remote" hint="">
        <cfargument name="Ord" type="string" required="yes" hint="Clave de la acción formativa">
        <cfargument name="Seccion" type="numeric" required="yes" hint="Nombre del programa">
        <cfdump var="#arguments#">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDITAR_ORDEN_SECCION" datasource="DS_GRAL">
            <cfprocparam value="#Ord#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#Seccion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="eliminarSeccion" access="remote" hint="">
        <cfargument name="Seccion" type="numeric" required="yes" hint="Nombre del programa">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDITAR_ESTADO_SECCION" datasource="DS_GRAL">
            <cfprocparam value="#Seccion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="eliminarAspecto" access="remote" hint="">
        <cfargument name="pkAspecto" type="numeric" required="yes" hint="Nombre del programa">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDITAR_ESTADO_ASPECTO" datasource="DS_GRAL">
            <cfprocparam value="#pkAspecto#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
    </cffunction>

    <cffunction name="obtenerEvaluaciones" access="remote" hint="Obtiene los datos para construir el formato de evaluacion">
        <cfquery datasource="DS_GRAL" name="evaluaciones">
            SELECT EV.CEV_NOMBRE EVALUACION,
                EV.CEV_FECHAFIN FFIN,
                EV.CEV_FECHAINI FINI,
                EV.CEV_PK_EVALUACION PKEVAL
            FROM GRAL.EDSCEVALUACION EV
        </cfquery>
        <cfreturn evaluaciones>
    </cffunction>

    <cffunction name="obtenerAspectoSeccion" access="remote" hint="Obtiene los datos para construir el formato de evaluacion">
        <cfargument name="pkEvaluacion" required="yes" hint="pk de la evalacion">
        <cfquery datasource="DS_GRAL" name="aspectoSecc">
            SELECT ASPSEC.CAS_NOMBRE NOMBRE,
                    ASPSEC.CAS_PK_ASPECTOSECCION PKSEC,
                    ASPSEC.CAS_ORDEN ORD
            FROM GRAL.EDSCASPECTOSECCION ASPSEC
            WHERE ASPSEC.CAS_FK_EVALUACION = #pkEvaluacion#
            AND ASPSEC.CAS_FK_ESTADO = 2
            ORDER BY ASPSEC.CAS_ORDEN
        </cfquery>
        <cfreturn aspectoSecc>
    </cffunction>

    <cffunction name="obtenerAspecto" access="remote" hint="Obtiene los datos para construir el formato de evaluacion">
        <cfargument name="pkSecc" required="yes" hint="pk de la seccion de un evaluacion">
        <cfquery datasource="DS_GRAL" name="aspecto">
            SELECT EA.CAP_NOMBRE NOMASP,
                   EA.CAP_PK_ASPECTO PKASP,
                   ESCA.CET_NOMBRE NOMESCL,
                   EA.CAP_ORDEN ORDA
            FROM GRAL.EDSCASPECTO EA,
                GRAL.EDSCESCALATIPO ESCA
            WHERE EA.CAP_FK_ASPECTOSECCION=#pkSecc#
            AND ESCA.CET_PK_ESCALATIPO=EA.CAP_FK_ESCALATIPO
            AND EA.CAP_FK_ESTADO = 2
            ORDER BY EA.CAP_ORDEN
        </cfquery>
        <cfreturn aspecto>
    </cffunction>

    <cffunction name="obtenerEscala" access="remote" hint="Obtiene las escalas que pueden tener las evaluaciones">
        <cfquery datasource="DS_GRAL" name="aspecto">
            SELECT ESCTIPO.CET_NOMBRE NOMESC,
                    ESCTIPO.CET_PK_ESCALATIPO PKESC
            FROM GRAL.EDSCESCALATIPO ESCTIPO
        </cfquery>
        <cfreturn aspecto>
    </cffunction>

</cfcomponent>