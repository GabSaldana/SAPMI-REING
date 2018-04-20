<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Administración de correos
* Fecha: Enero de 2017
* Descripcion: Acceso a datos para el envío de correos generados.
* Autor: SGS
============================================================================================
--->

<cfcomponent> 

    <!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
	<cffunction name="obtenerCorreo" returntype="query" hint="Obtiene un correo para hacer el envio">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT 
                HEAD.CPH_CONTENIDO HEADER,
                BODY.CPB_PK_PLANTBODY PKBODY,
                BODY.CPB_BODY BODY,
                FOOT.CPF_CONTENIDO FOOTER
            FROM
                GRAL.CORCPLANTHEAD HEAD,
                GRAL.CORCPLANTBODY BODY,
                GRAL.CORCPLANTFOOT FOOT
            WHERE
                BODY.CPB_FK_CORREO = #pkCorreo#
                AND BODY.CPB_FK_ESTADO = 2
                AND BODY.CPB_FK_PLANTHEAD = HEAD.CPH_PK_PLANTHEAD
                AND BODY.CPB_FK_PLANTFOOT = FOOT.CPF_PK_PLANTFOOT
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
    <cffunction name="obtenerEtiquetas" returntype="query" hint="Obtiene las etiquetas disponibles para el correo">
        <cfargument name="pkCorreo" type="numeric" required="yes" hint="pk del correo">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT 
                ETIQ.CET_PK_ETIQUETA PK,
                ETIQ.CET_NOMBRE ETIQUETA
            FROM
                GRAL.CORCETIQUETA ETIQ
            WHERE
                ETIQ.CET_FK_ESTADO = 2
                AND ETIQ.CET_FK_PLANTBODY = #pkCorreo#
            ORDER BY PK ASC
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

</cfcomponent>