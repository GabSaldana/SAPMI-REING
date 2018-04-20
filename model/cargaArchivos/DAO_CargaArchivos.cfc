<!---
* =====================================================================================
* IPN - CSII
* Sistema: Planeación 2018
* Modulo: Carga de archivos
* Fecha: abril de 2018
* Descripcion: componente de negocio para la administración de archivos
* =====================================================================================
--->

<cfcomponent>

    <cffunction name="consultarArchivoExistente" hint="Verifica si ya existe un archivo">
        <cfargument name="pkCatalogo"   hint="Pk del archivo en el catalogo">
        <cfargument name="pkRegistro"   hint="Pk del registro al que esta asociado">
        <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT  TAR.TAR_PK_ARCHIVO       AS PK
              FROM  PDIPIMP.DOCTARCHIVOS     TAR
             WHERE  TAR.TAR_FK_USUARIO = #pkRegistro#
                    AND TAR.TAR_FK_CARCHIVO = #pkCatalogo#
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

    <cffunction name="registrarArchivo" hint="Guarda un registro del archivo que se subió al FTP">
        <cfargument name="pkCatalogo"    hint="Pk del archivo en el catalogo">
        <cfargument name="pkUsuario"     hint="Pk del usuario">
        <cfargument name="descripcion"   hint="Descripcion del archivo">
        <cfargument name="pkEstado"      hint="Estado con el que se guarda el registro">
        <cfargument name="nombreArchivo" hint="Nombre del archivo">
        <cfargument name="pkRegistro"    hint="pk del registro">
        <cfscript>
            spArchivo = new storedproc();
            spArchivo.setDatasource("DS_PDIPIMP");
            spArchivo.setProcedure("P_ADMON_ARCHIVO.SUBIR_ARCHIVO");
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkCatalogo);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkRegistro);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkUsuario);
            spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=descripcion);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkEstado);
            spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=nombreArchivo);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
            result = spArchivo.execute();
            var success = result.getprocOutVariables().resultado;
            return success;
        </cfscript>
    </cffunction>

    <cffunction name="consultarNombreArchivo" hint="Obtiene el nombre de un archivo">
        <cfargument name="pkDoc"        hint="Pk del documento">
        <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT  TAR.TAR_NOMBRE_ARCHIVO  AS NOMBRE,
                    USR.TUS_FK_ROL          AS ROL
            FROM    PDIPIMP.DOCTARCHIVOS    TAR,
                    PDIPIMP.USRTUSUARIO     USR
            WHERE   TAR.TAR_PK_ARCHIVO = #pkDoc#
                    AND TAR.TAR_FK_ESTADO = 2
                    AND TAR.TAR_FK_USUARIO(+) = USR.TUS_PK_USUARIO
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

</cfcomponent>