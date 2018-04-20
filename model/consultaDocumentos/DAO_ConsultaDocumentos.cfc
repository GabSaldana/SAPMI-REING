<!---
* =========================================================================
* IPN - CSII
* Sistema: Planeación 2018
* Modulo: Carga de archivos
* Fecha : abril de 2018
* Descripcion: handler 
* =========================================================================
--->

<cfcomponent>

    <cffunction name="documentosComplementarios" hint="Obtiene los documentos complementarios de las encuestas">
        <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT  TAR.TAR_PK_ARCHIVO                      AS PK,
                    TO_CHAR(TAR.TAR_FECHA_ALTA,'DD/MM/YYY') AS FECHA,
                    TAR.TAR_NOMBRE_ARCHIVO                  AS NOMBRE,
                    USR.TUS_FK_ROL                          AS ROL
              FROM  PDIPIMP.DOCTARCHIVOS                    TAR,
                    PDIPIMP.USRTUSUARIO                     USR
             WHERE  TAR.TAR_FK_ESTADO = 2
                    AND TAR.TAR_FK_CARCHIVO = 3 -- pk del Documento complementario de encuesta
                    AND TAR.TAR_FK_USUARIO(+) = USR.TUS_PK_USUARIO
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

    

</cfcomponent>