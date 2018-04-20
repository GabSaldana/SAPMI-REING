<!---
============================================================================================
* IPN - CSII
* Sistema: SIE
* Modulo: Administración de correos
* Fecha: Enero de 2017
* Descripcion: Acceso a datos para crear las plantillas de los correos.
* Autor: SGS
============================================================================================
--->

<cfcomponent> 

    <cffunction name="obtenerCorreos" hint="Obtiene correos para la tabla de correos">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
               CCORR.CCO_PK_CORREO PK, 
               CCORR.CCO_NOMBRE  NOMBRE,
               CCORR.CCO_DESCRIPCION DESCRIPCION,
               CCORR.CCO_FK_ESTADO EDO
            FROM
                PDIPIMP.CORCCORREO CCORR
            WHERE
                CCO_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="obtenerVistaCorreo" hint="Obtiene vista previa de un correo">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
                HEAD.CPH_CONTENIDO HEADER,
                BODY.CPB_BODY BODY,
                FOOT.CPF_CONTENIDO FOOTER
            FROM
                PDIPIMP.CORCPLANTHEAD HEAD,
                PDIPIMP.CORCPLANTBODY BODY,
                PDIPIMP.CORCPLANTFOOT FOOT
            WHERE
                BODY.CPB_FK_CORREO = #pkCorreo#
                AND BODY.CPB_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
                AND BODY.CPB_FK_PLANTHEAD = HEAD.CPH_PK_PLANTHEAD
                AND BODY.CPB_FK_PLANTFOOT = FOOT.CPF_PK_PLANTFOOT
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="cambiarEstadoCorreo" hint="Cambia el estado de un correo">
        <cfargument name="pk" type="numeric" required="yes" hint="pk del correo">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.CAMBIAR_EDO_CORREO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>

    </cffunction>

    <cffunction name="obtenerBody" hint="Obtiene el cuerpo del correo">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                BODY.CPB_PK_PLANTBODY PK_BODY,
                BODY.CPB_FK_PLANTHEAD PKHEAD,
                BODY.CPB_BODY BODY,
                BODY.CPB_FK_PLANTFOOT PKFOOT
            FROM
                PDIPIMP.CORCPLANTBODY BODY
            WHERE
                BODY.CPB_FK_CORREO = #pkCorreo#
                AND BODY.CPB_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="agregarCorreo" hint="Agrega un nuevo correo">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del correo">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion del correo">
        <cfargument name="nombreContenido" type="string" required="yes" hint="Nombre del cuerpo del contenido">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido del correo">
        <cfargument name="pkHead" type="numeric" required="yes" hint="pk de la cabecera">
        <cfargument name="pkFoot" type="numeric" required="yes" hint="pk del pie de pagina">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.GUARDAR_CORREO" datasource="DS_PDIPIMP">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#nombreContenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#contenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#pkHead#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkFoot#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>

    </cffunction>

    <cffunction name="editarCorreo" hint="Edita un correo">
        <cfargument name="pk" type="numeric" required="yes" hint="pk del correo">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del correo">
        <cfargument name="desc" type="string" required="yes" hint="Descripcion del correo">
        <cfargument name="nombreContenido" type="string" required="yes" hint="Nombre del cuerpo del contenido">
        <cfargument name="contenido" type="string" required="yes" hint="Contenido del correo">
        <cfargument name="pkHead" type="numeric" required="yes" hint="pk de la cabecera">
        <cfargument name="pkFoot" type="numeric" required="yes" hint="pk del pie de pagina">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.EDITAR_CORREO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#nombreContenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#contenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#pkHead#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkFoot#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>

    </cffunction>

    <cffunction name="obtieneHeader" hint="Obtiene las plantillas header para la tabla de plantillas">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                HEAD.CPH_PK_PLANTHEAD PK,
                HEAD.CPH_NOMBRE NOMBRE,
                HEAD.CPH_DESCRIPCION DESCRIPCION,
                HEAD.CPH_CONTENIDO CONTENIDO,                
                HEAD.CPH_FK_ESTADO EDO
            FROM
                PDIPIMP.CORCPLANTHEAD HEAD
            WHERE
                HEAD.CPH_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="obtieneFooter" hint="Obtiene las plantillas footer para la tabla de plantillas">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                FOOT.CPF_PK_PLANTFOOT PK,
                FOOT.CPF_NOMBRE NOMBRE,
                FOOT.CPF_DESCRIPCION DESCRIPCION,
                FOOT.CPF_CONTENIDO CONTENIDO,                
                FOOT.CPF_FK_ESTADO EDO
            FROM
                PDIPIMP.CORCPLANTFOOT FOOT
            WHERE
                FOOT.CPF_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="agregarHeader" hint="Agrega una nueva plantilla header">
        <cfargument name="nombre" type="string"  required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc"  type="string"  required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string"  required="yes" hint="Contenido de la plantilla">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.GUARDAR_HEADER" datasource="DS_PDIPIMP">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#contenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
   </cffunction>

    <cffunction name="agregarFooter" hint="Agrega una nueva plantilla footer">
        <cfargument name="nombre" type="string"  required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc"  type="string"  required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string"  required="yes" hint="Contenido de la plantilla">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.GUARDAR_FOOTER" datasource="DS_PDIPIMP">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#contenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="editarHeader" hint="Edita una plantilla header">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
        <cfargument name="nombre" type="string"  required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc"  type="string"  required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string"  required="yes" hint="Contenido de la plantilla">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.EDITAR_HEADER" datasource="DS_PDIPIMP">
                <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#contenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="editarFooter" hint="Edita una plantilla footer">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
        <cfargument name="nombre" type="string"  required="yes" hint="Nombre de la plantilla">
        <cfargument name="desc"  type="string"  required="yes" hint="Descripcion de la plantilla">
        <cfargument name="contenido" type="string"  required="yes" hint="Contenido de la plantilla">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.EDITAR_FOOTER" datasource="DS_PDIPIMP">
                <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#desc#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#contenido#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="obtenerVistaHeader" hint="Obtiene vista previa de una plantilla header">
    <cfargument name="pkPlant" type="numeric" required="yes" hint="pk de la plantilla">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
                HEAD.CPH_CONTENIDO HEADER
            FROM
                PDIPIMP.CORCPLANTHEAD HEAD
            WHERE
                HEAD.CPH_PK_PLANTHEAD = #pkPlant#
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="obtenerVistaFooter" hint="Obtiene vista previa de una plantilla footer">
    <cfargument name="pkPlant" type="numeric" required="yes" hint="pk de la plantilla">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
                FOOT.CPF_CONTENIDO FOOTER
            FROM
                PDIPIMP.CORCPLANTFOOT FOOT
            WHERE
                FOOT.CPF_PK_PLANTFOOT = #pkPlant#
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="cambiarEstadoHeader" hint="Cambia el estado de una plantilla header">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.CAMBIAR_EDO_HEADER" datasource="DS_PDIPIMP">
                <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="cambiarEstadoFooter" hint="Cambia el estado de una plantilla footer">
        <cfargument name="pk" type="numeric" required="yes" hint="pk de la plantilla">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.CAMBIAR_EDO_FOOTER" datasource="DS_PDIPIMP">
                <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="obtieneHeaderCarrusel" hint="Obtiene las plantillas header del carrusel">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
                HEAD.CPH_PK_PLANTHEAD PK,
                HEAD.CPH_CONTENIDO HEADER
            FROM
                PDIPIMP.CORCPLANTHEAD HEAD
            WHERE
                HEAD.CPH_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="obtieneFooterCarrusel" hint="Obtiene las plantillas footer del carrusel">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
                FOOT.CPF_PK_PLANTFOOT PK,
                FOOT.CPF_CONTENIDO FOOTER
            FROM
                PDIPIMP.CORCPLANTFOOT FOOT
            WHERE
                FOOT.CPF_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="obtieneEtiquetas" hint="Obtiene las etiquetas disponibles para el correo">
        <cfargument name="pkBody" type="numeric" required="yes" hint="pk del correo">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT 
                ETIQ.CET_PK_ETIQUETA PK,
                ETIQ.CET_NOMBRE ETIQUETA
            FROM
                PDIPIMP.CORCETIQUETA ETIQ
            WHERE
                ETIQ.CET_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
                AND ETIQ.CET_FK_PLANTBODY = #pkBody#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="agregarEtiqueta" hint="Agrega una nueva etiqueta al correo">
        <cfargument name="pkBody" type="numeric" required="yes" hint="pk del correo al que pertenece">
        <cfargument name="nombre" type="string"  required="yes" hint="Nombre de la etiqueta">
        <cfargument name="descripcion" type="string"  required="yes" hint="Descripcion de la etiqueta">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.GUARDAR_ETIQUETA" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkBody#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#descripcion#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="cambiarEstadoEtiqueta" hint="Cambia el estado de una etiqueta">
        <cfargument name="pkEti" type="numeric" required="yes" hint="pk de la etiqueta">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.CAMBIAR_EDO_ETIQUETA" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkEti#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <cffunction name="guardar_historial" hint="guarda el correo en el historial">
        <cfargument name="pkCorreo"     type="numeric"  required="yes" hint="pk del tipo de correo">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="pk del usuario">
        <cfargument name="emaildestino" type="string"   required="yes" hint="email del remitente">
        <cfargument name="contenido"    type="string"   required="yes" hint="contenido del correo">
        <cfstoredproc procedure="PDIPIMP.P_ADMON_CORREOS.GUARDAR_HISTORIAL" datasource="DS_PDIPIMP">
            <cfprocparam value="#pkCorreo#"     cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkUsuario#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#emaildestino#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#contenido#"    cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <cffunction name="getHistorialCorreos" hint="Obtiene el historial de correos">
        <cfargument name="fechaInicio"  type="string" required="yes" hint="Fecha de inicio">
        <cfargument name="fechaFin"     type="string" required="yes" hint="Fecha de fin">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                BHC.BHC_PK_HISTORIALCORREO                                  AS PKHISTORIAL,
                CCO.CCO_NOMBRE                                              AS PLANTILLA,
                TUS.TUS_USUARIO_NOMBRE                                      AS NOMBRE,
                TUS.TUS_USUARIO_PATERNO                                     AS APPAT,
                TUS.TUS_USUARIO_MATERNO                                     AS APMAT,
                BHC.BHC_CORREO_DESTINO                                      AS DESTINO,
                TO_CHAR(BHC.BHC_FECHA_CREACION, 'DD/MM/YYYY HH24:MI:SS')    AS FECHA
            FROM
                CORBHISTORIALCORREO BHC,
                CORCCORREO          CCO,
                USRTUSUARIO         TUS

            WHERE
                CCO.CCO_PK_CORREO = BHC_FK_TIPO_CORREO
            AND
                TUS.TUS_PK_USUARIO = BHC.BHC_FK_USUARIO_MODIFICACION
            AND
                BHC_FK_ESTADO = 2
            <cfif fechaInicio neq '0/0/0'>
                AND
                    BHC.BHC_FECHA_CREACION >= TO_DATE(<cfqueryparam value="#fechaInicio#" cfsqltype="cf_sql_string">, 'DD/MM/YYYY')
            </cfif>         
            <cfif fechaFin neq '0/0/0'>
                AND
                    BHC.BHC_FECHA_CREACION <= TO_DATE(<cfqueryparam value="#fechaFin#" cfsqltype="cf_sql_string">||'23:59:59', 'DD/MM/YYYY HH24:MI:SS')
            </cfif>
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

    <cffunction name="getCorreo" hint="Obtiene el contenido del correo">
        <cfargument name="pkHistorial" type="numeric"  required="yes" hint="pk del historial">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                BHC.BHC_DESCRIPCION_CORREO  AS DESCRIPCION
            FROM
                CORBHISTORIALCORREO BHC

            WHERE
                BHC_FK_ESTADO = 2
            AND
                BHC.BHC_PK_HISTORIALCORREO = <cfqueryparam value="#pkHistorial#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qUsuarios>
    </cffunction>

</cfcomponent>