<cfcomponent> 

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Obtiene los comentarios dirigidos al usuario.
    --->
    <cffunction name="getComentariosByUsuario" hint="Obtiene los comentarios dirigidos al usuario.">
        <cfargument name="pkUsuario"    type="numeric" required="yes" hint="pk del usuario">
        <cfargument name="filtro"       type="numeric" required="yes" hint="valor del filtro">
        <cfargument name="pkTipoComent" type="numeric" required="yes" hint="pk del tipo de comentario">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  COM.COM_PK_COMENTARIO        COMENT_PK,
                    COM.COM_PRIORIDAD            COMENT_PRIOR,
                    TO_CHAR(COM.COM_FECHA, 'dd/mm/yyyy HH24:MI:SS')  COMENT_FECHA,
                    EDO.CER_NOMBRE               EDO_NOMBRE,
                    RCU.RCU_PK_COMENTUSUARIO     REL_PK,
                    RCU.RCU_VISTO                REL_VISTO,
                    USU.TUS_USUARIO_NOMBRE || ' ' || USU.TUS_USUARIO_PATERNO || ' ' || USU.TUS_USUARIO_MATERNO AS NOMBRE,
                    ROL.TRO_ROL_NOMBRE           NOMBREROL
            FROM    PDIPIMP.COMTCOMENTARIO     COM,
                    PDIPIMP.USRTUSUARIO        USU,
                    PDIPIMP.CESCESTADO         EDO,
                    PDIPIMP.COMRCOMENTUSUARIO  RCU,
                    PDIPIMP.USRTROL            ROL
            WHERE   COM.COM_FK_USUARIO = USU.TUS_PK_USUARIO
                    AND USU.TUS_FK_ROL = ROL.TRO_PK_ROL
                    AND COM.COM_FK_SITUACION  = EDO.CER_PK_ESTADO
                    AND COM.COM_PK_COMENTARIO = RCU.RCU_FK_COMENTARIO
                    AND RCU.RCU_FK_USUARIO = #pkUsuario#

                    <cfif pkTipoComent NEQ 0>
                        AND COM.COM_FK_TIPOCOMENTARIO = #pkTipoComent#
                    </cfif>
    
                    <cfif filtro NEQ 2>
                         AND RCU.RCU_VISTO = #filtro#
                    </cfif>
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que registra un comentario.
    --->
    <cffunction name="registraComentario" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="asunto"      type="string"  required="no"  hint="asunto">
        <cfargument name="comentario"  type="string"  required="no"  hint="comentario">
        <cfargument name="prioridad"   type="numeric" required="yes" hint="prioridad del comentario">
        <cfargument name="pkEstado"    type="numeric" required="no"  hint="pk del estado en que se hace el comentario">
        <cfargument name="pkUsuario"   type="numeric" required="yes" hint="pk del usuario que hace el comentario">
        <cfargument name="tipoComent"  type="numeric" required="yes" hint="pk del tipo de comentario">
        <cfargument name="pkRegistro"  type="numeric" required="yes" hint="Registro al que pertenece el comentario">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_COMENTARIO.GUARDA_COMENTARIO" datasource="DS_PDIPIMP">
                <cfprocparam value="#asunto#"     cfsqltype="cf_sql_string"  type="in">
                <cfprocparam value="#comentario#" cfsqltype="cf_sql_string"  type="in">
                <cfprocparam value="#prioridad#"  cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkEstado#"   cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkUsuario#"  cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#tipoComent#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkRegistro#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los comentarios hechos sobre un registro.
    ---> 
    <cffunction name="getComentariosReg" hint="Obtiene comentarios de un registro">
        <cfargument name="pkRegistro" type="numeric" required="yes" hint="Pk del registro">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  COM.COM_PK_COMENTARIO    COMENT_PK,
                    COM.COM_PRIORIDAD        COMENT_PRIOR,
                    USU.TUS_USUARIO_USERNAME USUARIO_NOMBRE,
                    COM.COM_FECHA            COMENT_FECHA,
                    EDO.CER_NOMBRE           EDO_NOMBRE,    
                    COM.COM_ASUNTO           COMENT_ASUNTO,
                    USU.TUS_USUARIO_NOMBRE || ' ' || USU.TUS_USUARIO_PATERNO || ' ' || USU.TUS_USUARIO_MATERNO AS NOMBRE,
                    ROL.TRO_ROL_NOMBRE      NOMBREROL 
            FROM    PDIPIMP.COMTCOMENTARIO COM,
                    PDIPIMP.USRTUSUARIO    USU,
                    PDIPIMP.CESCESTADO     EDO,
                    PDIPIMP.USRTROL        ROL
            WHERE   COM.COM_FK_USUARIO = USU.TUS_PK_USUARIO
                    AND USU.TUS_FK_ROL = ROL.TRO_PK_ROL
                    AND COM.COM_FK_SITUACION = EDO.CER_PK_ESTADO
                    AND COM.COM_FK_REGISTRO = #pkRegistro#
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los comentarios hechos sobre un registro.
    ---> 
    <cffunction name="getContenidoComent" hint="Obtiene comentarios de un registro">
        <cfargument name="pkComent" type="numeric" required="yes" hint="Pk del registro">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  COM.COM_COMENTARIO COMENTARIO,
                    COM.COM_ASUNTO     ASUNTO
            FROM    PDIPIMP.COMTCOMENTARIO COM
            WHERE   COM.COM_PK_COMENTARIO = #pkComent#      
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>
    

    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que establece un comentario como visto.
    --->
    <cffunction name="setVisto" returntype="numeric" hint="Establece comentario como visto">
        <cfargument name="pkComentRel" hint="pk de tabla COMTCOMENTARIO">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_COMENTARIO.COMENTARIO_VISTO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkComentRel#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>



    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que obtiene la cantidad de comentarios no vistos.
    ---> 
    <cffunction name="getComentariosNoVistos" hint="Establece comentario como visto">
        <cfargument name="pkUsuario"  type="numeric" required="yes" hint="pk del usuario">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  COUNT(RCU.RCU_VISTO) REL_NOVISTO
            FROM    PDIPIMP.COMRCOMENTUSUARIO RCU
            WHERE   RCU.RCU_VISTO = 0
                    AND RCU.RCU_FK_USUARIO = #pkUsuario#
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los usuarios para enviar comentario.
    --->
    <cffunction name="getUsuComentario" hint="Establece comentario como visto">
        <cfargument name="pkRegistro"  type="numeric" required="yes" hint="pk del registro">
        <cfquery name="qResult" datasource="DS_PDIPIMP">
            SELECT  DISTINCT USU.TUS_PK_USUARIO  USU_PK,
                    USU.TUS_USUARIO_NOMBRE || ' ' || USU.TUS_USUARIO_PATERNO || ' ' || USU.TUS_USUARIO_MATERNO AS NOMBRE,
                    ROL.TRO_ROL_NOMBRE  NOMBREROL
            FROM    PDIPIMP.USRTUSUARIO    USU,
                    PDIPIMP.USRTROL        ROL,
                    PDIPIMP.CESBHISTORIAL  HIS
            WHERE   HIS.BHI_USUARIO_MODIFICACION = USU.TUS_PK_USUARIO
                    AND USU.TUS_FK_ROL = ROL.TRO_PK_ROL
                    AND HIS.BHI_USUARIO_MODIFICACION <> #Session.cbstorage.usuario.PK#
                    AND HIS.BHI_REGISTRO_MODIFICACION = #pkRegistro#
        </cfquery>
        <cfreturn qResult>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Funcion que relaciona un comentario y un usuario.
    --->
    <cffunction name="regitraRelacionComent" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkComentario"    type="numeric" required="yes" hint="pk del tipo de comentario">
        <cfargument name="pkDestinatario"  type="numeric" required="yes" hint="Registro al que pertenece el comentario">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_ADMON_COMENTARIO.REL_COMENT_USUARIO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkComentario#"   cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkDestinatario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que obtiene los asuntos del tipo de comentario.
    --->
    <cffunction name="asuntoComentario" hint="Establece comentario como visto">
        <cfargument name="pkTipoComent" type="numeric" required="yes" hint="pk tipo de comentario">
        <cfquery name="qResult" datasource="DS_PDIPIMP">
            SELECT  TPC.TCO_ASUNTO ASUNTO
            FROM    PDIPIMP.COMCTIPOCOMENTARIO TPC
            WHERE   TPC.TCO_PK_TIPOCOMENTARIO = #pkTipoComent#
        </cfquery>
        <cfreturn qResult>        
    </cffunction>


</cfcomponent>